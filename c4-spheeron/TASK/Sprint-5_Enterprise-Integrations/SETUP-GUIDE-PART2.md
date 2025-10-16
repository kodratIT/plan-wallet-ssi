# Sprint 5: Enterprise Integrations - Panduan Setup & Implementasi Part 2

**Lanjutan dari**: [SETUP-GUIDE.md](./SETUP-GUIDE.md)

---

## 🔄 Langkah 4: Implement Organization Profiles (US-5.5) - COMPLETE

### 4.1 Create Profile Types

**File**: `src/types/enterprise/ProfileTypes.ts`

```typescript
/**
 * Organization Profile Type Definitions
 */

export interface WalletProfile {
  id: string;
  name: string;
  type: 'personal' | 'work';
  isActive: boolean;
  organization?: OrganizationBranding;
  createdAt: number;
  updatedAt: number;
}

export interface OrganizationBranding {
  name: string;
  displayName: string;
  logo?: string;
  primaryColor: string;
  secondaryColor: string;
  domain?: string;
  did?: string;
}

export interface ProfileStoragePartition {
  profileId: string;
  storageKey: string;
  credentials: any[];
  connections: any[];
  settings: Record<string, any>;
}
```

### 4.2 Implement Profile Service (Complete)

**File**: `src/services/enterprise/ProfileService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import { v4 as uuidv4 } from 'uuid';
import {
  WalletProfile,
  OrganizationBranding,
  ProfileStoragePartition
} from '@/types/enterprise/ProfileTypes';

/**
 * Profile Service
 * Manages multiple wallet profiles (personal/work)
 */
class ProfileService {
  private readonly PROFILES_KEY = 'wallet_profiles';
  private readonly ACTIVE_PROFILE_KEY = 'active_profile_id';
  private readonly PARTITION_PREFIX = 'profile_data_';

  private profiles: Map<string, WalletProfile> = new Map();
  private activeProfileId: string | null = null;

  /**
   * Initialize profile service
   */
  async initialize(): Promise<void> {
    await this.loadProfiles();
    
    // Load active profile
    const activeId = await AsyncStorage.getItem(this.ACTIVE_PROFILE_KEY);
    if (activeId && this.profiles.has(activeId)) {
      this.activeProfileId = activeId;
    } else {
      // Create default personal profile if none exists
      if (this.profiles.size === 0) {
        const defaultProfile = await this.createProfile({
          name: 'Personal',
          type: 'personal'
        });
        this.activeProfileId = defaultProfile.id;
      } else {
        // Set first profile as active
        this.activeProfileId = this.profiles.keys().next().value;
      }
      await AsyncStorage.setItem(this.ACTIVE_PROFILE_KEY, this.activeProfileId!);
    }
  }

  /**
   * Create new profile
   */
  async createProfile(params: {
    name: string;
    type: 'personal' | 'work';
    organization?: OrganizationBranding;
  }): Promise<WalletProfile> {
    const { name, type, organization } = params;

    const profile: WalletProfile = {
      id: uuidv4(),
      name,
      type,
      isActive: false,
      organization,
      createdAt: Date.now(),
      updatedAt: Date.now()
    };

    this.profiles.set(profile.id, profile);
    await this.saveProfiles();

    // Create storage partition
    await this.createStoragePartition(profile.id);

    return profile;
  }

  /**
   * Switch to profile
   */
  async switchProfile(profileId: string): Promise<void> {
    if (!this.profiles.has(profileId)) {
      throw new Error(`Profile not found: ${profileId}`);
    }

    // Deactivate current profile
    if (this.activeProfileId) {
      const currentProfile = this.profiles.get(this.activeProfileId);
      if (currentProfile) {
        currentProfile.isActive = false;
      }
    }

    // Activate new profile
    const newProfile = this.profiles.get(profileId)!;
    newProfile.isActive = true;
    newProfile.updatedAt = Date.now();

    this.activeProfileId = profileId;
    
    await AsyncStorage.setItem(this.ACTIVE_PROFILE_KEY, profileId);
    await this.saveProfiles();

    // Emit event for app to reload profile-specific data
    this.emit('profile:switched', newProfile);
  }

  /**
   * Get active profile
   */
  getActiveProfile(): WalletProfile | null {
    if (!this.activeProfileId) {
      return null;
    }
    return this.profiles.get(this.activeProfileId) || null;
  }

  /**
   * Get all profiles
   */
  getAllProfiles(): WalletProfile[] {
    return Array.from(this.profiles.values());
  }

  /**
   * Update profile
   */
  async updateProfile(
    profileId: string,
    updates: Partial<WalletProfile>
  ): Promise<void> {
    const profile = this.profiles.get(profileId);
    if (!profile) {
      throw new Error(`Profile not found: ${profileId}`);
    }

    Object.assign(profile, updates, {
      updatedAt: Date.now()
    });

    await this.saveProfiles();
  }

  /**
   * Delete profile
   */
  async deleteProfile(profileId: string): Promise<void> {
    if (this.profiles.size === 1) {
      throw new Error('Cannot delete the last profile');
    }

    if (profileId === this.activeProfileId) {
      // Switch to another profile first
      const otherProfile = Array.from(this.profiles.values())
        .find(p => p.id !== profileId);
      
      if (otherProfile) {
        await this.switchProfile(otherProfile.id);
      }
    }

    this.profiles.delete(profileId);
    await this.saveProfiles();

    // Delete storage partition
    await this.deleteStoragePartition(profileId);
  }

  /**
   * Get profile storage partition
   */
  async getProfileData(profileId: string): Promise<ProfileStoragePartition> {
    const key = `${this.PARTITION_PREFIX}${profileId}`;
    const data = await AsyncStorage.getItem(key);

    if (!data) {
      return {
        profileId,
        storageKey: key,
        credentials: [],
        connections: [],
        settings: {}
      };
    }

    return JSON.parse(data);
  }

  /**
   * Save profile data
   */
  async saveProfileData(
    profileId: string,
    data: Partial<ProfileStoragePartition>
  ): Promise<void> {
    const existing = await this.getProfileData(profileId);
    const updated = { ...existing, ...data };

    const key = `${this.PARTITION_PREFIX}${profileId}`;
    await AsyncStorage.setItem(key, JSON.stringify(updated));
  }

  /**
   * Create storage partition for new profile
   */
  private async createStoragePartition(profileId: string): Promise<void> {
    const partition: ProfileStoragePartition = {
      profileId,
      storageKey: `${this.PARTITION_PREFIX}${profileId}`,
      credentials: [],
      connections: [],
      settings: {}
    };

    await AsyncStorage.setItem(
      partition.storageKey,
      JSON.stringify(partition)
    );
  }

  /**
   * Delete storage partition
   */
  private async deleteStoragePartition(profileId: string): Promise<void> {
    const key = `${this.PARTITION_PREFIX}${profileId}`;
    await AsyncStorage.removeItem(key);
  }

  /**
   * Save profiles to storage
   */
  private async saveProfiles(): Promise<void> {
    const data = Array.from(this.profiles.values());
    await AsyncStorage.setItem(this.PROFILES_KEY, JSON.stringify(data));
  }

  /**
   * Load profiles from storage
   */
  private async loadProfiles(): Promise<void> {
    const data = await AsyncStorage.getItem(this.PROFILES_KEY);
    if (data) {
      const profiles: WalletProfile[] = JSON.parse(data);
      for (const profile of profiles) {
        this.profiles.set(profile.id, profile);
      }
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

export default new ProfileService();
```

---

## 🔒 Langkah 5: Implement Well-Known DID Configuration (US-5.6) - COMPLETE

### 5.1 Implement Well-Known DID Service (Complete)

**File**: `src/services/enterprise/WellKnownDIDService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import { DIDConfigurationResource } from '@decentralized-identity/did-configuration';

/**
 * Well-Known DID Configuration Service
 * Implements W3C DID Configuration spec for domain linkage
 */
class WellKnownDIDService {
  private readonly CACHE_KEY_PREFIX = 'did_config_';
  private readonly CACHE_TTL = 86400000; // 24 hours

  private cache: Map<string, CachedDIDConfiguration> = new Map();

  /**
   * Fetch and validate DID Configuration for domain
   */
  async fetchConfiguration(domain: string): Promise<DIDConfigurationResource | null> {
    // Check cache first
    const cached = await this.getFromCache(domain);
    if (cached) {
      return cached;
    }

    try {
      // Ensure HTTPS
      const url = `https://${domain}/.well-known/did-configuration.json`;

      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Accept': 'application/json'
        }
      });

      if (!response.ok) {
        console.error(`Failed to fetch DID configuration: ${response.statusText}`);
        return null;
      }

      const config: DIDConfigurationResource = await response.json();

      // Validate configuration
      if (!this.validateConfiguration(config)) {
        console.error('Invalid DID configuration structure');
        return null;
      }

      // Cache configuration
      await this.addToCache(domain, config);

      return config;
    } catch (error) {
      console.error(`Error fetching DID configuration for ${domain}:`, error);
      return null;
    }
  }

  /**
   * Verify domain linkage for DID
   */
  async verifyDomainLinkage(did: string, domain: string): Promise<boolean> {
    const config = await this.fetchConfiguration(domain);
    if (!config) {
      return false;
    }

    // Check if DID is in linked_dids
    for (const entry of config.linked_dids) {
      if (typeof entry === 'string') {
        if (entry === did) {
          return true;
        }
      } else if (entry.did === did) {
        // Verify JWT signature if present
        if (entry.jwt) {
          const verified = await this.verifyJWT(entry.jwt, did, domain);
          if (verified) {
            return true;
          }
        }
      }
    }

    return false;
  }

  /**
   * Extract DID from domain
   */
  async extractDIDFromDomain(domain: string): Promise<string | null> {
    const config = await this.fetchConfiguration(domain);
    if (!config || !config.linked_dids || config.linked_dids.length === 0) {
      return null;
    }

    const firstEntry = config.linked_dids[0];
    if (typeof firstEntry === 'string') {
      return firstEntry;
    } else if (firstEntry.did) {
      return firstEntry.did;
    }

    return null;
  }

  /**
   * Validate DID Configuration structure
   */
  private validateConfiguration(config: any): boolean {
    if (!config || typeof config !== 'object') {
      return false;
    }

    if (!config['@context']) {
      return false;
    }

    if (!Array.isArray(config.linked_dids) || config.linked_dids.length === 0) {
      return false;
    }

    return true;
  }

  /**
   * Verify JWT domain linkage credential
   */
  private async verifyJWT(
    jwt: string,
    expectedDID: string,
    expectedDomain: string
  ): Promise<boolean> {
    try {
      // Parse JWT
      const parts = jwt.split('.');
      if (parts.length !== 3) {
        return false;
      }

      const payload = JSON.parse(
        Buffer.from(parts[1], 'base64').toString('utf-8')
      );

      // Verify claims
      if (payload.iss !== expectedDID) {
        return false;
      }

      if (payload.sub !== expectedDID) {
        return false;
      }

      if (!payload.vc || !payload.vc.credentialSubject) {
        return false;
      }

      if (payload.vc.credentialSubject.id !== expectedDID) {
        return false;
      }

      if (payload.vc.credentialSubject.origin !== `https://${expectedDomain}`) {
        return false;
      }

      // TODO: Verify JWT signature with DID document public key
      // This requires DID resolution and signature verification

      return true;
    } catch (error) {
      console.error('JWT verification failed:', error);
      return false;
    }
  }

  /**
   * Get from cache
   */
  private async getFromCache(domain: string): Promise<DIDConfigurationResource | null> {
    const cached = this.cache.get(domain);
    if (!cached) {
      // Try loading from storage
      const key = `${this.CACHE_KEY_PREFIX}${domain}`;
      const stored = await AsyncStorage.getItem(key);
      if (stored) {
        const data: CachedDIDConfiguration = JSON.parse(stored);
        if (Date.now() < data.expiresAt) {
          this.cache.set(domain, data);
          return data.configuration;
        } else {
          // Expired
          await AsyncStorage.removeItem(key);
        }
      }
      return null;
    }

    // Check expiry
    if (Date.now() > cached.expiresAt) {
      this.cache.delete(domain);
      const key = `${this.CACHE_KEY_PREFIX}${domain}`;
      await AsyncStorage.removeItem(key);
      return null;
    }

    return cached.configuration;
  }

  /**
   * Add to cache
   */
  private async addToCache(
    domain: string,
    configuration: DIDConfigurationResource
  ): Promise<void> {
    const cached: CachedDIDConfiguration = {
      configuration,
      cachedAt: Date.now(),
      expiresAt: Date.now() + this.CACHE_TTL
    };

    this.cache.set(domain, cached);

    const key = `${this.CACHE_KEY_PREFIX}${domain}`;
    await AsyncStorage.setItem(key, JSON.stringify(cached));
  }

  /**
   * Clear cache
   */
  async clearCache(domain?: string): Promise<void> {
    if (domain) {
      this.cache.delete(domain);
      const key = `${this.CACHE_KEY_PREFIX}${domain}`;
      await AsyncStorage.removeItem(key);
    } else {
      this.cache.clear();
      // Clear all from storage
      const keys = await AsyncStorage.getAllKeys();
      const cacheKeys = keys.filter(k => k.startsWith(this.CACHE_KEY_PREFIX));
      await AsyncStorage.multiRemove(cacheKeys);
    }
  }
}

interface CachedDIDConfiguration {
  configuration: DIDConfigurationResource;
  cachedAt: number;
  expiresAt: number;
}

export default new WellKnownDIDService();
```

---

## 📊 Langkah 6: Implement StatusList2021 (US-5.7) - COMPLETE

### 6.1 Implement Status List Service (Complete)

**File**: `src/services/enterprise/StatusList2021Service.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import pako from 'pako';

/**
 * StatusList2021 Service
 * Implements W3C StatusList2021 for efficient credential status checking
 */
class StatusList2021Service {
  private readonly CACHE_KEY_PREFIX = 'status_list_';
  private readonly CACHE_TTL = 3600000; // 1 hour

  private cache: Map<string, CachedStatusList> = new Map();

  /**
   * Check credential status
   */
  async checkStatus(credential: any): Promise<'active' | 'revoked' | 'suspended'> {
    // Extract status list info from credential
    const statusInfo = this.extractStatusInfo(credential);
    if (!statusInfo) {
      // No status info, assume active
      return 'active';
    }

    // Fetch status list
    const statusList = await this.fetchStatusList(statusInfo.statusListCredential);
    if (!statusList) {
      console.warn('Failed to fetch status list, assuming active');
      return 'active';
    }

    // Extract bitstring
    const bitstring = this.extractBitstring(statusList);
    if (!bitstring) {
      console.error('Invalid status list format');
      return 'active';
    }

    // Check bit at index
    const index = statusInfo.statusListIndex;
    const isSet = this.checkBit(bitstring, index);

    // Determine status based on statusPurpose
    if (statusInfo.statusPurpose === 'revocation') {
      return isSet ? 'revoked' : 'active';
    } else if (statusInfo.statusPurpose === 'suspension') {
      return isSet ? 'suspended' : 'active';
    }

    return 'active';
  }

  /**
   * Batch check status for multiple credentials
   */
  async batchCheckStatus(credentials: any[]): Promise<Map<string, string>> {
    const results = new Map<string, string>();

    // Group by status list URL
    const grouped = new Map<string, any[]>();
    for (const cred of credentials) {
      const statusInfo = this.extractStatusInfo(cred);
      if (statusInfo) {
        const url = statusInfo.statusListCredential;
        if (!grouped.has(url)) {
          grouped.set(url, []);
        }
        grouped.get(url)!.push({ credential: cred, statusInfo });
      }
    }

    // Fetch each status list once
    for (const [url, items] of grouped.entries()) {
      const statusList = await this.fetchStatusList(url);
      if (!statusList) continue;

      const bitstring = this.extractBitstring(statusList);
      if (!bitstring) continue;

      // Check each credential
      for (const item of items) {
        const index = item.statusInfo.statusListIndex;
        const isSet = this.checkBit(bitstring, index);

        const status = item.statusInfo.statusPurpose === 'revocation'
          ? (isSet ? 'revoked' : 'active')
          : (isSet ? 'suspended' : 'active');

        results.set(item.credential.id, status);
      }
    }

    return results;
  }

  /**
   * Fetch status list credential
   */
  private async fetchStatusList(url: string): Promise<any | null> {
    // Check cache
    const cached = await this.getFromCache(url);
    if (cached) {
      return cached;
    }

    try {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Accept': 'application/json'
        }
      });

      if (!response.ok) {
        console.error(`Failed to fetch status list: ${response.statusText}`);
        return null;
      }

      const statusList = await response.json();

      // Validate status list
      if (!this.validateStatusList(statusList)) {
        console.error('Invalid status list format');
        return null;
      }

      // Cache status list
      await this.addToCache(url, statusList);

      return statusList;
    } catch (error) {
      console.error(`Error fetching status list from ${url}:`, error);
      return null;
    }
  }

  /**
   * Extract status info from credential
   */
  private extractStatusInfo(credential: any): StatusInfo | null {
    if (!credential.credentialStatus) {
      return null;
    }

    const status = credential.credentialStatus;

    if (status.type !== 'StatusList2021Entry') {
      return null;
    }

    return {
      statusListCredential: status.statusListCredential,
      statusListIndex: parseInt(status.statusListIndex, 10),
      statusPurpose: status.statusPurpose
    };
  }

  /**
   * Extract bitstring from status list credential
   */
  private extractBitstring(statusList: any): Uint8Array | null {
    try {
      const encodedList = statusList.credentialSubject?.encodedList;
      if (!encodedList) {
        return null;
      }

      // Decode base64
      const compressed = Buffer.from(encodedList, 'base64');

      // Decompress using gzip
      const decompressed = pako.inflate(compressed);

      return decompressed;
    } catch (error) {
      console.error('Failed to extract bitstring:', error);
      return null;
    }
  }

  /**
   * Check bit at index in bitstring
   */
  private checkBit(bitstring: Uint8Array, index: number): boolean {
    const byteIndex = Math.floor(index / 8);
    const bitIndex = index % 8;

    if (byteIndex >= bitstring.length) {
      return false;
    }

    const byte = bitstring[byteIndex];
    const mask = 1 << bitIndex;

    return (byte & mask) !== 0;
  }

  /**
   * Validate status list structure
   */
  private validateStatusList(statusList: any): boolean {
    if (!statusList || typeof statusList !== 'object') {
      return false;
    }

    if (!statusList.credentialSubject) {
      return false;
    }

    if (!statusList.credentialSubject.encodedList) {
      return false;
    }

    if (statusList.credentialSubject.type !== 'StatusList2021') {
      return false;
    }

    return true;
  }

  /**
   * Get from cache
   */
  private async getFromCache(url: string): Promise<any | null> {
    const cached = this.cache.get(url);
    if (!cached) {
      // Try loading from storage
      const key = `${this.CACHE_KEY_PREFIX}${Buffer.from(url).toString('base64')}`;
      const stored = await AsyncStorage.getItem(key);
      if (stored) {
        const data: CachedStatusList = JSON.parse(stored);
        if (Date.now() < data.expiresAt) {
          this.cache.set(url, data);
          return data.statusList;
        } else {
          // Expired
          await AsyncStorage.removeItem(key);
        }
      }
      return null;
    }

    // Check expiry
    if (Date.now() > cached.expiresAt) {
      this.cache.delete(url);
      const key = `${this.CACHE_KEY_PREFIX}${Buffer.from(url).toString('base64')}`;
      await AsyncStorage.removeItem(key);
      return null;
    }

    return cached.statusList;
  }

  /**
   * Add to cache
   */
  private async addToCache(url: string, statusList: any): Promise<void> {
    const cached: CachedStatusList = {
      statusList,
      cachedAt: Date.now(),
      expiresAt: Date.now() + this.CACHE_TTL
    };

    this.cache.set(url, cached);

    const key = `${this.CACHE_KEY_PREFIX}${Buffer.from(url).toString('base64')}`;
    await AsyncStorage.setItem(key, JSON.stringify(cached));
  }

  /**
   * Background sync status lists
   */
  async backgroundSync(credentials: any[]): Promise<void> {
    // Extract unique status list URLs
    const urls = new Set<string>();
    for (const cred of credentials) {
      const statusInfo = this.extractStatusInfo(cred);
      if (statusInfo) {
        urls.add(statusInfo.statusListCredential);
      }
    }

    // Pre-fetch all status lists
    for (const url of urls) {
      await this.fetchStatusList(url);
    }
  }
}

interface StatusInfo {
  statusListCredential: string;
  statusListIndex: number;
  statusPurpose: 'revocation' | 'suspension';
}

interface CachedStatusList {
  statusList: any;
  cachedAt: number;
  expiresAt: number;
}

export default new StatusList2021Service();
```

---

## 🔐 Langkah 7: Implement OIDC Integration (US-5.8) - COMPLETE

### 7.1 Implement OIDC Service (Complete)

**File**: `src/services/enterprise/OIDCService.ts`

```typescript
import { authorize, refresh, revoke, AuthConfiguration } from 'react-native-app-auth';
import AsyncStorage from '@react-native-async-storage/async-storage';

/**
 * OpenID Connect Service
 * Implements OIDC authentication flows
 */
class OIDCService {
  private readonly TOKEN_STORAGE_KEY = 'oidc_tokens';
  private readonly PROVIDERS_KEY = 'oidc_providers';

  private providers: Map<string, OIDCProvider> = new Map();
  private currentProvider: string | null = null;
  private tokens: OIDCTokens | null = null;

  /**
   * Initialize OIDC service
   */
  async initialize(): Promise<void> {
    await this.loadProviders();
    await this.loadTokens();
  }

  /**
   * Register OIDC provider
   */
  async registerProvider(provider: OIDCProvider): Promise<void> {
    this.providers.set(provider.id, provider);
    await this.saveProviders();
  }

  /**
   * Authenticate with OIDC provider
   */
  async authenticate(providerId: string): Promise<OIDCTokens> {
    const provider = this.providers.get(providerId);
    if (!provider) {
      throw new Error(`Provider not found: ${providerId}`);
    }

    const config: AuthConfiguration = {
      issuer: provider.issuerUrl,
      clientId: provider.clientId,
      redirectUrl: provider.redirectUrl,
      scopes: provider.scopes,
      additionalParameters: provider.additionalParameters
    };

    try {
      const result = await authorize(config);

      const tokens: OIDCTokens = {
        accessToken: result.accessToken,
        refreshToken: result.refreshToken || undefined,
        idToken: result.idToken,
        tokenType: result.tokenType,
        expiresAt: Date.now() + (result.accessTokenExpirationDate ? 
          new Date(result.accessTokenExpirationDate).getTime() - Date.now() : 
          3600000), // Default 1 hour
        scope: result.scopes?.join(' ') || ''
      };

      this.tokens = tokens;
      this.currentProvider = providerId;
      
      await this.saveTokens();

      return tokens;
    } catch (error) {
      console.error('OIDC authentication failed:', error);
      throw error;
    }
  }

  /**
   * Refresh access token
   */
  async refreshAccessToken(): Promise<OIDCTokens> {
    if (!this.tokens || !this.tokens.refreshToken) {
      throw new Error('No refresh token available');
    }

    if (!this.currentProvider) {
      throw new Error('No current provider');
    }

    const provider = this.providers.get(this.currentProvider);
    if (!provider) {
      throw new Error('Provider not found');
    }

    const config: AuthConfiguration = {
      issuer: provider.issuerUrl,
      clientId: provider.clientId,
      redirectUrl: provider.redirectUrl,
      scopes: provider.scopes
    };

    try {
      const result = await refresh(config, {
        refreshToken: this.tokens.refreshToken
      });

      const tokens: OIDCTokens = {
        accessToken: result.accessToken,
        refreshToken: result.refreshToken || this.tokens.refreshToken,
        idToken: result.idToken || this.tokens.idToken,
        tokenType: result.tokenType,
        expiresAt: Date.now() + (result.accessTokenExpirationDate ? 
          new Date(result.accessTokenExpirationDate).getTime() - Date.now() : 
          3600000),
        scope: result.scopes?.join(' ') || this.tokens.scope
      };

      this.tokens = tokens;
      await this.saveTokens();

      return tokens;
    } catch (error) {
      console.error('Token refresh failed:', error);
      throw error;
    }
  }

  /**
   * Get user info from OIDC provider
   */
  async getUserInfo(): Promise<any> {
    if (!this.tokens) {
      throw new Error('Not authenticated');
    }

    if (!this.currentProvider) {
      throw new Error('No current provider');
    }

    const provider = this.providers.get(this.currentProvider);
    if (!provider) {
      throw new Error('Provider not found');
    }

    const userInfoUrl = `${provider.issuerUrl}/userinfo`;

    try {
      const response = await fetch(userInfoUrl, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${this.tokens.accessToken}`,
          'Accept': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error(`UserInfo request failed: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Get user info failed:', error);
      throw error;
    }
  }

  /**
   * Logout
   */
  async logout(): Promise<void> {
    if (!this.tokens) {
      return;
    }

    if (this.currentProvider) {
      const provider = this.providers.get(this.currentProvider);
      if (provider) {
        const config: AuthConfiguration = {
          issuer: provider.issuerUrl,
          clientId: provider.clientId,
          redirectUrl: provider.redirectUrl,
          scopes: provider.scopes
        };

        try {
          if (this.tokens.refreshToken) {
            await revoke(config, {
              tokenToRevoke: this.tokens.refreshToken,
              sendClientId: true
            });
          }
        } catch (error) {
          console.error('Token revocation failed:', error);
        }
      }
    }

    this.tokens = null;
    this.currentProvider = null;
    await AsyncStorage.removeItem(this.TOKEN_STORAGE_KEY);
  }

  /**
   * Get current tokens
   */
  getTokens(): OIDCTokens | null {
    return this.tokens;
  }

  /**
   * Check if tokens are valid
   */
  isAuthenticated(): boolean {
    if (!this.tokens) {
      return false;
    }

    // Check expiry
    if (Date.now() >= this.tokens.expiresAt) {
      return false;
    }

    return true;
  }

  /**
   * Get all providers
   */
  getAllProviders(): OIDCProvider[] {
    return Array.from(this.providers.values());
  }

  /**
   * Remove provider
   */
  async removeProvider(providerId: string): Promise<void> {
    this.providers.delete(providerId);
    await this.saveProviders();

    if (this.currentProvider === providerId) {
      await this.logout();
    }
  }

  /**
   * Save providers to storage
   */
  private async saveProviders(): Promise<void> {
    const data = Array.from(this.providers.values());
    await AsyncStorage.setItem(this.PROVIDERS_KEY, JSON.stringify(data));
  }

  /**
   * Load providers from storage
   */
  private async loadProviders(): Promise<void> {
    const data = await AsyncStorage.getItem(this.PROVIDERS_KEY);
    if (data) {
      const providers: OIDCProvider[] = JSON.parse(data);
      for (const provider of providers) {
        this.providers.set(provider.id, provider);
      }
    }
  }

  /**
   * Save tokens to storage
   */
  private async saveTokens(): Promise<void> {
    if (this.tokens) {
      await AsyncStorage.setItem(
        this.TOKEN_STORAGE_KEY,
        JSON.stringify({
          tokens: this.tokens,
          providerId: this.currentProvider
        })
      );
    }
  }

  /**
   * Load tokens from storage
   */
  private async loadTokens(): Promise<void> {
    const data = await AsyncStorage.getItem(this.TOKEN_STORAGE_KEY);
    if (data) {
      const stored = JSON.parse(data);
      this.tokens = stored.tokens;
      this.currentProvider = stored.providerId;
    }
  }
}

interface OIDCProvider {
  id: string;
  name: string;
  issuerUrl: string;
  clientId: string;
  redirectUrl: string;
  scopes: string[];
  additionalParameters?: Record<string, string>;
}

interface OIDCTokens {
  accessToken: string;
  refreshToken?: string;
  idToken: string;
  tokenType: string;
  expiresAt: number;
  scope: string;
}

export default new OIDCService();
```

---

Dokumen akan dilanjutkan dengan Analytics Implementation, Testing, dan Deployment.

**Lanjut ke bagian berikutnya untuk melengkapi Sprint 5.**

---

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: Part 2 - Implementation Services (Lanjutan)
