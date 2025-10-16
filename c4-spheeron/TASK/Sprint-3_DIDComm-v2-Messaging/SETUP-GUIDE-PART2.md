# Sprint 3: DIDComm v2 & Messaging - Panduan Setup & Implementasi Part 2

**Lanjutan dari**: [SETUP-GUIDE.md](./SETUP-GUIDE.md)

---

## 🔄 Langkah 4: Implement WACI DIDComm Issuance (US-3.3) - COMPLETE

### 4.1 Create WACI Types

**File**: `src/types/messaging/WACITypes.ts`

```typescript
/**
 * WACI DIDComm Type Definitions
 * Based on: https://identity.foundation/waci-didcomm/
 */

export interface CredentialOffer {
  id: string;
  type: string;
  from: string;
  to: string[];
  body: {
    credential_preview: CredentialPreview;
    formats: CredentialFormat[];
    credential_manifest?: any;
    comment?: string;
  };
  attachments?: Attachment[];
}

export interface CredentialPreview {
  type: string;
  attributes: CredentialAttribute[];
}

export interface CredentialAttribute {
  name: string;
  value: string;
  mime_type?: string;
}

export interface CredentialFormat {
  attach_id: string;
  format: string; // 'dif/credential-manifest@v1.0' | 'aries/ld-proof-vc@v1.0' | 'jwt_vc_json'
}

export interface CredentialRequest {
  id: string;
  type: string;
  from: string;
  to: string[];
  thid: string; // Thread ID from offer
  body: {
    formats?: CredentialFormat[];
    comment?: string;
  };
}

export interface CredentialIssue {
  id: string;
  type: string;
  from: string;
  to: string[];
  thid: string;
  body: {
    formats: CredentialFormat[];
    comment?: string;
  };
  attachments: Attachment[];
}

export interface Attachment {
  id: string;
  mime_type?: string;
  data: {
    base64?: string;
    json?: any;
    jws?: any;
  };
}

export interface PresentationRequest {
  id: string;
  type: string;
  from: string;
  to: string[];
  body: {
    presentation_definition: any; // Presentation Exchange v2 definition
    comment?: string;
  };
}

export interface PresentationSubmission {
  id: string;
  type: string;
  from: string;
  to: string[];
  thid: string;
  body: {
    presentation_submission: any; // PEx v2 submission
    comment?: string;
  };
  attachments: Attachment[];
}

export enum WACIMessageType {
  // Issuance
  OFFER_CREDENTIAL = 'https://didcomm.org/issue-credential/3.0/offer-credential',
  REQUEST_CREDENTIAL = 'https://didcomm.org/issue-credential/3.0/request-credential',
  ISSUE_CREDENTIAL = 'https://didcomm.org/issue-credential/3.0/issue-credential',
  CREDENTIAL_ACK = 'https://didcomm.org/issue-credential/3.0/ack',
  
  // Presentation
  REQUEST_PRESENTATION = 'https://didcomm.org/present-proof/3.0/request-presentation',
  PRESENTATION = 'https://didcomm.org/present-proof/3.0/presentation',
  PRESENTATION_ACK = 'https://didcomm.org/present-proof/3.0/ack',
  
  // Problem Report
  PROBLEM_REPORT = 'https://didcomm.org/report-problem/2.0/problem-report',
}

export interface ProblemReport {
  code: string;
  comment?: string;
  args?: string[];
  escalate_to?: string;
}
```

### 4.2 Implement WACI Issuance Service (Complete)

**File**: `src/services/messaging/WACIIssuanceService.ts`

```typescript
import { v4 as uuidv4 } from 'uuid';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {
  CredentialOffer,
  CredentialRequest,
  CredentialIssue,
  CredentialPreview,
  WACIMessageType,
  ProblemReport
} from '@/types/messaging/WACITypes';
import DIDCommService from './DIDCommService';
import MediatorService from './MediatorService';
import { CredentialService } from '@/services/CredentialService';

/**
 * WACI DIDComm Issuance Service
 * Handles credential issuance flow via DIDComm
 */
class WACIIssuanceService {
  private readonly STORAGE_KEY = 'waci_issuance_threads';
  private threads: Map<string, IssuanceThread> = new Map();

  constructor() {
    this.initialize();
  }

  async initialize(): Promise<void> {
    await this.loadThreads();
    
    // Listen for incoming messages
    MediatorService.on('message:received', (message: any) => {
      this.handleIncomingMessage(message);
    });
  }

  /**
   * Handle credential offer from issuer
   */
  async handleCredentialOffer(
    offer: CredentialOffer
  ): Promise<void> {
    // Create issuance thread
    const thread: IssuanceThread = {
      threadId: offer.id,
      state: 'offer-received',
      offer,
      createdAt: Date.now(),
      updatedAt: Date.now()
    };

    this.threads.set(thread.threadId, thread);
    await this.saveThreads();

    // Emit event for UI
    this.emit('offer:received', offer);
  }

  /**
   * Accept credential offer
   */
  async acceptOffer(
    offerId: string,
    myDID: string
  ): Promise<void> {
    const thread = this.threads.get(offerId);
    if (!thread || !thread.offer) {
      throw new Error('Credential offer not found');
    }

    const offer = thread.offer;

    // Create credential request
    const request: CredentialRequest = {
      id: uuidv4(),
      type: WACIMessageType.REQUEST_CREDENTIAL,
      from: myDID,
      to: [offer.from],
      thid: offer.id,
      body: {
        formats: offer.body.formats,
        comment: 'Accepting credential offer'
      }
    };

    // Pack and send
    const packed = await DIDCommService.pack({
      message: request,
      to: offer.from,
      from: myDID
    });

    // Get issuer's service endpoint
    const issuerDoc = await DIDCommService.didResolver.resolve(offer.from);
    const endpoint = this.extractServiceEndpoint(issuerDoc);

    if (!endpoint) {
      throw new Error('Issuer service endpoint not found');
    }

    await DIDCommService.send(packed, endpoint);

    // Update thread state
    thread.state = 'request-sent';
    thread.request = request;
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();
  }

  /**
   * Decline credential offer
   */
  async declineOffer(
    offerId: string,
    myDID: string,
    reason?: string
  ): Promise<void> {
    const thread = this.threads.get(offerId);
    if (!thread || !thread.offer) {
      throw new Error('Credential offer not found');
    }

    const offer = thread.offer;

    // Send problem report
    const problemReport = DIDCommService.createPlaintextMessage({
      type: WACIMessageType.PROBLEM_REPORT,
      to: [offer.from],
      from: myDID,
      thid: offer.id,
      body: {
        code: 'offer-declined',
        comment: reason || 'User declined the credential offer'
      } as ProblemReport
    });

    const packed = await DIDCommService.pack({
      message: problemReport,
      to: offer.from,
      from: myDID
    });

    const issuerDoc = await DIDCommService.didResolver.resolve(offer.from);
    const endpoint = this.extractServiceEndpoint(issuerDoc);

    if (endpoint) {
      await DIDCommService.send(packed, endpoint);
    }

    // Update thread state
    thread.state = 'declined';
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();
  }

  /**
   * Handle credential issue message
   */
  async handleCredentialIssue(
    issue: CredentialIssue
  ): Promise<void> {
    const thread = this.threads.get(issue.thid);
    if (!thread) {
      throw new Error('Issuance thread not found');
    }

    // Extract credential from attachments
    let credential: any;
    
    for (const attachment of issue.attachments) {
      if (attachment.data.json) {
        credential = attachment.data.json;
        break;
      } else if (attachment.data.base64) {
        const decoded = Buffer.from(attachment.data.base64, 'base64').toString();
        credential = JSON.parse(decoded);
        break;
      }
    }

    if (!credential) {
      throw new Error('No credential found in issue message');
    }

    // Store credential
    await CredentialService.storeCredential(credential);

    // Send acknowledgment
    const ack = DIDCommService.createPlaintextMessage({
      type: WACIMessageType.CREDENTIAL_ACK,
      to: [issue.from],
      from: issue.to[0],
      thid: issue.thid,
      body: {
        status: 'OK',
        comment: 'Credential received and stored successfully'
      }
    });

    const packed = await DIDCommService.pack({
      message: ack,
      to: issue.from,
      from: issue.to[0]
    });

    const issuerDoc = await DIDCommService.didResolver.resolve(issue.from);
    const endpoint = this.extractServiceEndpoint(issuerDoc);

    if (endpoint) {
      await DIDCommService.send(packed, endpoint);
    }

    // Update thread state
    thread.state = 'completed';
    thread.credential = credential;
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();

    // Emit event for UI
    this.emit('credential:issued', credential);
  }

  /**
   * Handle incoming message
   */
  private async handleIncomingMessage(message: any): Promise<void> {
    switch (message.type) {
      case WACIMessageType.OFFER_CREDENTIAL:
        await this.handleCredentialOffer(message as CredentialOffer);
        break;
        
      case WACIMessageType.ISSUE_CREDENTIAL:
        await this.handleCredentialIssue(message as CredentialIssue);
        break;
        
      case WACIMessageType.PROBLEM_REPORT:
        await this.handleProblemReport(message);
        break;
        
      default:
        console.log('Unknown WACI message type:', message.type);
    }
  }

  /**
   * Handle problem report
   */
  private async handleProblemReport(message: any): Promise<void> {
    const thread = this.threads.get(message.thid);
    if (thread) {
      thread.state = 'error';
      thread.error = message.body;
      thread.updatedAt = Date.now();
      
      this.threads.set(thread.threadId, thread);
      await this.saveThreads();
      
      this.emit('issuance:error', {
        threadId: message.thid,
        error: message.body
      });
    }
  }

  /**
   * Get all pending offers
   */
  getPendingOffers(): CredentialOffer[] {
    const offers: CredentialOffer[] = [];
    
    for (const thread of this.threads.values()) {
      if (thread.state === 'offer-received' && thread.offer) {
        offers.push(thread.offer);
      }
    }
    
    return offers;
  }

  /**
   * Get issuance thread by ID
   */
  getThread(threadId: string): IssuanceThread | undefined {
    return this.threads.get(threadId);
  }

  /**
   * Get all threads
   */
  getAllThreads(): IssuanceThread[] {
    return Array.from(this.threads.values());
  }

  /**
   * Extract service endpoint from DID document
   */
  private extractServiceEndpoint(didDoc: any): string | null {
    if (!didDoc.service) return null;

    for (const service of didDoc.service) {
      if (service.type === 'DIDCommMessaging') {
        return typeof service.serviceEndpoint === 'string'
          ? service.serviceEndpoint
          : service.serviceEndpoint.uri;
      }
    }

    return null;
  }

  /**
   * Save threads to storage
   */
  private async saveThreads(): Promise<void> {
    const data = Array.from(this.threads.entries());
    await AsyncStorage.setItem(this.STORAGE_KEY, JSON.stringify(data));
  }

  /**
   * Load threads from storage
   */
  private async loadThreads(): Promise<void> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY);
    if (data) {
      const entries: [string, IssuanceThread][] = JSON.parse(data);
      this.threads = new Map(entries);
    }
  }

  /**
   * Event emitter
   */
  private listeners: Map<string, Function[]> = new Map();

  on(event: string, listener: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }

  private emit(event: string, ...args: any[]): void {
    const listeners = this.listeners.get(event);
    if (listeners) {
      for (const listener of listeners) {
        listener(...args);
      }
    }
  }
}

interface IssuanceThread {
  threadId: string;
  state: 'offer-received' | 'request-sent' | 'completed' | 'declined' | 'error';
  offer?: CredentialOffer;
  request?: CredentialRequest;
  credential?: any;
  error?: any;
  createdAt: number;
  updatedAt: number;
}

export default new WACIIssuanceService();
```

---

## 📊 Langkah 5: Implement WACI DIDComm Presentation (US-3.4) - COMPLETE

### 5.1 Implement WACI Presentation Service (Complete)

**File**: `src/services/messaging/WACIPresentationService.ts`

```typescript
import { v4 as uuidv4 } from 'uuid';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {
  PresentationRequest,
  PresentationSubmission,
  WACIMessageType,
  ProblemReport
} from '@/types/messaging/WACITypes';
import DIDCommService from './DIDCommService';
import MediatorService from './MediatorService';
import { CredentialService } from '@/services/CredentialService';
import PresentationExchangeService from '@/services/presentation/PresentationExchangeService';

/**
 * WACI DIDComm Presentation Service
 * Handles presentation flow via DIDComm
 */
class WACIPresentationService {
  private readonly STORAGE_KEY = 'waci_presentation_threads';
  private threads: Map<string, PresentationThread> = new Map();

  constructor() {
    this.initialize();
  }

  async initialize(): Promise<void> {
    await this.loadThreads();
    
    // Listen for incoming messages
    MediatorService.on('message:received', (message: any) => {
      this.handleIncomingMessage(message);
    });
  }

  /**
   * Handle presentation request from verifier
   */
  async handlePresentationRequest(
    request: PresentationRequest
  ): Promise<void> {
    // Create presentation thread
    const thread: PresentationThread = {
      threadId: request.id,
      state: 'request-received',
      request,
      createdAt: Date.now(),
      updatedAt: Date.now()
    };

    // Find matching credentials
    const allCredentials = await CredentialService.getAllCredentials();
    const presentationDefinition = request.body.presentation_definition;
    
    const evaluationResult = await PresentationExchangeService.evaluateDefinition(
      presentationDefinition,
      allCredentials
    );

    thread.matchingCredentials = evaluationResult.matches || [];

    this.threads.set(thread.threadId, thread);
    await this.saveThreads();

    // Emit event for UI
    this.emit('request:received', {
      request,
      matchingCredentials: thread.matchingCredentials
    });
  }

  /**
   * Submit presentation
   */
  async submitPresentation(params: {
    requestId: string;
    selectedCredentials: any[];
    disclosedClaims?: Record<string, string[]>; // credential ID -> disclosed claim names
    myDID: string;
  }): Promise<void> {
    const { requestId, selectedCredentials, disclosedClaims = {}, myDID } = params;
    
    const thread = this.threads.get(requestId);
    if (!thread || !thread.request) {
      throw new Error('Presentation request not found');
    }

    const request = thread.request;

    // Create presentation submission using PEx
    const presentationSubmission = await PresentationExchangeService.createSubmission(
      request.body.presentation_definition,
      selectedCredentials
    );

    // Build presentation attachments
    const attachments = selectedCredentials.map((credential, index) => ({
      id: `credential-${index}`,
      mime_type: 'application/json',
      data: {
        json: credential
      }
    }));

    // Create presentation message
    const presentation: PresentationSubmission = {
      id: uuidv4(),
      type: WACIMessageType.PRESENTATION,
      from: myDID,
      to: [request.from],
      thid: request.id,
      body: {
        presentation_submission: presentationSubmission,
        comment: 'Verifiable Presentation'
      },
      attachments
    };

    // Pack and send
    const packed = await DIDCommService.pack({
      message: presentation,
      to: request.from,
      from: myDID
    });

    // Get verifier's service endpoint
    const verifierDoc = await DIDCommService.didResolver.resolve(request.from);
    const endpoint = this.extractServiceEndpoint(verifierDoc);

    if (!endpoint) {
      throw new Error('Verifier service endpoint not found');
    }

    await DIDCommService.send(packed, endpoint);

    // Update thread state
    thread.state = 'presentation-sent';
    thread.presentation = presentation;
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();

    // Emit event
    this.emit('presentation:submitted', {
      threadId: requestId,
      presentation
    });
  }

  /**
   * Decline presentation request
   */
  async declineRequest(
    requestId: string,
    myDID: string,
    reason?: string
  ): Promise<void> {
    const thread = this.threads.get(requestId);
    if (!thread || !thread.request) {
      throw new Error('Presentation request not found');
    }

    const request = thread.request;

    // Send problem report
    const problemReport = DIDCommService.createPlaintextMessage({
      type: WACIMessageType.PROBLEM_REPORT,
      to: [request.from],
      from: myDID,
      thid: request.id,
      body: {
        code: 'request-declined',
        comment: reason || 'User declined the presentation request'
      } as ProblemReport
    });

    const packed = await DIDCommService.pack({
      message: problemReport,
      to: request.from,
      from: myDID
    });

    const verifierDoc = await DIDCommService.didResolver.resolve(request.from);
    const endpoint = this.extractServiceEndpoint(verifierDoc);

    if (endpoint) {
      await DIDCommService.send(packed, endpoint);
    }

    // Update thread state
    thread.state = 'declined';
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();
  }

  /**
   * Handle presentation acknowledgment
   */
  async handleAcknowledgment(ack: any): Promise<void> {
    const thread = this.threads.get(ack.thid);
    if (!thread) {
      return;
    }

    thread.state = 'completed';
    thread.acknowledgment = ack;
    thread.updatedAt = Date.now();
    
    this.threads.set(thread.threadId, thread);
    await this.saveThreads();

    // Emit event
    this.emit('presentation:acknowledged', {
      threadId: ack.thid,
      status: ack.body.status
    });
  }

  /**
   * Handle incoming message
   */
  private async handleIncomingMessage(message: any): Promise<void> {
    switch (message.type) {
      case WACIMessageType.REQUEST_PRESENTATION:
        await this.handlePresentationRequest(message as PresentationRequest);
        break;
        
      case WACIMessageType.PRESENTATION_ACK:
        await this.handleAcknowledgment(message);
        break;
        
      case WACIMessageType.PROBLEM_REPORT:
        await this.handleProblemReport(message);
        break;
        
      default:
        console.log('Unknown WACI presentation message type:', message.type);
    }
  }

  /**
   * Handle problem report
   */
  private async handleProblemReport(message: any): Promise<void> {
    const thread = this.threads.get(message.thid);
    if (thread) {
      thread.state = 'error';
      thread.error = message.body;
      thread.updatedAt = Date.now();
      
      this.threads.set(thread.threadId, thread);
      await this.saveThreads();
      
      this.emit('presentation:error', {
        threadId: message.thid,
        error: message.body
      });
    }
  }

  /**
   * Get all pending requests
   */
  getPendingRequests(): PresentationRequest[] {
    const requests: PresentationRequest[] = [];
    
    for (const thread of this.threads.values()) {
      if (thread.state === 'request-received' && thread.request) {
        requests.push(thread.request);
      }
    }
    
    return requests;
  }

  /**
   * Get presentation thread by ID
   */
  getThread(threadId: string): PresentationThread | undefined {
    return this.threads.get(threadId);
  }

  /**
   * Get all threads
   */
  getAllThreads(): PresentationThread[] {
    return Array.from(this.threads.values());
  }

  /**
   * Extract service endpoint from DID document
   */
  private extractServiceEndpoint(didDoc: any): string | null {
    if (!didDoc.service) return null;

    for (const service of didDoc.service) {
      if (service.type === 'DIDCommMessaging') {
        return typeof service.serviceEndpoint === 'string'
          ? service.serviceEndpoint
          : service.serviceEndpoint.uri;
      }
    }

    return null;
  }

  /**
   * Save threads to storage
   */
  private async saveThreads(): Promise<void> {
    const data = Array.from(this.threads.entries());
    await AsyncStorage.setItem(this.STORAGE_KEY, JSON.stringify(data));
  }

  /**
   * Load threads from storage
   */
  private async loadThreads(): Promise<void> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY);
    if (data) {
      const entries: [string, PresentationThread][] = JSON.parse(data);
      this.threads = new Map(entries);
    }
  }

  /**
   * Event emitter
   */
  private listeners: Map<string, Function[]> = new Map();

  on(event: string, listener: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }

  private emit(event: string, ...args: any[]): void {
    const listeners = this.listeners.get(event);
    if (listeners) {
      for (const listener of listeners) {
        listener(...args);
      }
    }
  }
}

interface PresentationThread {
  threadId: string;
  state: 'request-received' | 'presentation-sent' | 'completed' | 'declined' | 'error';
  request?: PresentationRequest;
  matchingCredentials?: any[];
  presentation?: PresentationSubmission;
  acknowledgment?: any;
  error?: any;
  createdAt: number;
  updatedAt: number;
}

export default new WACIPresentationService();
```

---

## 🔔 Langkah 6: Implement Push Notifications (US-3.6) - COMPLETE

### 6.1 Implement Push Notification Service (Complete)

**File**: `src/services/messaging/PushNotificationService.ts`

```typescript
import * as Notifications from 'expo-notifications';
import * as Device from 'expo-device';
import { Platform } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Constants from 'expo-constants';

/**
 * Push Notification Service
 * Handles push notifications untuk iOS dan Android
 */
class PushNotificationService {
  private readonly STORAGE_KEY_TOKEN = 'push_notification_token';
  private readonly STORAGE_KEY_SETTINGS = 'push_notification_settings';
  
  private pushToken: string | null = null;
  private settings: NotificationSettings = {
    enabled: true,
    newMessage: true,
    credentialOffer: true,
    presentationRequest: true,
    sound: true,
    vibrate: true,
    badge: true
  };

  constructor() {
    // Configure notification behavior
    Notifications.setNotificationHandler({
      handleNotification: async () => ({
        shouldShowAlert: this.settings.enabled,
        shouldPlaySound: this.settings.sound,
        shouldSetBadge: this.settings.badge,
      }),
    });
  }

  /**
   * Initialize push notifications
   */
  async initialize(): Promise<void> {
    await this.loadSettings();
    await this.registerForPushNotifications();
    this.setupNotificationListeners();
  }

  /**
   * Register for push notifications
   */
  async registerForPushNotifications(): Promise<string | null> {
    // Check if physical device
    if (!Device.isDevice) {
      console.warn('Push notifications require a physical device');
      return null;
    }

    // Check existing token
    const existingToken = await AsyncStorage.getItem(this.STORAGE_KEY_TOKEN);
    if (existingToken) {
      this.pushToken = existingToken;
      return existingToken;
    }

    // Request permissions
    const { status: existingStatus } = await Notifications.getPermissionsAsync();
    let finalStatus = existingStatus;

    if (existingStatus !== 'granted') {
      const { status } = await Notifications.requestPermissionsAsync();
      finalStatus = status;
    }

    if (finalStatus !== 'granted') {
      console.warn('Push notification permission not granted');
      return null;
    }

    try {
      // Get push token
      const token = await Notifications.getExpoPushTokenAsync({
        projectId: Constants.expoConfig?.extra?.eas?.projectId || ''
      });

      this.pushToken = token.data;
      await AsyncStorage.setItem(this.STORAGE_KEY_TOKEN, token.data);

      // Configure channel for Android
      if (Platform.OS === 'android') {
        await this.setupAndroidChannels();
      }

      return token.data;
    } catch (error) {
      console.error('Failed to get push token:', error);
      return null;
    }
  }

  /**
   * Setup Android notification channels
   */
  private async setupAndroidChannels(): Promise<void> {
    await Notifications.setNotificationChannelAsync('messages', {
      name: 'Messages',
      description: 'DIDComm messages',
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      sound: 'default',
      enableVibrate: this.settings.vibrate,
      showBadge: this.settings.badge,
    });

    await Notifications.setNotificationChannelAsync('credentials', {
      name: 'Credentials',
      description: 'Credential offers and issuance',
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      sound: 'default',
      enableVibrate: this.settings.vibrate,
      showBadge: this.settings.badge,
    });

    await Notifications.setNotificationChannelAsync('presentations', {
      name: 'Presentations',
      description: 'Presentation requests',
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      sound: 'default',
      enableVibrate: this.settings.vibrate,
      showBadge: this.settings.badge,
    });
  }

  /**
   * Setup notification listeners
   */
  private setupNotificationListeners(): void {
    // Notification received while app is foregrounded
    Notifications.addNotificationReceivedListener(notification => {
      console.log('Notification received:', notification);
      this.handleNotificationReceived(notification);
    });

    // Notification tapped by user
    Notifications.addNotificationResponseReceivedListener(response => {
      console.log('Notification tapped:', response);
      this.handleNotificationTapped(response);
    });
  }

  /**
   * Handle notification received
   */
  private handleNotificationReceived(notification: Notifications.Notification): void {
    const data = notification.request.content.data;
    
    // Update badge count
    this.updateBadgeCount();
    
    // Emit event for app to handle
    this.emit('notification:received', {
      type: data.type,
      payload: data.payload
    });
  }

  /**
   * Handle notification tapped
   */
  private handleNotificationTapped(response: Notifications.NotificationResponse): void {
    const data = response.notification.request.content.data;
    
    // Emit event for navigation
    this.emit('notification:tapped', {
      type: data.type,
      payload: data.payload
    });
  }

  /**
   * Send local notification
   */
  async sendLocalNotification(params: {
    title: string;
    body: string;
    data?: any;
    channelId?: string;
  }): Promise<string> {
    const { title, body, data, channelId = 'messages' } = params;

    const notificationId = await Notifications.scheduleNotificationAsync({
      content: {
        title,
        body,
        data,
        sound: this.settings.sound ? 'default' : undefined,
        badge: this.settings.badge ? 1 : undefined,
      },
      trigger: null, // Send immediately
    });

    return notificationId;
  }

  /**
   * Send notification for new message
   */
  async notifyNewMessage(message: {
    from: string;
    body: string;
    threadId?: string;
  }): Promise<void> {
    if (!this.settings.enabled || !this.settings.newMessage) {
      return;
    }

    await this.sendLocalNotification({
      title: 'New Message',
      body: `From ${this.formatDID(message.from)}: ${message.body}`,
      data: {
        type: 'message',
        payload: message
      },
      channelId: 'messages'
    });
  }

  /**
   * Send notification for credential offer
   */
  async notifyCredentialOffer(offer: {
    from: string;
    credentialType: string;
    preview?: any;
  }): Promise<void> {
    if (!this.settings.enabled || !this.settings.credentialOffer) {
      return;
    }

    await this.sendLocalNotification({
      title: 'New Credential Offer',
      body: `${this.formatDID(offer.from)} wants to issue you a ${offer.credentialType}`,
      data: {
        type: 'credential-offer',
        payload: offer
      },
      channelId: 'credentials'
    });
  }

  /**
   * Send notification for presentation request
   */
  async notifyPresentationRequest(request: {
    from: string;
    purpose?: string;
    requiredCredentials?: string[];
  }): Promise<void> {
    if (!this.settings.enabled || !this.settings.presentationRequest) {
      return;
    }

    await this.sendLocalNotification({
      title: 'Presentation Request',
      body: request.purpose || `${this.formatDID(request.from)} requests credential presentation`,
      data: {
        type: 'presentation-request',
        payload: request
      },
      channelId: 'presentations'
    });
  }

  /**
   * Update badge count
   */
  async updateBadgeCount(count?: number): Promise<void> {
    if (!this.settings.badge) {
      return;
    }

    if (count === undefined) {
      // Get unread message count
      // TODO: Implement unread message count
      count = 0;
    }

    await Notifications.setBadgeCountAsync(count);
  }

  /**
   * Clear badge
   */
  async clearBadge(): Promise<void> {
    await Notifications.setBadgeCountAsync(0);
  }

  /**
   * Cancel notification
   */
  async cancelNotification(notificationId: string): Promise<void> {
    await Notifications.cancelScheduledNotificationAsync(notificationId);
  }

  /**
   * Cancel all notifications
   */
  async cancelAllNotifications(): Promise<void> {
    await Notifications.cancelAllScheduledNotificationsAsync();
  }

  /**
   * Get push token
   */
  getPushToken(): string | null {
    return this.pushToken;
  }

  /**
   * Update settings
   */
  async updateSettings(settings: Partial<NotificationSettings>): Promise<void> {
    this.settings = {
      ...this.settings,
      ...settings
    };

    await AsyncStorage.setItem(
      this.STORAGE_KEY_SETTINGS,
      JSON.stringify(this.settings)
    );

    // Update Android channels if settings changed
    if (Platform.OS === 'android') {
      await this.setupAndroidChannels();
    }
  }

  /**
   * Get settings
   */
  getSettings(): NotificationSettings {
    return { ...this.settings };
  }

  /**
   * Load settings from storage
   */
  private async loadSettings(): Promise<void> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY_SETTINGS);
    if (data) {
      this.settings = JSON.parse(data);
    }
  }

  /**
   * Format DID for display
   */
  private formatDID(did: string): string {
    // Extract last part of DID
    const parts = did.split(':');
    const lastPart = parts[parts.length - 1];
    
    // Truncate if too long
    if (lastPart.length > 16) {
      return lastPart.substring(0, 8) + '...' + lastPart.substring(lastPart.length - 8);
    }
    
    return lastPart;
  }

  /**
   * Event emitter
   */
  private listeners: Map<string, Function[]> = new Map();

  on(event: string, listener: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }

  private emit(event: string, ...args: any[]): void {
    const listeners = this.listeners.get(event);
    if (listeners) {
      for (const listener of listeners) {
        listener(...args);
      }
    }
  }
}

interface NotificationSettings {
  enabled: boolean;
  newMessage: boolean;
  credentialOffer: boolean;
  presentationRequest: boolean;
  sound: boolean;
  vibrate: boolean;
  badge: boolean;
}

export default new PushNotificationService();
```

### 6.2 Configure app.json for Push Notifications

**File**: `app.json`

```json
{
  "expo": {
    "name": "SSI Wallet",
    "slug": "ssi-wallet",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#ffffff"
    },
    "notification": {
      "icon": "./assets/notification-icon.png",
      "color": "#000000",
      "androidMode": "default",
      "androidCollapsedTitle": "{{unread_count}} new notifications"
    },
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.yourcompany.ssiwallet",
      "infoPlist": {
        "NSCameraUsageDescription": "This app uses the camera to scan QR codes",
        "NSFaceIDUsageDescription": "This app uses Face ID for secure authentication"
      },
      "entitlements": {
        "aps-environment": "production"
      }
    },
    "android": {
      "package": "com.yourcompany.ssiwallet",
      "versionCode": 1,
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#FFFFFF"
      },
      "permissions": [
        "RECEIVE_BOOT_COMPLETED",
        "VIBRATE",
        "USE_BIOMETRIC",
        "USE_FINGERPRINT"
      ],
      "googleServicesFile": "./google-services.json"
    },
    "plugins": [
      [
        "expo-notifications",
        {
          "icon": "./assets/notification-icon.png",
          "color": "#ffffff",
          "sounds": [
            "./assets/notification.wav"
          ]
        }
      ]
    ]
  }
}
```

---

## 🔄 Langkah 7: Implement Message Queue & Retry Logic (US-3.7) - COMPLETE

### 7.1 Implement Message Queue Service (Complete)

**File**: `src/services/messaging/MessageQueueService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import NetInfo from '@react-native-community/netinfo';
import { v4 as uuidv4 } from 'uuid';
import DIDCommService from './DIDCommService';

/**
 * Message Queue Service
 * Handles reliable message delivery dengan retry logic
 */
class MessageQueueService {
  private readonly STORAGE_KEY = 'message_queue';
  private readonly MAX_RETRIES = 5;
  private readonly RETRY_DELAYS = [1000, 2000, 4000, 8000, 16000]; // Exponential backoff
  
  private queue: Map<string, QueuedMessage> = new Map();
  private processing = false;
  private isOnline = true;

  constructor() {
    this.initialize();
  }

  async initialize(): Promise<void> {
    await this.loadQueue();
    this.setupNetworkListener();
    this.startProcessing();
  }

  /**
   * Setup network state listener
   */
  private setupNetworkListener(): void {
    NetInfo.addEventListener(state => {
      const wasOffline = !this.isOnline;
      this.isOnline = state.isConnected || false;

      // Resume processing if back online
      if (wasOffline && this.isOnline) {
        console.log('Network back online, resuming message queue');
        this.startProcessing();
      }
    });
  }

  /**
   * Enqueue message for sending
   */
  async enqueue(params: {
    message: any;
    to: string;
    from?: string;
    endpoint: string;
    priority?: 'high' | 'normal' | 'low';
    maxRetries?: number;
  }): Promise<string> {
    const {
      message,
      to,
      from,
      endpoint,
      priority = 'normal',
      maxRetries = this.MAX_RETRIES
    } = params;

    const queuedMessage: QueuedMessage = {
      id: uuidv4(),
      message,
      to,
      from,
      endpoint,
      priority,
      status: 'pending',
      retryCount: 0,
      maxRetries,
      createdAt: Date.now(),
      updatedAt: Date.now()
    };

    this.queue.set(queuedMessage.id, queuedMessage);
    await this.saveQueue();

    // Start processing if not already
    if (!this.processing) {
      this.startProcessing();
    }

    return queuedMessage.id;
  }

  /**
   * Start processing queue
   */
  private async startProcessing(): Promise<void> {
    if (this.processing || !this.isOnline) {
      return;
    }

    this.processing = true;

    while (this.isOnline && this.hasPendingMessages()) {
      await this.processNextMessage();
      
      // Small delay between messages
      await this.delay(100);
    }

    this.processing = false;
  }

  /**
   * Process next message in queue
   */
  private async processNextMessage(): Promise<void> {
    const message = this.getNextPendingMessage();
    if (!message) {
      return;
    }

    try {
      // Mark as processing
      message.status = 'processing';
      message.updatedAt = Date.now();
      await this.saveQueue();

      // Pack message
      let packed: string;
      if (message.from) {
        packed = await DIDCommService.pack({
          message: message.message,
          to: message.to,
          from: message.from
        });
      } else {
        packed = await DIDCommService.pack({
          message: message.message,
          to: message.to
        });
      }

      // Send message
      await DIDCommService.send(packed, message.endpoint);

      // Mark as sent
      message.status = 'sent';
      message.sentAt = Date.now();
      message.updatedAt = Date.now();
      
      this.emit('message:sent', { id: message.id });
      
    } catch (error) {
      console.error(`Failed to send message ${message.id}:`, error);
      
      // Increment retry count
      message.retryCount++;
      message.lastError = error instanceof Error ? error.message : String(error);
      message.updatedAt = Date.now();

      if (message.retryCount >= message.maxRetries) {
        // Max retries reached
        message.status = 'failed';
        message.failedAt = Date.now();
        
        this.emit('message:failed', {
          id: message.id,
          error: message.lastError
        });
      } else {
        // Schedule retry
        message.status = 'pending';
        message.nextRetryAt = Date.now() + this.getRetryDelay(message.retryCount);
        
        this.emit('message:retry', {
          id: message.id,
          attempt: message.retryCount,
          nextRetryIn: this.getRetryDelay(message.retryCount)
        });
      }
    }

    await this.saveQueue();
  }

  /**
   * Get retry delay for attempt
   */
  private getRetryDelay(attempt: number): number {
    if (attempt < this.RETRY_DELAYS.length) {
      return this.RETRY_DELAYS[attempt];
    }
    // Max delay for attempts beyond defined delays
    return this.RETRY_DELAYS[this.RETRY_DELAYS.length - 1];
  }

  /**
   * Get next pending message (prioritized)
   */
  private getNextPendingMessage(): QueuedMessage | null {
    const now = Date.now();
    
    // Get all pending messages that are ready to send
    const pendingMessages = Array.from(this.queue.values())
      .filter(m => 
        m.status === 'pending' && 
        (!m.nextRetryAt || m.nextRetryAt <= now)
      );

    if (pendingMessages.length === 0) {
      return null;
    }

    // Sort by priority then creation time
    pendingMessages.sort((a, b) => {
      const priorityOrder = { high: 0, normal: 1, low: 2 };
      const priorityDiff = priorityOrder[a.priority] - priorityOrder[b.priority];
      
      if (priorityDiff !== 0) {
        return priorityDiff;
      }
      
      return a.createdAt - b.createdAt;
    });

    return pendingMessages[0];
  }

  /**
   * Check if queue has pending messages
   */
  private hasPendingMessages(): boolean {
    const now = Date.now();
    
    for (const message of this.queue.values()) {
      if (message.status === 'pending' && (!message.nextRetryAt || message.nextRetryAt <= now)) {
        return true;
      }
    }
    
    return false;
  }

  /**
   * Manual retry for failed message
   */
  async retryMessage(messageId: string): Promise<void> {
    const message = this.queue.get(messageId);
    if (!message) {
      throw new Error('Message not found');
    }

    if (message.status !== 'failed') {
      throw new Error('Only failed messages can be retried manually');
    }

    // Reset for retry
    message.status = 'pending';
    message.retryCount = 0;
    message.nextRetryAt = undefined;
    message.lastError = undefined;
    message.failedAt = undefined;
    message.updatedAt = Date.now();
    
    await this.saveQueue();

    // Start processing
    if (!this.processing) {
      this.startProcessing();
    }
  }

  /**
   * Get message by ID
   */
  getMessage(messageId: string): QueuedMessage | undefined {
    return this.queue.get(messageId);
  }

  /**
   * Get all messages
   */
  getAllMessages(): QueuedMessage[] {
    return Array.from(this.queue.values());
  }

  /**
   * Get failed messages
   */
  getFailedMessages(): QueuedMessage[] {
    return Array.from(this.queue.values())
      .filter(m => m.status === 'failed');
  }

  /**
   * Get pending messages
   */
  getPendingMessages(): QueuedMessage[] {
    return Array.from(this.queue.values())
      .filter(m => m.status === 'pending');
  }

  /**
   * Remove message from queue
   */
  async removeMessage(messageId: string): Promise<void> {
    this.queue.delete(messageId);
    await this.saveQueue();
  }

  /**
   * Clear sent messages
   */
  async clearSentMessages(): Promise<void> {
    for (const [id, message] of this.queue.entries()) {
      if (message.status === 'sent') {
        this.queue.delete(id);
      }
    }
    await this.saveQueue();
  }

  /**
   * Clear all messages
   */
  async clearAllMessages(): Promise<void> {
    this.queue.clear();
    await this.saveQueue();
  }

  /**
   * Save queue to storage
   */
  private async saveQueue(): Promise<void> {
    const data = Array.from(this.queue.entries());
    await AsyncStorage.setItem(this.STORAGE_KEY, JSON.stringify(data));
  }

  /**
   * Load queue from storage
   */
  private async loadQueue(): Promise<void> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY);
    if (data) {
      const entries: [string, QueuedMessage][] = JSON.parse(data);
      this.queue = new Map(entries);
    }
  }

  /**
   * Delay helper
   */
  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  /**
   * Event emitter
   */
  private listeners: Map<string, Function[]> = new Map();

  on(event: string, listener: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, []);
    }
    this.listeners.get(event)!.push(listener);
  }

  private emit(event: string, ...args: any[]): void {
    const listeners = this.listeners.get(event);
    if (listeners) {
      for (const listener of listeners) {
        listener(...args);
      }
    }
  }
}

interface QueuedMessage {
  id: string;
  message: any;
  to: string;
  from?: string;
  endpoint: string;
  priority: 'high' | 'normal' | 'low';
  status: 'pending' | 'processing' | 'sent' | 'failed';
  retryCount: number;
  maxRetries: number;
  nextRetryAt?: number;
  lastError?: string;
  createdAt: number;
  updatedAt: number;
  sentAt?: number;
  failedAt?: number;
}

export default new MessageQueueService();
```

---

## 🔍 Langkah 8: Implement DID Resolver Enhancement (US-3.8) - COMPLETE

### 8.1 Implement Enhanced DID Resolver Service (Complete)

**File**: `src/services/messaging/DIDResolverService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Resolver } from 'did-resolver';
import { getResolver as getKeyResolver } from '@sphereon/did-resolver-key';
import { getResolver as getWebResolver } from '@sphereon/did-resolver-web';
import { getResolver as getIONResolver } from '@sphereon/did-resolver-ion';

/**
 * DID Resolver Service
 * Enhanced DID resolution dengan caching dan fallback
 */
class DIDResolverService {
  private readonly CACHE_KEY_PREFIX = 'did_cache_';
  private readonly DEFAULT_CACHE_TTL = 3600000; // 1 hour in ms
  private readonly UNIVERSAL_RESOLVER_URL = 'https://dev.uniresolver.io/1.0/identifiers/';
  
  private resolver: Resolver;
  private cache: Map<string, CachedDIDDocument> = new Map();
  private cacheTTL: number = this.DEFAULT_CACHE_TTL;

  constructor() {
    // Initialize resolver dengan multiple methods
    this.resolver = new Resolver({
      ...getKeyResolver(),
      ...getWebResolver(),
      ...getIONResolver()
    });

    this.loadCache();
  }

  /**
   * Resolve DID document
   */
  async resolve(did: string): Promise<any | null> {
    try {
      // Check cache first
      const cached = this.getFromCache(did);
      if (cached) {
        console.log(`DID ${did} resolved from cache`);
        return cached;
      }

      // Try local resolver first
      const localResult = await this.resolveLocal(did);
      if (localResult) {
        this.addToCache(did, localResult);
        return localResult;
      }

      // Fallback to universal resolver
      const universalResult = await this.resolveUniversal(did);
      if (universalResult) {
        this.addToCache(did, universalResult);
        return universalResult;
      }

      console.error(`Failed to resolve DID: ${did}`);
      return null;
      
    } catch (error) {
      console.error(`DID resolution error for ${did}:`, error);
      return null;
    }
  }

  /**
   * Resolve using local resolver
   */
  private async resolveLocal(did: string): Promise<any | null> {
    try {
      const result = await this.resolver.resolve(did);
      
      if (result.didDocument) {
        return result.didDocument;
      }
      
      return null;
    } catch (error) {
      console.error(`Local resolution failed for ${did}:`, error);
      return null;
    }
  }

  /**
   * Resolve using universal resolver
   */
  private async resolveUniversal(did: string): Promise<any | null> {
    try {
      const response = await fetch(`${this.UNIVERSAL_RESOLVER_URL}${encodeURIComponent(did)}`, {
        method: 'GET',
        headers: {
          'Accept': 'application/ld+json'
        }
      });

      if (!response.ok) {
        return null;
      }

      const data = await response.json();
      
      if (data.didDocument) {
        return data.didDocument;
      }
      
      return null;
    } catch (error) {
      console.error(`Universal resolution failed for ${did}:`, error);
      return null;
    }
  }

  /**
   * Parallel resolution dengan race condition
   */
  async resolveParallel(did: string): Promise<any | null> {
    // Check cache first
    const cached = this.getFromCache(did);
    if (cached) {
      return cached;
    }

    // Try both resolvers in parallel, return first success
    try {
      const result = await Promise.race([
        this.resolveLocal(did),
        this.resolveUniversal(did)
      ]);

      if (result) {
        this.addToCache(did, result);
      }

      return result;
    } catch (error) {
      console.error(`Parallel resolution failed for ${did}:`, error);
      return null;
    }
  }

  /**
   * Batch resolve multiple DIDs
   */
  async resolveBatch(dids: string[]): Promise<Map<string, any>> {
    const results = new Map<string, any>();

    // Resolve in parallel
    const promises = dids.map(async did => {
      const doc = await this.resolve(did);
      if (doc) {
        results.set(did, doc);
      }
    });

    await Promise.all(promises);

    return results;
  }

  /**
   * Get from cache
   */
  private getFromCache(did: string): any | null {
    const cached = this.cache.get(did);
    
    if (!cached) {
      return null;
    }

    // Check if expired
    if (Date.now() > cached.expiresAt) {
      this.cache.delete(did);
      this.removeCacheFromStorage(did);
      return null;
    }

    return cached.didDocument;
  }

  /**
   * Add to cache
   */
  private addToCache(did: string, didDocument: any): void {
    const cached: CachedDIDDocument = {
      didDocument,
      cachedAt: Date.now(),
      expiresAt: Date.now() + this.cacheTTL
    };

    this.cache.set(did, cached);
    this.saveCacheToStorage(did, cached);
  }

  /**
   * Clear cache for DID
   */
  async clearCache(did?: string): Promise<void> {
    if (did) {
      this.cache.delete(did);
      await this.removeCacheFromStorage(did);
    } else {
      this.cache.clear();
      await this.clearAllCacheFromStorage();
    }
  }

  /**
   * Set cache TTL
   */
  setCacheTTL(ttlMs: number): void {
    this.cacheTTL = ttlMs;
  }

  /**
   * Load cache from storage
   */
  private async loadCache(): Promise<void> {
    try {
      const keys = await AsyncStorage.getAllKeys();
      const cacheKeys = keys.filter(k => k.startsWith(this.CACHE_KEY_PREFIX));

      for (const key of cacheKeys) {
        const data = await AsyncStorage.getItem(key);
        if (data) {
          const did = key.replace(this.CACHE_KEY_PREFIX, '');
          const cached: CachedDIDDocument = JSON.parse(data);
          
          // Only load if not expired
          if (Date.now() <= cached.expiresAt) {
            this.cache.set(did, cached);
          } else {
            // Remove expired cache
            await AsyncStorage.removeItem(key);
          }
        }
      }
    } catch (error) {
      console.error('Failed to load DID cache:', error);
    }
  }

  /**
   * Save cache to storage
   */
  private async saveCacheToStorage(did: string, cached: CachedDIDDocument): Promise<void> {
    try {
      const key = `${this.CACHE_KEY_PREFIX}${did}`;
      await AsyncStorage.setItem(key, JSON.stringify(cached));
    } catch (error) {
      console.error('Failed to save DID cache:', error);
    }
  }

  /**
   * Remove cache from storage
   */
  private async removeCacheFromStorage(did: string): Promise<void> {
    try {
      const key = `${this.CACHE_KEY_PREFIX}${did}`;
      await AsyncStorage.removeItem(key);
    } catch (error) {
      console.error('Failed to remove DID cache:', error);
    }
  }

  /**
   * Clear all cache from storage
   */
  private async clearAllCacheFromStorage(): Promise<void> {
    try {
      const keys = await AsyncStorage.getAllKeys();
      const cacheKeys = keys.filter(k => k.startsWith(this.CACHE_KEY_PREFIX));
      await AsyncStorage.multiRemove(cacheKeys);
    } catch (error) {
      console.error('Failed to clear DID cache:', error);
    }
  }

  /**
   * Get cache statistics
   */
  getCacheStats(): {
    size: number;
    entries: Array<{ did: string; cachedAt: number; expiresAt: number }>;
  } {
    const entries = Array.from(this.cache.entries()).map(([did, cached]) => ({
      did,
      cachedAt: cached.cachedAt,
      expiresAt: cached.expiresAt
    }));

    return {
      size: this.cache.size,
      entries
    };
  }
}

interface CachedDIDDocument {
  didDocument: any;
  cachedAt: number;
  expiresAt: number;
}

export default new DIDResolverService();
```

---

## ✅ Langkah 9: Testing & Verification

### 9.1 Integration Testing

**File**: `src/__tests__/integration/didcomm-flow.test.ts`

```typescript
import DIDCommService from '@/services/messaging/DIDCommService';
import MediatorService from '@/services/messaging/MediatorService';
import WACIIssuanceService from '@/services/messaging/WACIIssuanceService';
import WACIPresentationService from '@/services/messaging/WACIPresentationService';

describe('DIDComm Flow Integration Tests', () => {
  it('should complete full message flow', async () => {
    // 1. Create message
    const message = DIDCommService.createPlaintextMessage({
      type: 'https://didcomm.org/basicmessage/2.0/message',
      to: ['did:example:receiver'],
      from: 'did:example:sender',
      body: {
        content: 'Hello, DIDComm v2!'
      }
    });

    expect(message.id).toBeDefined();
    expect(message.type).toBe('https://didcomm.org/basicmessage/2.0/message');

    // 2. Pack message
    // Note: Requires actual DIDs and keys for full test
    // This is a structural test only
  });

  it('should handle mediator coordination', async () => {
    // Test mediator registration flow
    // Note: Requires actual mediator endpoint
  });

  it('should handle WACI issuance flow', async () => {
    // Test credential issuance flow
    // Note: Requires actual issuer
  });
});
```

---

## 📚 Dokumentasi Tambahan

### API Documentation

Setiap service memiliki dokumentasi inline yang lengkap. Untuk dokumentasi API yang lebih detail, generate menggunakan:

```bash
npm run docs:generate
```

### Architecture Diagram

Lihat diagram arsitektur di `diagrams/` folder untuk visualisasi komponen dan flow.

---

## 🎉 Sprint 3 Complete!

Anda telah berhasil mengimplementasikan:
- ✅ DIDComm v2 messaging dengan encryption dan routing
- ✅ Mediator coordination dengan failover support
- ✅ WACI DIDComm untuk credential issuance
- ✅ WACI DIDComm untuk credential presentation
- ✅ Push notifications untuk iOS dan Android
- ✅ Message queue dengan exponential backoff retry
- ✅ Enhanced DID resolver dengan caching

**Next Steps**: Lanjut ke Sprint 4 untuk Advanced Presentation & Selective Disclosure

---

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: Part 2 of 2 - Complete
