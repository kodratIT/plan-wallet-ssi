# Sprint 1: Security Hardening - Setup & Implementation Guide

## 📋 Overview

Panduan ini memberikan step-by-step instructions untuk mengimplementasikan fitur keamanan di Sprint 1: PIN recovery, biometric authentication, secure backup, dan security features lainnya.

---

## 🎯 Prerequisites

Sebelum mulai Sprint 1, pastikan:
- ✅ Sprint 0 selesai (development environment ready)
- ✅ Project running tanpa error
- ✅ Git repository setup
- ✅ Team members assigned ke user stories

---

## 📦 Step 1: Install Security Dependencies

### 1.1 Install Expo Security Libraries

```bash
# Expo security packages
npx expo install expo-secure-store
npx expo install expo-local-authentication
npx expo install expo-crypto

# AsyncStorage untuk non-sensitive data
npm install @react-native-async-storage/async-storage

# Keychain untuk iOS/Android
npm install react-native-keychain

# Cryptography
npm install argon2-react-native
npm install bip39  # Untuk mnemonic generation

# Testing
npm install --save-dev @testing-library/react-native
npm install --save-dev jest-expo
```

### 1.2 Platform-Specific Setup

#### iOS (macOS only)
```bash
cd ios
pod install
cd ..
```

#### Android
No additional setup required untuk Expo managed workflow.

### 1.3 Verify Installation

```bash
# Start the app
npx expo start

# Test imports
# Buat file test-imports.ts:
```

```typescript
// test-imports.ts
import * as SecureStore from 'expo-secure-store';
import * as LocalAuthentication from 'expo-local-authentication';
import * as Crypto from 'expo-crypto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as Keychain from 'react-native-keychain';
import * as bip39 from 'bip39';

console.log('All security libraries imported successfully!');
```

---

## 🔐 Step 2: Implement Secure Storage Service (US-1.7)

### 2.1 Create Security Service Structure

```bash
mkdir -p src/services/security
mkdir -p src/types/security
```

### 2.2 Create SecureStorage Service

**File**: `src/services/security/SecureStorage.ts`

```typescript
import * as SecureStore from 'expo-secure-store';
import * as Crypto from 'expo-crypto';
import AsyncStorage from '@react-native-async-storage/async-storage';

export enum StorageKey {
  MASTER_KEY = 'wallet_master_key',
  PIN_HASH = 'wallet_pin_hash',
  MNEMONIC = 'wallet_mnemonic',
  BIOMETRIC_KEY = 'wallet_biometric_key',
  CREDENTIALS = 'wallet_credentials',
  SETTINGS = 'wallet_settings'
}

class SecureStorageService {
  private static instance: SecureStorageService;
  
  private constructor() {}
  
  static getInstance(): SecureStorageService {
    if (!SecureStorageService.instance) {
      SecureStorageService.instance = new SecureStorageService();
    }
    return SecureStorageService.instance;
  }

  /**
   * Store sensitive data dengan hardware-backed storage
   */
  async setSecureItem(key: string, value: string): Promise<void> {
    try {
      const options = {
        keychainAccessible: SecureStore.WHEN_UNLOCKED,
      };
      await SecureStore.setItemAsync(key, value, options);
    } catch (error) {
      console.error('SecureStore error, falling back to encrypted AsyncStorage');
      // Fallback: encrypt dan simpan di AsyncStorage
      const encrypted = await this.encrypt(value);
      await AsyncStorage.setItem(key, encrypted);
    }
  }

  /**
   * Retrieve sensitive data
   */
  async getSecureItem(key: string): Promise<string | null> {
    try {
      return await SecureStore.getItemAsync(key);
    } catch (error) {
      console.error('SecureStore error, trying encrypted AsyncStorage');
      const encrypted = await AsyncStorage.getItem(key);
      if (encrypted) {
        return await this.decrypt(encrypted);
      }
      return null;
    }
  }

  /**
   * Delete sensitive data dengan secure deletion
   */
  async deleteSecureItem(key: string): Promise<void> {
    try {
      await SecureStore.deleteItemAsync(key);
    } catch (error) {
      await AsyncStorage.removeItem(key);
    }
  }

  /**
   * Encrypt data menggunakan AES-256
   */
  private async encrypt(data: string): Promise<string> {
    // Implementation menggunakan expo-crypto atau native crypto
    const key = await this.getMasterKey();
    // ... encryption logic
    return encrypted;
  }

  /**
   * Decrypt data
   */
  private async decrypt(encrypted: string): Promise<string> {
    const key = await this.getMasterKey();
    // ... decryption logic
    return decrypted;
  }

  /**
   * Generate atau retrieve master key
   */
  private async getMasterKey(): Promise<string> {
    let masterKey = await this.getSecureItem(StorageKey.MASTER_KEY);
    if (!masterKey) {
      // Generate new master key
      masterKey = await Crypto.getRandomBytesAsync(32).then(
        bytes => bytes.toString()
      );
      await this.setSecureItem(StorageKey.MASTER_KEY, masterKey);
    }
    return masterKey;
  }

  /**
   * Key rotation untuk enhanced security
   */
  async rotateKeys(): Promise<void> {
    // Implementasi key rotation logic
    console.log('Rotating encryption keys...');
    // ... rotation logic
  }
}

export default SecureStorageService.getInstance();
```

### 2.3 Test Secure Storage

**File**: `src/services/security/__tests__/SecureStorage.test.ts`

```typescript
import SecureStorage, { StorageKey } from '../SecureStorage';

describe('SecureStorage', () => {
  it('should store and retrieve data', async () => {
    await SecureStorage.setSecureItem('test_key', 'test_value');
    const value = await SecureStorage.getSecureItem('test_key');
    expect(value).toBe('test_value');
  });

  it('should delete data securely', async () => {
    await SecureStorage.setSecureItem('test_key', 'test_value');
    await SecureStorage.deleteSecureItem('test_key');
    const value = await SecureStorage.getSecureItem('test_key');
    expect(value).toBeNull();
  });
});
```

---

## 🔑 Step 3: Implement PIN Recovery (US-1.1)

### 3.1 Create PIN Recovery Service

**File**: `src/services/security/PINRecovery.ts`

```typescript
import * as bip39 from 'bip39';
import * as Crypto from 'expo-crypto';
import SecureStorage, { StorageKey } from './SecureStorage';

interface RecoveryOptions {
  useMnemonic: boolean;
  useSecurityQuestions: boolean;
}

class PINRecoveryService {
  /**
   * Generate recovery mnemonic (12 atau 24 words)
   */
  async generateRecoveryMnemonic(wordCount: 12 | 24 = 24): Promise<string> {
    const strength = wordCount === 12 ? 128 : 256;
    const mnemonic = bip39.generateMnemonic(strength);
    
    // Encrypt dan store
    await SecureStorage.setSecureItem(StorageKey.MNEMONIC, mnemonic);
    
    return mnemonic;
  }

  /**
   * Validate recovery mnemonic
   */
  validateMnemonic(mnemonic: string): boolean {
    return bip39.validateMnemonic(mnemonic);
  }

  /**
   * Recover PIN menggunakan mnemonic
   */
  async recoverPINWithMnemonic(mnemonic: string): Promise<string | null> {
    if (!this.validateMnemonic(mnemonic)) {
      throw new Error('Invalid mnemonic phrase');
    }

    // Verify dengan stored mnemonic
    const storedMnemonic = await SecureStorage.getSecureItem(StorageKey.MNEMONIC);
    
    if (mnemonic === storedMnemonic) {
      // Derive PIN dari mnemonic
      const seed = bip39.mnemonicToSeedSync(mnemonic);
      const pin = this.derivePINFromSeed(seed);
      return pin;
    }
    
    return null;
  }

  /**
   * Derive PIN dari seed
   */
  private derivePINFromSeed(seed: Buffer): string {
    // Gunakan first 6 digits dari seed hash
    const hash = Crypto.digestStringAsync(
      Crypto.CryptoDigestAlgorithm.SHA256,
      seed.toString('hex')
    ).then(hash => {
      // Extract 6 digits
      const pin = parseInt(hash.substring(0, 8), 16) % 1000000;
      return pin.toString().padStart(6, '0');
    });
    
    return hash;
  }

  /**
   * Setup security questions (optional fallback)
   */
  async setupSecurityQuestions(questions: Array<{question: string, answer: string}>): Promise<void> {
    const encrypted = JSON.stringify(questions);
    await SecureStorage.setSecureItem('security_questions', encrypted);
  }

  /**
   * Verify security questions
   */
  async verifySecurityQuestions(answers: string[]): Promise<boolean> {
    const stored = await SecureStorage.getSecureItem('security_questions');
    if (!stored) return false;
    
    const questions = JSON.parse(stored);
    // Compare answers (case-insensitive, trimmed)
    return questions.every((q, i) => 
      q.answer.toLowerCase().trim() === answers[i].toLowerCase().trim()
    );
  }
}

export default new PINRecoveryService();
```

### 3.2 Create PIN Recovery UI

**File**: `src/components/security/PINRecoveryUI.tsx`

```typescript
import React, { useState } from 'react';
import { View, Text, TextInput, Button, StyleSheet, ScrollView } from 'react-native';
import PINRecoveryService from '../../services/security/PINRecovery';

export const PINRecoverySetup: React.FC = () => {
  const [mnemonic, setMnemonic] = useState<string>('');
  const [showMnemonic, setShowMnemonic] = useState(false);

  const generateMnemonic = async () => {
    const newMnemonic = await PINRecoveryService.generateRecoveryMnemonic(24);
    setMnemonic(newMnemonic);
    setShowMnemonic(true);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Setup PIN Recovery</Text>
      <Text style={styles.description}>
        Generate a recovery phrase untuk memulihkan PIN Anda jika lupa.
      </Text>
      
      <Button title="Generate Recovery Phrase" onPress={generateMnemonic} />
      
      {showMnemonic && (
        <View style={styles.mnemonicContainer}>
          <Text style={styles.warning}>
            ⚠️ Tulis dan simpan recovery phrase ini di tempat yang aman!
          </Text>
          <Text style={styles.mnemonic}>{mnemonic}</Text>
        </View>
      )}
    </View>
  );
};

export const PINRecoveryRestore: React.FC = () => {
  const [mnemonic, setMnemonic] = useState('');
  const [pin, setPin] = useState<string | null>(null);

  const recoverPIN = async () => {
    try {
      const recoveredPIN = await PINRecoveryService.recoverPINWithMnemonic(mnemonic);
      setPin(recoveredPIN);
    } catch (error) {
      alert('Invalid recovery phrase');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Recover PIN</Text>
      <Text style={styles.description}>
        Masukkan 24-word recovery phrase Anda
      </Text>
      
      <TextInput
        style={styles.input}
        value={mnemonic}
        onChangeText={setMnemonic}
        placeholder="Enter recovery phrase..."
        multiline
        numberOfLines={4}
        autoCapitalize="none"
      />
      
      <Button title="Recover PIN" onPress={recoverPIN} />
      
      {pin && (
        <View style={styles.successContainer}>
          <Text style={styles.success}>✅ PIN Recovered: {pin}</Text>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  description: {
    fontSize: 14,
    color: '#666',
    marginBottom: 20,
  },
  mnemonicContainer: {
    marginTop: 20,
    padding: 15,
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
  },
  warning: {
    color: '#ff6600',
    fontWeight: 'bold',
    marginBottom: 10,
  },
  mnemonic: {
    fontSize: 16,
    lineHeight: 24,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    padding: 10,
    marginBottom: 20,
    minHeight: 100,
  },
  successContainer: {
    marginTop: 20,
    padding: 15,
    backgroundColor: '#d4edda',
    borderRadius: 8,
  },
  success: {
    color: '#155724',
    fontSize: 16,
    fontWeight: 'bold',
  },
});
```

---

## 👆 Step 4: Implement Biometric Authentication (US-1.2)

### 4.1 Create Biometric Service

**File**: `src/services/security/BiometricAuth.ts`

```typescript
import * as LocalAuthentication from 'expo-local-authentication';
import * as Crypto from 'expo-crypto';
import SecureStorage, { StorageKey } from './SecureStorage';

export enum BiometricType {
  FACE_ID = 'FACE_ID',
  TOUCH_ID = 'TOUCH_ID',
  FINGERPRINT = 'FINGERPRINT',
  NONE = 'NONE'
}

class BiometricAuthService {
  /**
   * Check if biometric hardware available
   */
  async isAvailable(): Promise<boolean> {
    const hasHardware = await LocalAuthentication.hasHardwareAsync();
    const isEnrolled = await LocalAuthentication.isEnrolledAsync();
    return hasHardware && isEnrolled;
  }

  /**
   * Get supported biometric types
   */
  async getSupportedTypes(): Promise<BiometricType[]> {
    const types = await LocalAuthentication.supportedAuthenticationTypesAsync();
    return types.map(type => {
      switch (type) {
        case LocalAuthentication.AuthenticationType.FACIAL_RECOGNITION:
          return BiometricType.FACE_ID;
        case LocalAuthentication.AuthenticationType.FINGERPRINT:
          return BiometricType.FINGERPRINT;
        default:
          return BiometricType.NONE;
      }
    });
  }

  /**
   * Authenticate dengan biometric
   */
  async authenticate(promptMessage: string = 'Authenticate to access wallet'): Promise<boolean> {
    try {
      const result = await LocalAuthentication.authenticateAsync({
        promptMessage,
        fallbackLabel: 'Use PIN',
        disableDeviceFallback: false,
        cancelLabel: 'Cancel'
      });
      
      return result.success;
    } catch (error) {
      console.error('Biometric authentication error:', error);
      return false;
    }
  }

  /**
   * Generate biometric-bound key untuk credential encryption
   */
  async generateBiometricKey(credentialId: string): Promise<string> {
    // Authenticate first
    const authenticated = await this.authenticate('Authenticate to bind credential');
    
    if (!authenticated) {
      throw new Error('Biometric authentication failed');
    }

    // Generate key yang terikat dengan biometric
    const key = await Crypto.getRandomBytesAsync(32).then(
      bytes => bytes.toString()
    );

    // Store key dengan biometric protection
    await SecureStorage.setSecureItem(
      `${StorageKey.BIOMETRIC_KEY}_${credentialId}`,
      key
    );

    return key;
  }

  /**
   * Retrieve biometric-bound key
   */
  async getBiometricKey(credentialId: string): Promise<string | null> {
    // Authenticate first
    const authenticated = await this.authenticate('Authenticate to access credential');
    
    if (!authenticated) {
      return null;
    }

    return await SecureStorage.getSecureItem(
      `${StorageKey.BIOMETRIC_KEY}_${credentialId}`
    );
  }

  /**
   * Encrypt credential dengan biometric key
   */
  async encryptCredential(credentialId: string, data: string): Promise<string> {
    const key = await this.generateBiometricKey(credentialId);
    // Implement encryption dengan key
    // ... encryption logic
    return encrypted;
  }

  /**
   * Decrypt credential dengan biometric authentication
   */
  async decryptCredential(credentialId: string, encrypted: string): Promise<string | null> {
    const key = await this.getBiometricKey(credentialId);
    
    if (!key) {
      return null;
    }

    // Implement decryption
    // ... decryption logic
    return decrypted;
  }
}

export default new BiometricAuthService();
```

### 4.2 Create Biometric Prompt Component

**File**: `src/components/security/BiometricPrompt.tsx`

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import BiometricAuth, { BiometricType } from '../../services/security/BiometricAuth';

interface BiometricPromptProps {
  onSuccess: () => void;
  onFallback: () => void;
  promptMessage?: string;
}

export const BiometricPrompt: React.FC<BiometricPromptProps> = ({
  onSuccess,
  onFallback,
  promptMessage = 'Authenticate to continue'
}) => {
  const [available, setAvailable] = useState(false);
  const [biometricType, setBiometricType] = useState<BiometricType>(BiometricType.NONE);

  useEffect(() => {
    checkBiometric();
  }, []);

  const checkBiometric = async () => {
    const isAvailable = await BiometricAuth.isAvailable();
    setAvailable(isAvailable);

    if (isAvailable) {
      const types = await BiometricAuth.getSupportedTypes();
      setBiometricType(types[0] || BiometricType.NONE);
    }
  };

  const handleAuthenticate = async () => {
    const success = await BiometricAuth.authenticate(promptMessage);
    
    if (success) {
      onSuccess();
    } else {
      // Show fallback option
      onFallback();
    }
  };

  if (!available) {
    return (
      <View style={styles.container}>
        <Text>Biometric authentication not available</Text>
        <Button title="Use PIN" onPress={onFallback} />
      </View>
    );
  }

  const getBiometricIcon = () => {
    switch (biometricType) {
      case BiometricType.FACE_ID:
        return '👤';
      case BiometricType.TOUCH_ID:
      case BiometricType.FINGERPRINT:
        return '👆';
      default:
        return '🔒';
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.icon}>{getBiometricIcon()}</Text>
      <Text style={styles.title}>Biometric Authentication</Text>
      <Text style={styles.description}>{promptMessage}</Text>
      
      <Button title="Authenticate" onPress={handleAuthenticate} />
      <Button title="Use PIN Instead" onPress={onFallback} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    alignItems: 'center',
  },
  icon: {
    fontSize: 64,
    marginBottom: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  description: {
    fontSize: 14,
    color: '#666',
    marginBottom: 20,
    textAlign: 'center',
  },
});
```

---

## 💾 Step 5: Implement Secure Backup (US-1.4)

### 5.1 Create Backup Service

**File**: `src/services/security/BackupService.ts`

```typescript
import * as FileSystem from 'expo-file-system';
import * as Crypto from 'expo-crypto';
import SecureStorage from './SecureStorage';

interface BackupData {
  version: string;
  timestamp: number;
  credentials: any[];
  connections: any[];
  settings: any;
}

class BackupService {
  /**
   * Create encrypted backup
   */
  async createBackup(password: string): Promise<string> {
    // Gather all wallet data
    const backupData: BackupData = {
      version: '1.0.0',
      timestamp: Date.now(),
      credentials: await this.getCredentials(),
      connections: await this.getConnections(),
      settings: await this.getSettings()
    };

    // Encrypt backup
    const encrypted = await this.encryptBackup(JSON.stringify(backupData), password);
    
    return encrypted;
  }

  /**
   * Encrypt backup dengan AES-256
   */
  private async encryptBackup(data: string, password: string): Promise<string> {
    // Derive key dari password menggunakan Argon2
    const salt = await Crypto.getRandomBytesAsync(16);
    const key = await this.deriveKey(password, salt);

    // Encrypt data
    // ... encryption implementation
    
    return encrypted;
  }

  /**
   * Derive encryption key dari password
   */
  private async deriveKey(password: string, salt: Uint8Array): Promise<string> {
    // Use Argon2 untuk key derivation
    // ... Argon2 implementation
    return key;
  }

  /**
   * Export backup ke file
   */
  async exportToFile(encrypted: string): Promise<string> {
    const fileName = `wallet_backup_${Date.now()}.enc`;
    const filePath = `${FileSystem.documentDirectory}${fileName}`;
    
    await FileSystem.writeAsStringAsync(filePath, encrypted);
    
    return filePath;
  }

  /**
   * Restore dari encrypted backup
   */
  async restoreBackup(encrypted: string, password: string): Promise<BackupData> {
    try {
      const decrypted = await this.decryptBackup(encrypted, password);
      const backupData: BackupData = JSON.parse(decrypted);
      
      // Verify backup integrity
      if (!this.verifyBackup(backupData)) {
        throw new Error('Backup verification failed');
      }

      // Restore data
      await this.restoreCredentials(backupData.credentials);
      await this.restoreConnections(backupData.connections);
      await this.restoreSettings(backupData.settings);

      return backupData;
    } catch (error) {
      throw new Error('Failed to restore backup: ' + error.message);
    }
  }

  /**
   * Verify backup integrity
   */
  private verifyBackup(backup: BackupData): boolean {
    return (
      backup.version &&
      backup.timestamp &&
      Array.isArray(backup.credentials) &&
      Array.isArray(backup.connections) &&
      backup.settings !== undefined
    );
  }

  // Helper methods
  private async getCredentials(): Promise<any[]> {
    // Implementation
    return [];
  }

  private async getConnections(): Promise<any[]> {
    // Implementation
    return [];
  }

  private async getSettings(): Promise<any> {
    // Implementation
    return {};
  }

  private async restoreCredentials(credentials: any[]): Promise<void> {
    // Implementation
  }

  private async restoreConnections(connections: any[]): Promise<void> {
    // Implementation
  }

  private async restoreSettings(settings: any): Promise<void> {
    // Implementation
  }

  private async decryptBackup(encrypted: string, password: string): Promise<string> {
    // Implementation
    return decrypted;
  }
}

export default new BackupService();
```

---

## ⏰ Step 6: Implement Auto-Lock (US-1.3)

### 6.1 Create Auto-Lock Service

**File**: `src/services/security/AutoLockService.ts`

```typescript
import { AppState, AppStateStatus } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export enum LockTimeout {
  THIRTY_SECONDS = 30,
  ONE_MINUTE = 60,
  FIVE_MINUTES = 300,
  FIFTEEN_MINUTES = 900,
  THIRTY_MINUTES = 1800,
  NEVER = -1
}

class AutoLockService {
  private timeout: LockTimeout = LockTimeout.FIVE_MINUTES;
  private lastActivity: number = Date.now();
  private timer: NodeJS.Timeout | null = null;
  private onLockCallback: (() => void) | null = null;

  constructor() {
    this.initializeAppStateListener();
  }

  /**
   * Initialize app state listener
   */
  private initializeAppStateListener() {
    AppState.addEventListener('change', this.handleAppStateChange);
  }

  /**
   * Handle app state changes
   */
  private handleAppStateChange = (nextAppState: AppStateStatus) => {
    if (nextAppState === 'background' || nextAppState === 'inactive') {
      this.startLockTimer();
    } else if (nextAppState === 'active') {
      this.resetTimer();
    }
  };

  /**
   * Set lock timeout
   */
  async setTimeout(timeout: LockTimeout): Promise<void> {
    this.timeout = timeout;
    await AsyncStorage.setItem('autoLockTimeout', timeout.toString());
    this.resetTimer();
  }

  /**
   * Get current timeout
   */
  async getTimeout(): Promise<LockTimeout> {
    const stored = await AsyncStorage.getItem('autoLockTimeout');
    return stored ? parseInt(stored) : LockTimeout.FIVE_MINUTES;
  }

  /**
   * Register lock callback
   */
  onLock(callback: () => void) {
    this.onLockCallback = callback;
  }

  /**
   * Start lock timer
   */
  private startLockTimer() {
    if (this.timeout === LockTimeout.NEVER) {
      return;
    }

    this.clearTimer();
    
    const timeUntilLock = this.timeout * 1000 - (Date.now() - this.lastActivity);
    
    if (timeUntilLock <= 0) {
      this.lock();
    } else {
      this.timer = setTimeout(() => {
        this.lock();
      }, timeUntilLock);
    }
  }

  /**
   * Reset activity timer
   */
  resetTimer() {
    this.lastActivity = Date.now();
    this.clearTimer();
    
    if (this.timeout !== LockTimeout.NEVER) {
      this.timer = setTimeout(() => {
        this.lock();
      }, this.timeout * 1000);
    }
  }

  /**
   * Clear timer
   */
  private clearTimer() {
    if (this.timer) {
      clearTimeout(this.timer);
      this.timer = null;
    }
  }

  /**
   * Lock wallet immediately
   */
  lock() {
    this.clearTimer();
    if (this.onLockCallback) {
      this.onLockCallback();
    }
  }

  /**
   * Update last activity (call on user interaction)
   */
  updateActivity() {
    this.resetTimer();
  }
}

export default new AutoLockService();
```

---

## 📝 Step 7: Testing

### 7.1 Run Unit Tests

```bash
npm test
```

### 7.2 Test on Devices

```bash
# iOS
npx expo run:ios

# Android
npx expo run:android
```

### 7.3 Test Biometric on Physical Devices

Biometric testing HARUS dilakukan pada physical devices:
- iOS: iPhone dengan Face ID atau Touch ID
- Android: Device dengan fingerprint sensor

---

## 🔗 Next Steps

Setelah Sprint 1 selesai:
1. Sprint Review & Demo
2. Sprint Retrospective
3. Update Sprint 2 backlog
4. Start Sprint 2: Credential Management

---

**Documentation Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Ready for Implementation
