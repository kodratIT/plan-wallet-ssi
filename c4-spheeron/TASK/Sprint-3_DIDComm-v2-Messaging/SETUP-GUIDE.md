# Sprint 3: DIDComm v2 & Messaging - Panduan Setup & Implementasi Lengkap

## 📋 Ikhtisar

Panduan implementasi LENGKAP dan DETAIL untuk Sprint 3: DIDComm v2 messaging, WACI DIDComm untuk credential issuance dan presentation, mediator coordination, push notifications, message queue, dan DID resolution.

**Kompleksitas**: TINGGI - Advanced messaging protocols dan real-time communication  
**Estimasi Waktu**: 4 minggu (160 jam)  
**Prasyarat**: Pemahaman kuat tentang DIDComm, cryptography, dan messaging patterns

---

## 🎯 Prasyarat

Sebelum memulai Sprint 3, pastikan:
- ✅ Sprint 2 selesai (Credential management ready)
- ✅ Project berjalan tanpa error
- ✅ Pemahaman DIDComm v1 (jika ada)
- ✅ Pemahaman dasar WebSocket dan real-time communication
- ✅ Firebase project sudah dibuat (untuk FCM)
- ✅ APNs certificates ready (untuk iOS push notifications)
- ✅ Git repository up to date

---

## 📦 Langkah 1: Install Dependencies (Detail)

### 1.1 Install DIDComm Libraries

```bash
# DIDComm v2 Core
npm install @sphereon/ssi-sdk-didcomm-v2
npm install @sphereon/ssi-sdk-core

# DID Resolution
npm install @sphereon/did-resolver-universal
npm install @sphereon/did-resolver-key
npm install @sphereon/did-resolver-web
npm install @sphereon/did-resolver-ion

# DIDComm Utilities
npm install did-jwt
npm install did-resolver
npm install multibase
npm install multiformats
```

### 1.2 Install Messaging Libraries

```bash
# Push Notifications
npm install expo-notifications
npm install expo-device

# Firebase (untuk FCM Android)
npm install @react-native-firebase/app
npm install @react-native-firebase/messaging

# WebSocket (untuk live delivery)
npm install socket.io-client
npm install @types/socket.io-client --save-dev

# Network Detection
npm install @react-native-community/netinfo
```

### 1.3 Install Supporting Libraries

```bash
# Async Storage (untuk queue dan cache)
npm install @react-native-async-storage/async-storage

# UUID Generation
npm install uuid
npm install @types/uuid --save-dev

# Date Utilities
npm install date-fns

# Deep Linking
npm install expo-linking

# Background Tasks
npm install expo-task-manager
npm install expo-background-fetch
```

### 1.4 Update Package.json

```json
{
  "dependencies": {
    "@sphereon/ssi-sdk-didcomm-v2": "^0.9.0",
    "@sphereon/ssi-sdk-core": "^0.9.0",
    "@sphereon/did-resolver-universal": "^0.6.0",
    "@sphereon/did-resolver-key": "^0.6.0",
    "@sphereon/did-resolver-web": "^0.6.0",
    "@sphereon/did-resolver-ion": "^0.6.0",
    "did-jwt": "^6.11.0",
    "did-resolver": "^4.1.0",
    "expo-notifications": "~0.20.0",
    "expo-device": "~5.4.0",
    "@react-native-firebase/app": "^18.0.0",
    "@react-native-firebase/messaging": "^18.0.0",
    "socket.io-client": "^4.6.0",
    "@react-native-community/netinfo": "^9.4.0",
    "@react-native-async-storage/async-storage": "^1.19.0",
    "uuid": "^9.0.0",
    "date-fns": "^2.30.0",
    "expo-linking": "~5.0.0"
  },
  "devDependencies": {
    "@types/uuid": "^9.0.0",
    "@types/socket.io-client": "^3.0.0"
  }
}
```

### 1.5 Platform-Specific Setup

#### iOS Setup

**File**: `ios/Podfile`
```ruby
# Pastikan sudah ada
platform :ios, '13.0'

# Tambahkan di target 'YourApp' do
pod 'Firebase/Messaging'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

Install pods:
```bash
cd ios
pod install
cd ..
```

**Enable Push Notifications di Xcode**:
1. Buka `ios/YourApp.xcworkspace` di Xcode
2. Select target → Signing & Capabilities
3. Klik "+ Capability" → Add "Push Notifications"
4. Klik "+ Capability" → Add "Background Modes"
5. Check: "Remote notifications" dan "Background fetch"

#### Android Setup

**File**: `android/app/build.gradle`
```gradle
apply plugin: 'com.google.gms.google-services'

dependencies {
    // Firebase
    implementation platform('com.google.firebase:firebase-bom:32.0.0')
    implementation 'com.google.firebase:firebase-messaging'
}
```

**File**: `android/build.gradle`
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

**Tambahkan google-services.json**:
1. Download dari Firebase Console
2. Simpan di `android/app/google-services.json`

### 1.6 Verify Installation

**File**: `scripts/verify-sprint3-deps.ts`

```typescript
#!/usr/bin/env ts-node

async function verifyDependencies() {
  console.log('Verifying Sprint 3 dependencies...\n');
  
  const deps = [
    '@sphereon/ssi-sdk-didcomm-v2',
    '@sphereon/did-resolver-universal',
    'expo-notifications',
    'socket.io-client',
    '@react-native-community/netinfo',
    'uuid'
  ];

  let allInstalled = true;
  
  for (const dep of deps) {
    try {
      require(dep);
      console.log(`✅ ${dep}`);
    } catch (error) {
      console.error(`❌ ${dep} - NOT INSTALLED`);
      allInstalled = false;
    }
  }
  
  if (allInstalled) {
    console.log('\n✅ All dependencies verified successfully!');
  } else {
    console.error('\n❌ Some dependencies are missing. Please install them.');
    process.exit(1);
  }
}

verifyDependencies();
```

Run verification:
```bash
chmod +x scripts/verify-sprint3-deps.ts
npm run verify:sprint3
```

---

## 🔐 Langkah 2: Implement DIDComm v2 Service (US-3.1) - COMPLETE

### 2.1 Create Service Structure

```bash
mkdir -p src/services/messaging
mkdir -p src/types/messaging
mkdir -p src/utils/didcomm
mkdir -p src/__tests__/services/messaging
```

### 2.2 Create DIDComm v2 Types

**File**: `src/types/messaging/DIDCommTypes.ts`

```typescript
/**
 * DIDComm v2 Type Definitions
 * Based on: https://identity.foundation/didcomm-messaging/spec/
 */

export interface DIDCommMessage {
  id: string;
  type: string;
  from?: string;
  to?: string[];
  thid?: string; // Thread ID
  pthid?: string; // Parent Thread ID
  created_time?: number;
  expires_time?: number;
  body: Record<string, any>;
  attachments?: Attachment[];
  [key: string]: any;
}

export interface PlaintextMessage extends DIDCommMessage {
  // Plaintext message (not encrypted)
}

export interface EncryptedMessage {
  ciphertext: string;
  protected: string;
  recipients: Recipient[];
  tag: string;
  iv: string;
}

export interface Recipient {
  encrypted_key: string;
  header: {
    kid: string;
    alg?: string;
    [key: string]: any;
  };
}

export interface Attachment {
  id?: string;
  description?: string;
  filename?: string;
  media_type?: string;
  format?: string;
  lastmod_time?: number;
  byte_count?: number;
  data: AttachmentData;
}

export interface AttachmentData {
  base64?: string;
  json?: any;
  links?: string[];
  jws?: any;
  hash?: string;
}

export interface ForwardMessage extends DIDCommMessage {
  type: 'https://didcomm.org/routing/2.0/forward';
  to: string[];
  body: {
    next: string;
  };
  attachments: [{
    data: {
      json: EncryptedMessage;
    };
  }];
}

export interface PackOptions {
  message: PlaintextMessage;
  to: string; // Recipient DID
  from?: string; // Sender DID
  signFrom?: string; // Signing key DID
  encAlgAnon?: string; // Anonymous encryption algorithm
  encAlgAuth?: string; // Authenticated encryption algorithm
  protectSender?: boolean;
  forward?: boolean;
}

export interface UnpackOptions {
  message: string | EncryptedMessage;
}

export interface UnpackResult {
  message: PlaintextMessage;
  metadata: {
    encrypted: boolean;
    authenticated: boolean;
    non_repudiation: boolean;
    anonymous_sender: boolean;
    re_wrapped_in_forward?: boolean;
  };
}

export interface DIDCommService {
  id: string;
  type: string;
  serviceEndpoint: string | ServiceEndpoint;
  routingKeys?: string[];
  accept?: string[];
}

export interface ServiceEndpoint {
  uri: string;
  accept?: string[];
  routingKeys?: string[];
}
```

### 2.3 Implement DIDComm v2 Service (Complete)

**File**: `src/services/messaging/DIDCommService.ts`

```typescript
import { v4 as uuidv4 } from 'uuid';
import {
  DIDCommMessage,
  PlaintextMessage,
  EncryptedMessage,
  PackOptions,
  UnpackOptions,
  UnpackResult,
  Attachment,
  ForwardMessage
} from '@/types/messaging/DIDCommTypes';
import { DIDResolverService } from './DIDResolverService';
import { KeyService } from '@/services/KeyService';

/**
 * DIDComm v2 Service
 * Implements DIDComm v2 message packing, unpacking, routing
 */
class DIDCommService {
  private didResolver: typeof DIDResolverService;
  private keyService: typeof KeyService;

  // Supported encryption algorithms
  private readonly ENC_ALG_AUTH = 'ECDH-ES+A256KW';
  private readonly ENC_ALG_ANON = 'ECDH-ES+A256KW';

  constructor() {
    this.didResolver = DIDResolverService;
    this.keyService = KeyService;
  }

  /**
   * Create plaintext DIDComm v2 message
   */
  createPlaintextMessage(params: {
    type: string;
    to?: string[];
    from?: string;
    thid?: string;
    pthid?: string;
    body: Record<string, any>;
    attachments?: Attachment[];
    expiresIn?: number;
  }): PlaintextMessage {
    const now = Date.now();

    const message: PlaintextMessage = {
      id: uuidv4(),
      type: params.type,
      body: params.body,
      created_time: now,
    };

    if (params.to) message.to = params.to;
    if (params.from) message.from = params.from;
    if (params.thid) message.thid = params.thid;
    if (params.pthid) message.pthid = params.pthid;
    if (params.attachments) message.attachments = params.attachments;
    
    if (params.expiresIn) {
      message.expires_time = now + params.expiresIn;
    }

    return message;
  }

  /**
   * Pack message (encrypt and optionally sign)
   */
  async pack(options: PackOptions): Promise<string> {
    const {
      message,
      to,
      from,
      signFrom,
      protectSender = true,
      forward = false
    } = options;

    // Resolve recipient DID document
    const recipientDoc = await this.didResolver.resolve(to);
    if (!recipientDoc) {
      throw new Error(`Could not resolve recipient DID: ${to}`);
    }

    // Get recipient's key agreement keys
    const recipientKeys = this.extractKeyAgreementKeys(recipientDoc);
    if (recipientKeys.length === 0) {
      throw new Error(`No key agreement keys found for ${to}`);
    }

    // Ensure message has recipient
    if (!message.to || message.to.length === 0) {
      message.to = [to];
    }

    let packedMessage: string;

    if (from) {
      // Authenticated encryption (sender known)
      packedMessage = await this.packAuthenticated(
        message,
        from,
        recipientKeys[0],
        signFrom
      );
    } else {
      // Anonymous encryption (sender hidden)
      packedMessage = await this.packAnonymous(
        message,
        recipientKeys[0]
      );
    }

    // Apply forward wrapping if needed
    if (forward && recipientDoc.service) {
      const mediatorEndpoint = this.extractMediatorEndpoint(recipientDoc);
      if (mediatorEndpoint) {
        packedMessage = await this.wrapForward(
          packedMessage,
          to,
          mediatorEndpoint
        );
      }
    }

    return packedMessage;
  }

  /**
   * Pack with authenticated encryption
   */
  private async packAuthenticated(
    message: PlaintextMessage,
    from: string,
    recipientKey: string,
    signFrom?: string
  ): Promise<string> {
    // Resolve sender DID document
    const senderDoc = await this.didResolver.resolve(from);
    if (!senderDoc) {
      throw new Error(`Could not resolve sender DID: ${from}`);
    }

    // Get sender's key agreement key
    const senderKeys = this.extractKeyAgreementKeys(senderDoc);
    if (senderKeys.length === 0) {
      throw new Error(`No key agreement keys found for ${from}`);
    }

    const senderKeyId = senderKeys[0];

    // Get actual keys for encryption
    const senderPrivateKey = await this.keyService.getPrivateKey(senderKeyId);
    const recipientPublicKey = await this.resolvePublicKey(recipientKey);

    // Perform ECDH to derive shared secret
    const sharedSecret = await this.deriveSharedSecret(
      senderPrivateKey,
      recipientPublicKey
    );

    // Derive encryption key from shared secret
    const encKey = await this.deriveEncryptionKey(sharedSecret);

    // Generate IV
    const iv = this.generateIV();

    // Serialize message
    const messageBytes = new TextEncoder().encode(
      JSON.stringify(message)
    );

    // Encrypt message
    const ciphertext = await this.encrypt(messageBytes, encKey, iv);

    // Wrap recipient key
    const wrappedKey = await this.wrapKey(encKey, recipientPublicKey);

    // Build JWE structure
    const jwe: EncryptedMessage = {
      protected: this.buildProtectedHeader({
        alg: this.ENC_ALG_AUTH,
        enc: 'A256GCM',
        skid: senderKeyId,
        typ: 'application/didcomm-encrypted+json'
      }),
      recipients: [{
        encrypted_key: wrappedKey,
        header: {
          kid: recipientKey
        }
      }],
      iv: this.base64url(iv),
      ciphertext: this.base64url(ciphertext),
      tag: '' // Will be set by authenticated encryption
    };

    // Optionally sign
    if (signFrom) {
      // TODO: Implement JWS signing
    }

    return JSON.stringify(jwe);
  }

  /**
   * Pack with anonymous encryption
   */
  private async packAnonymous(
    message: PlaintextMessage,
    recipientKey: string
  ): Promise<string> {
    // Get recipient's public key
    const recipientPublicKey = await this.resolvePublicKey(recipientKey);

    // Generate ephemeral key pair
    const ephemeralKeyPair = await this.keyService.generateEphemeralKeyPair();

    // Perform ECDH with ephemeral key
    const sharedSecret = await this.deriveSharedSecret(
      ephemeralKeyPair.privateKey,
      recipientPublicKey
    );

    // Derive encryption key
    const encKey = await this.deriveEncryptionKey(sharedSecret);

    // Generate IV
    const iv = this.generateIV();

    // Serialize message
    const messageBytes = new TextEncoder().encode(
      JSON.stringify(message)
    );

    // Encrypt message
    const ciphertext = await this.encrypt(messageBytes, encKey, iv);

    // Wrap recipient key
    const wrappedKey = await this.wrapKey(encKey, recipientPublicKey);

    // Build JWE structure with ephemeral key in header
    const jwe: EncryptedMessage = {
      protected: this.buildProtectedHeader({
        alg: this.ENC_ALG_ANON,
        enc: 'A256GCM',
        epk: await this.exportPublicKey(ephemeralKeyPair.publicKey),
        typ: 'application/didcomm-encrypted+json'
      }),
      recipients: [{
        encrypted_key: wrappedKey,
        header: {
          kid: recipientKey
        }
      }],
      iv: this.base64url(iv),
      ciphertext: this.base64url(ciphertext),
      tag: ''
    };

    return JSON.stringify(jwe);
  }

  /**
   * Unpack message (decrypt and verify)
   */
  async unpack(options: UnpackOptions): Promise<UnpackResult> {
    const { message } = options;

    let jwe: EncryptedMessage;

    if (typeof message === 'string') {
      jwe = JSON.parse(message);
    } else {
      jwe = message;
    }

    // Decode protected header
    const protectedHeader = this.decodeProtectedHeader(jwe.protected);

    // Find recipient entry for us
    const ourRecipient = await this.findOurRecipient(jwe.recipients);
    if (!ourRecipient) {
      throw new Error('No recipient entry found for this agent');
    }

    // Get our private key
    const ourPrivateKey = await this.keyService.getPrivateKey(
      ourRecipient.header.kid
    );

    // Determine encryption type (authenticated vs anonymous)
    const isAuthenticated = protectedHeader.skid !== undefined;
    const isAnonymous = protectedHeader.epk !== undefined;

    let sharedSecret: Uint8Array;

    if (isAuthenticated) {
      // Authenticated encryption - use sender's key
      const senderPublicKey = await this.resolvePublicKey(protectedHeader.skid);
      sharedSecret = await this.deriveSharedSecret(
        ourPrivateKey,
        senderPublicKey
      );
    } else if (isAnonymous) {
      // Anonymous encryption - use ephemeral key
      const ephemeralPublicKey = await this.importPublicKey(protectedHeader.epk);
      sharedSecret = await this.deriveSharedSecret(
        ourPrivateKey,
        ephemeralPublicKey
      );
    } else {
      throw new Error('Unknown encryption type');
    }

    // Derive decryption key
    const decKey = await this.deriveEncryptionKey(sharedSecret);

    // Decrypt ciphertext
    const iv = this.base64urlDecode(jwe.iv);
    const ciphertext = this.base64urlDecode(jwe.ciphertext);

    const plaintext = await this.decrypt(ciphertext, decKey, iv);

    // Parse decrypted message
    const plaintextMessage: PlaintextMessage = JSON.parse(
      new TextDecoder().decode(plaintext)
    );

    // Build result metadata
    const metadata = {
      encrypted: true,
      authenticated: isAuthenticated,
      non_repudiation: false, // Set to true if signed
      anonymous_sender: isAnonymous,
    };

    return {
      message: plaintextMessage,
      metadata
    };
  }

  /**
   * Wrap message in forward envelope for mediator
   */
  private async wrapForward(
    packedMessage: string,
    next: string,
    mediatorEndpoint: string
  ): Promise<string> {
    const forwardMessage: ForwardMessage = {
      id: uuidv4(),
      type: 'https://didcomm.org/routing/2.0/forward',
      to: [mediatorEndpoint],
      body: {
        next
      },
      attachments: [{
        data: {
          json: JSON.parse(packedMessage)
        }
      }]
    };

    // Pack forward message to mediator
    return this.pack({
      message: forwardMessage,
      to: mediatorEndpoint,
      forward: false // Don't forward the forward message itself!
    });
  }

  /**
   * Send message via HTTP
   */
  async send(
    message: string,
    serviceEndpoint: string
  ): Promise<void> {
    const response = await fetch(serviceEndpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/didcomm-encrypted+json',
      },
      body: message
    });

    if (!response.ok) {
      throw new Error(`Failed to send message: ${response.statusText}`);
    }
  }

  /**
   * Extract key agreement keys from DID document
   */
  private extractKeyAgreementKeys(didDoc: any): string[] {
    const keys: string[] = [];

    if (didDoc.keyAgreement) {
      for (const ka of didDoc.keyAgreement) {
        if (typeof ka === 'string') {
          keys.push(ka);
        } else if (ka.id) {
          keys.push(ka.id);
        }
      }
    }

    return keys;
  }

  /**
   * Extract mediator endpoint from DID document
   */
  private extractMediatorEndpoint(didDoc: any): string | null {
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
   * Find our recipient entry in JWE
   */
  private async findOurRecipient(recipients: any[]): Promise<any | null> {
    for (const recipient of recipients) {
      const kid = recipient.header.kid;
      const hasKey = await this.keyService.hasPrivateKey(kid);
      if (hasKey) {
        return recipient;
      }
    }
    return null;
  }

  /**
   * Build protected header (base64url encoded)
   */
  private buildProtectedHeader(header: Record<string, any>): string {
    return this.base64url(
      new TextEncoder().encode(JSON.stringify(header))
    );
  }

  /**
   * Decode protected header
   */
  private decodeProtectedHeader(protected_: string): Record<string, any> {
    const decoded = this.base64urlDecode(protected_);
    return JSON.parse(new TextDecoder().decode(decoded));
  }

  /**
   * Resolve public key from key ID
   */
  private async resolvePublicKey(kid: string): Promise<CryptoKey> {
    // Extract DID from key ID
    const did = kid.split('#')[0];
    const didDoc = await this.didResolver.resolve(did);
    
    if (!didDoc) {
      throw new Error(`Could not resolve DID: ${did}`);
    }

    // Find verification method
    const verificationMethod = didDoc.verificationMethod?.find(
      (vm: any) => vm.id === kid
    );

    if (!verificationMethod) {
      throw new Error(`Key not found: ${kid}`);
    }

    // Import public key
    return this.importPublicKey(verificationMethod.publicKeyJwk);
  }

  /**
   * Derive shared secret using ECDH
   */
  private async deriveSharedSecret(
    privateKey: CryptoKey,
    publicKey: CryptoKey
  ): Promise<Uint8Array> {
    const sharedSecret = await crypto.subtle.deriveBits(
      {
        name: 'ECDH',
        public: publicKey
      },
      privateKey,
      256 // 256 bits
    );

    return new Uint8Array(sharedSecret);
  }

  /**
   * Derive encryption key from shared secret
   */
  private async deriveEncryptionKey(
    sharedSecret: Uint8Array
  ): Promise<CryptoKey> {
    // Use HKDF to derive encryption key
    const importedSecret = await crypto.subtle.importKey(
      'raw',
      sharedSecret,
      { name: 'HKDF' },
      false,
      ['deriveKey']
    );

    return crypto.subtle.deriveKey(
      {
        name: 'HKDF',
        hash: 'SHA-256',
        salt: new Uint8Array(),
        info: new TextEncoder().encode('DIDComm-v2')
      },
      importedSecret,
      { name: 'AES-GCM', length: 256 },
      false,
      ['encrypt', 'decrypt']
    );
  }

  /**
   * Wrap key for recipient
   */
  private async wrapKey(
    key: CryptoKey,
    recipientKey: CryptoKey
  ): Promise<string> {
    const wrapped = await crypto.subtle.wrapKey(
      'raw',
      key,
      recipientKey,
      { name: 'AES-KW' }
    );

    return this.base64url(new Uint8Array(wrapped));
  }

  /**
   * Encrypt data with AES-GCM
   */
  private async encrypt(
    data: Uint8Array,
    key: CryptoKey,
    iv: Uint8Array
  ): Promise<Uint8Array> {
    const encrypted = await crypto.subtle.encrypt(
      {
        name: 'AES-GCM',
        iv: iv,
        tagLength: 128
      },
      key,
      data
    );

    return new Uint8Array(encrypted);
  }

  /**
   * Decrypt data with AES-GCM
   */
  private async decrypt(
    ciphertext: Uint8Array,
    key: CryptoKey,
    iv: Uint8Array
  ): Promise<Uint8Array> {
    const decrypted = await crypto.subtle.decrypt(
      {
        name: 'AES-GCM',
        iv: iv,
        tagLength: 128
      },
      key,
      ciphertext
    );

    return new Uint8Array(decrypted);
  }

  /**
   * Generate random IV
   */
  private generateIV(): Uint8Array {
    return crypto.getRandomValues(new Uint8Array(12));
  }

  /**
   * Import public key from JWK
   */
  private async importPublicKey(jwk: any): Promise<CryptoKey> {
    return crypto.subtle.importKey(
      'jwk',
      jwk,
      { name: 'ECDH', namedCurve: 'P-256' },
      true,
      []
    );
  }

  /**
   * Export public key to JWK
   */
  private async exportPublicKey(key: CryptoKey): Promise<any> {
    return crypto.subtle.exportKey('jwk', key);
  }

  /**
   * Base64url encode
   */
  private base64url(data: Uint8Array): string {
    const base64 = btoa(String.fromCharCode(...data));
    return base64
      .replace(/\+/g, '-')
      .replace(/\//g, '_')
      .replace(/=/g, '');
  }

  /**
   * Base64url decode
   */
  private base64urlDecode(str: string): Uint8Array {
    // Add padding
    str = str.replace(/-/g, '+').replace(/_/g, '/');
    while (str.length % 4) {
      str += '=';
    }
    
    const binary = atob(str);
    const bytes = new Uint8Array(binary.length);
    for (let i = 0; i < binary.length; i++) {
      bytes[i] = binary.charCodeAt(i);
    }
    
    return bytes;
  }
}

export default new DIDCommService();
```

---

## 📨 Langkah 3: Implement Mediator Service (US-3.2) - COMPLETE

### 3.1 Create Mediator Types

**File**: `src/types/messaging/MediatorTypes.ts`

```typescript
/**
 * DIDComm Mediator Type Definitions
 * Based on: Mediator Coordination Protocol
 */

export interface MediatorConfig {
  id: string;
  endpoint: string;
  routingKeys: string[];
  isPrimary: boolean;
  isActive: boolean;
  priority: number;
}

export interface MediatorCoordinationMessage {
  id: string;
  type: string;
  from?: string;
  to?: string[];
  body: Record<string, any>;
}

export interface MediatorGrantMessage {
  routing_did: string[];
  endpoint: string;
}

export interface LiveDeliveryChange {
  live_delivery: boolean;
}

export interface MessagePickupStatus {
  message_count: number;
  duration_waited?: number;
  last_added_time?: number;
  last_delivered_time?: number;
  last_removed_time?: number;
  total_bytes?: number;
  live_delivery?: boolean;
}

export interface MessageBatch {
  messages: string[];
  has_more: boolean;
}

export enum MediatorMessageType {
  COORDINATE_MEDIATION_REQUEST = 'https://didcomm.org/coordinate-mediation/2.0/mediate-request',
  COORDINATE_MEDIATION_GRANT = 'https://didcomm.org/coordinate-mediation/2.0/mediate-grant',
  COORDINATE_MEDIATION_DENY = 'https://didcomm.org/coordinate-mediation/2.0/mediate-deny',
  KEYLIST_UPDATE = 'https://didcomm.org/coordinate-mediation/2.0/keylist-update',
  KEYLIST_UPDATE_RESPONSE = 'https://didcomm.org/coordinate-mediation/2.0/keylist-update-response',
  KEYLIST_QUERY = 'https://didcomm.org/coordinate-mediation/2.0/keylist-query',
  KEYLIST = 'https://didcomm.org/coordinate-mediation/2.0/keylist',
  STATUS_REQUEST = 'https://didcomm.org/messagepickup/3.0/status-request',
  STATUS = 'https://didcomm.org/messagepickup/3.0/status',
  DELIVERY_REQUEST = 'https://didcomm.org/messagepickup/3.0/delivery-request',
  MESSAGE_DELIVERY = 'https://didcomm.org/messagepickup/3.0/delivery',
  MESSAGES_RECEIVED = 'https://didcomm.org/messagepickup/3.0/messages-received',
  LIVE_DELIVERY_CHANGE = 'https://didcomm.org/messagepickup/3.0/live-delivery-change',
}
```

### 3.2 Implement Mediator Service (Complete)

**File**: `src/services/messaging/MediatorService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import { v4 as uuidv4 } from 'uuid';
import io, { Socket } from 'socket.io-client';
import {
  MediatorConfig,
  MediatorCoordinationMessage,
  MediatorGrantMessage,
  MessagePickupStatus,
  MessageBatch,
  MediatorMessageType,
  LiveDeliveryChange
} from '@/types/messaging/MediatorTypes';
import DIDCommService from './DIDCommService';

/**
 * Mediator Service
 * Handles mediator coordination, message pickup, and live delivery
 */
class MediatorService {
  private readonly STORAGE_KEY = 'didcomm_mediators';
  private mediators: Map<string, MediatorConfig> = new Map();
  private activeMediatorId: string | null = null;
  private socket: Socket | null = null;
  private liveDeliveryEnabled = false;

  /**
   * Initialize mediator service
   */
  async initialize(): Promise<void> {
    await this.loadMediators();
    
    // Set first primary mediator as active
    const primary = this.getPrimaryMediator();
    if (primary) {
      this.activeMediatorId = primary.id;
    }
  }

  /**
   * Register with a mediator
   */
  async registerMediator(params: {
    endpoint: string;
    myDID: string;
    isPrimary?: boolean;
  }): Promise<MediatorConfig> {
    const { endpoint, myDID, isPrimary = false } = params;

    // Send mediation request
    const requestMessage = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.COORDINATE_MEDIATION_REQUEST,
      to: [endpoint],
      from: myDID,
      body: {}
    });

    const packedRequest = await DIDCommService.pack({
      message: requestMessage,
      to: endpoint,
      from: myDID
    });

    // Send to mediator
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/didcomm-encrypted+json'
      },
      body: packedRequest
    });

    if (!response.ok) {
      throw new Error(`Mediator registration failed: ${response.statusText}`);
    }

    const responseData = await response.text();
    const unpackedResponse = await DIDCommService.unpack({
      message: responseData
    });

    // Check if grant or deny
    if (unpackedResponse.message.type === MediatorMessageType.COORDINATE_MEDIATION_DENY) {
      throw new Error('Mediator denied coordination request');
    }

    if (unpackedResponse.message.type !== MediatorMessageType.COORDINATE_MEDIATION_GRANT) {
      throw new Error('Unexpected response from mediator');
    }

    // Extract grant data
    const grantData = unpackedResponse.message.body as MediatorGrantMessage;

    // Create mediator config
    const mediatorConfig: MediatorConfig = {
      id: uuidv4(),
      endpoint,
      routingKeys: grantData.routing_did,
      isPrimary,
      isActive: true,
      priority: isPrimary ? 1 : 10
    };

    // Store mediator
    this.mediators.set(mediatorConfig.id, mediatorConfig);
    await this.saveMediators();

    // Set as active if primary
    if (isPrimary) {
      this.activeMediatorId = mediatorConfig.id;
    }

    return mediatorConfig;
  }

  /**
   * Update keylist with mediator
   */
  async updateKeylist(params: {
    mediatorId: string;
    updates: Array<{
      recipient_did: string;
      action: 'add' | 'remove';
    }>;
  }): Promise<void> {
    const { mediatorId, updates } = params;
    
    const mediator = this.mediators.get(mediatorId);
    if (!mediator) {
      throw new Error(`Mediator not found: ${mediatorId}`);
    }

    const updateMessage = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.KEYLIST_UPDATE,
      to: [mediator.endpoint],
      body: {
        updates
      }
    });

    const packed = await DIDCommService.pack({
      message: updateMessage,
      to: mediator.endpoint
    });

    await DIDCommService.send(packed, mediator.endpoint);
  }

  /**
   * Get message pickup status
   */
  async getPickupStatus(mediatorId?: string): Promise<MessagePickupStatus> {
    const mediator = await this.getActiveMediator(mediatorId);

    const statusRequest = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.STATUS_REQUEST,
      to: [mediator.endpoint],
      body: {}
    });

    const packed = await DIDCommService.pack({
      message: statusRequest,
      to: mediator.endpoint
    });

    const response = await fetch(mediator.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/didcomm-encrypted+json'
      },
      body: packed
    });

    if (!response.ok) {
      throw new Error(`Status request failed: ${response.statusText}`);
    }

    const responseData = await response.text();
    const unpacked = await DIDCommService.unpack({
      message: responseData
    });

    return unpacked.message.body as MessagePickupStatus;
  }

  /**
   * Pick up messages from mediator (batch)
   */
  async pickupMessages(params?: {
    mediatorId?: string;
    limit?: number;
  }): Promise<MessageBatch> {
    const { mediatorId, limit = 10 } = params || {};
    const mediator = await this.getActiveMediator(mediatorId);

    const deliveryRequest = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.DELIVERY_REQUEST,
      to: [mediator.endpoint],
      body: {
        limit
      }
    });

    const packed = await DIDCommService.pack({
      message: deliveryRequest,
      to: mediator.endpoint
    });

    const response = await fetch(mediator.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/didcomm-encrypted+json'
      },
      body: packed
    });

    if (!response.ok) {
      throw new Error(`Message pickup failed: ${response.statusText}`);
    }

    const responseData = await response.text();
    const unpacked = await DIDCommService.unpack({
      message: responseData
    });

    // Extract messages from attachments
    const messages: string[] = [];
    if (unpacked.message.attachments) {
      for (const attachment of unpacked.message.attachments) {
        if (attachment.data.json) {
          messages.push(JSON.stringify(attachment.data.json));
        } else if (attachment.data.base64) {
          messages.push(attachment.data.base64);
        }
      }
    }

    // Send acknowledgment
    await this.acknowledgeMessages(
      mediator,
      messages.map((_, index) => `msg-${index}`)
    );

    return {
      messages,
      has_more: unpacked.message.body.has_more || false
    };
  }

  /**
   * Acknowledge received messages
   */
  private async acknowledgeMessages(
    mediator: MediatorConfig,
    messageIds: string[]
  ): Promise<void> {
    const ackMessage = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.MESSAGES_RECEIVED,
      to: [mediator.endpoint],
      body: {
        message_id_list: messageIds
      }
    });

    const packed = await DIDCommService.pack({
      message: ackMessage,
      to: mediator.endpoint
    });

    await DIDCommService.send(packed, mediator.endpoint);
  }

  /**
   * Enable live delivery via WebSocket
   */
  async enableLiveDelivery(mediatorId?: string): Promise<void> {
    const mediator = await this.getActiveMediator(mediatorId);

    // Send live delivery change message
    const changeMessage = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.LIVE_DELIVERY_CHANGE,
      to: [mediator.endpoint],
      body: {
        live_delivery: true
      } as LiveDeliveryChange
    });

    const packed = await DIDCommService.pack({
      message: changeMessage,
      to: mediator.endpoint
    });

    await DIDCommService.send(packed, mediator.endpoint);

    // Connect WebSocket
    const wsEndpoint = mediator.endpoint.replace('http', 'ws');
    this.socket = io(wsEndpoint, {
      transports: ['websocket'],
      reconnection: true,
      reconnectionDelay: 1000,
      reconnectionAttempts: 10
    });

    this.socket.on('connect', () => {
      console.log('Live delivery connected');
      this.liveDeliveryEnabled = true;
    });

    this.socket.on('message', (data: string) => {
      this.handleLiveMessage(data);
    });

    this.socket.on('disconnect', () => {
      console.log('Live delivery disconnected');
      this.liveDeliveryEnabled = false;
    });

    this.socket.on('error', (error) => {
      console.error('Live delivery error:', error);
    });
  }

  /**
   * Disable live delivery
   */
  async disableLiveDelivery(mediatorId?: string): Promise<void> {
    const mediator = await this.getActiveMediator(mediatorId);

    // Send live delivery change message
    const changeMessage = DIDCommService.createPlaintextMessage({
      type: MediatorMessageType.LIVE_DELIVERY_CHANGE,
      to: [mediator.endpoint],
      body: {
        live_delivery: false
      } as LiveDeliveryChange
    });

    const packed = await DIDCommService.pack({
      message: changeMessage,
      to: mediator.endpoint
    });

    await DIDCommService.send(packed, mediator.endpoint);

    // Disconnect WebSocket
    if (this.socket) {
      this.socket.disconnect();
      this.socket = null;
    }

    this.liveDeliveryEnabled = false;
  }

  /**
   * Handle live message delivery
   */
  private async handleLiveMessage(encryptedMessage: string): Promise<void> {
    try {
      const unpacked = await DIDCommService.unpack({
        message: encryptedMessage
      });

      // Emit event for message received
      // This will be handled by MessageService
      this.emit('message:received', unpacked.message);
    } catch (error) {
      console.error('Failed to handle live message:', error);
    }
  }

  /**
   * Automatic failover to backup mediator
   */
  async failover(): Promise<void> {
    const mediators = Array.from(this.mediators.values())
      .filter(m => m.isActive)
      .sort((a, b) => a.priority - b.priority);

    for (const mediator of mediators) {
      if (mediator.id === this.activeMediatorId) {
        continue; // Skip current mediator
      }

      try {
        // Test connectivity
        const status = await this.getPickupStatus(mediator.id);
        
        // If successful, switch to this mediator
        this.activeMediatorId = mediator.id;
        console.log(`Failover successful to mediator: ${mediator.id}`);
        
        // Reconnect live delivery if enabled
        if (this.liveDeliveryEnabled) {
          await this.enableLiveDelivery(mediator.id);
        }
        
        return;
      } catch (error) {
        console.error(`Failover to ${mediator.id} failed:`, error);
        continue;
      }
    }

    throw new Error('All mediators failed');
  }

  /**
   * Get active mediator
   */
  private async getActiveMediator(mediatorId?: string): Promise<MediatorConfig> {
    const id = mediatorId || this.activeMediatorId;
    
    if (!id) {
      throw new Error('No active mediator');
    }

    const mediator = this.mediators.get(id);
    
    if (!mediator) {
      throw new Error(`Mediator not found: ${id}`);
    }

    return mediator;
  }

  /**
   * Get primary mediator
   */
  getPrimaryMediator(): MediatorConfig | null {
    for (const mediator of this.mediators.values()) {
      if (mediator.isPrimary) {
        return mediator;
      }
    }
    return null;
  }

  /**
   * Get all mediators
   */
  getAllMediators(): MediatorConfig[] {
    return Array.from(this.mediators.values());
  }

  /**
   * Remove mediator
   */
  async removeMediator(mediatorId: string): Promise<void> {
    this.mediators.delete(mediatorId);
    await this.saveMediators();

    if (this.activeMediatorId === mediatorId) {
      // Switch to another mediator
      const primary = this.getPrimaryMediator();
      this.activeMediatorId = primary?.id || null;
    }
  }

  /**
   * Save mediators to storage
   */
  private async saveMediators(): Promise<void> {
    const data = Array.from(this.mediators.values());
    await AsyncStorage.setItem(this.STORAGE_KEY, JSON.stringify(data));
  }

  /**
   * Load mediators from storage
   */
  private async loadMediators(): Promise<void> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY);
    if (data) {
      const mediators: MediatorConfig[] = JSON.parse(data);
      for (const mediator of mediators) {
        this.mediators.set(mediator.id, mediator);
      }
    }
  }

  /**
   * Simple event emitter (will be replaced with proper EventEmitter)
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

export default new MediatorService();
```

Dokumen ini akan dilanjutkan di **SETUP-GUIDE-PART2.md** karena panjangnya konten. Bagian berikutnya akan mencakup:
- WACI DIDComm Implementation (Issuance & Presentation)
- Push Notifications
- Message Queue & Retry Logic
- DID Resolver Enhancement
- UI Components
- Testing

---

**Lanjut ke**: [SETUP-GUIDE-PART2.md](./SETUP-GUIDE-PART2.md)

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: Part 1 of 2
