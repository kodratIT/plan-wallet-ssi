# Sprint 1: Penguatan Keamanan & Pemulihan PIN - Ringkasan Cepat

## 📊 Overview

**Sprint**: Sprint 1 (Security Hardening)  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Story Points**: 89 SP  
**Prioritas**: KRITIS - Foundation keamanan wallet

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan fitur keamanan kritis: pemulihan PIN, pengikatan biometrik, dan perlindungan wallet yang ditingkatkan."*

### Objectives
1. ✅ PIN recovery mechanism
2. ✅ Biometric credential binding
3. ✅ Secure backup & restore
4. ✅ Enhanced auto-lock
5. ✅ Wallet migration tool
6. ✅ Security audit preparation
7. ✅ Audit logging

---

## 📋 User Stories Summary

| ID | User Story | Story Points | Prioritas | Assignee |
|----|-----------|--------------|-----------|----------|
| US-1.1 | PIN Recovery Mechanism | 13 | Must Have | Security Engineer + RN Dev 1 |
| US-1.2 | Biometric Credential Binding | 13 | Must Have | Security Engineer + RN Dev 2 |
| US-1.3 | Enhanced Auto-Lock | 8 | Should Have | React Native Dev 1 |
| US-1.4 | Secure Backup & Restore | 13 | Must Have | Security Engineer + RN Dev 1 |
| US-1.5 | Wallet Migration Tool | 8 | Must Have | React Native Dev 2 |
| US-1.6 | Security Audit Preparation | 5 | Should Have | Security Engineer |
| US-1.7 | Enhanced Keychain/Secure Storage | 8 | Must Have | Security Engineer + RN Dev 2 |
| US-1.8 | Rate Limiting & Brute Force Protection | 5 | Should Have | Security Engineer |
| US-1.9 | Audit Logging | 8 | Should Have | React Native Dev 1 |
| US-1.10 | Security Settings UI Overhaul | 8 | Must Have | UI/UX Designer + RN Dev 2 |

**Total**: 89 Story Points

---

## 🔑 Key Deliverables

### 1. PIN Recovery (US-1.1)
- Mnemonic-based recovery (12/24 kata)
- Security questions (optional)
- Encrypted backup recovery data
- Recovery UI yang user-friendly

### 2. Biometric Binding (US-1.2)
- Face ID / Touch ID (iOS)
- Fingerprint (Android)
- Credential encryption dengan biometric key
- Fallback ke PIN

### 3. Secure Backup (US-1.4)
- End-to-end encryption (AES-256)
- Cloud backup (iCloud/Google Drive)
- Manual export
- Backup verification

### 4. Auto-Lock (US-1.3)
- Configurable timeout (30s - Never)
- Background state detection
- Immediate lock option
- Lock on device lock

### 5. Migration Tool (US-1.5)
- Detect old wallet version
- Migrate credentials, connections, settings
- Migration verification
- Rollback capability

### 6. Enhanced Security (US-1.7, US-1.8, US-1.9)
- Hardware-backed keys
- Key rotation
- Rate limiting (max 5 attempts)
- Comprehensive audit logging
- Secure deletion

### 7. Security UI (US-1.10)
- New security settings screen
- Security status dashboard
- Clear explanations
- Security recommendations

---

## 🛠️ Tech Stack & Dependencies

### Security Libraries
```json
{
  "expo-secure-store": "~12.5.0",
  "expo-local-authentication": "~13.8.0",
  "expo-crypto": "~12.6.0",
  "@react-native-async-storage/async-storage": "^1.19.0",
  "react-native-keychain": "^8.1.0",
  "argon2-react-native": "^1.0.0",
  "bip39": "^3.1.0"
}
```

### Installation
```bash
npx expo install expo-secure-store expo-local-authentication expo-crypto
npm install @react-native-async-storage/async-storage
npm install react-native-keychain argon2-react-native bip39
```

---

## 📅 Sprint Timeline

### Week 1: Core Security (34 SP)
**Days 1-2**: Setup & Architecture
- [ ] Security libraries installation
- [ ] Secure storage architecture
- [ ] Security documentation start

**Days 3-5**: PIN Recovery & Backup
- [ ] US-1.1: PIN Recovery (13 SP)
- [ ] US-1.4: Secure Backup (13 SP)
- [ ] US-1.7: Enhanced Keychain (8 SP)

### Week 2: Biometric & Migration (29 SP)
**Days 1-3**: Biometric
- [ ] US-1.2: Biometric Binding (13 SP)
- [ ] Test di iOS & Android

**Days 4-5**: Auto-Lock & Migration
- [ ] US-1.3: Auto-Lock (8 SP)
- [ ] US-1.5: Migration Tool (8 SP)

### Week 3: Protection & Logging (18 SP)
**Days 1-2**: Rate Limiting
- [ ] US-1.8: Rate Limiting (5 SP)

**Days 3-5**: Logging & Audit Prep
- [ ] US-1.9: Audit Logging (8 SP)
- [ ] US-1.6: Audit Preparation (5 SP)

### Week 4: UI & Testing (8 SP + Testing)
**Days 1-2**: Security UI
- [ ] US-1.10: Security Settings UI (8 SP)

**Days 3-4**: Testing & Bug Fixing
- [ ] Integration testing
- [ ] Security testing
- [ ] Bug fixes

**Day 5**: Review & Retrospective
- [ ] Sprint review demo
- [ ] Retrospective
- [ ] Sprint 2 planning prep

---

## 🔒 Security Features Overview

### Threat Model
| Threat | Mitigation | User Story |
|--------|-----------|------------|
| Brute Force Attack | Rate limiting, progressive delays | US-1.8 |
| Data Theft | Encryption, biometric binding | US-1.2, US-1.7 |
| Device Loss | PIN recovery, secure backup | US-1.1, US-1.4 |
| Unauthorized Access | Auto-lock, biometric auth | US-1.3, US-1.2 |
| Data Corruption | Backup verification | US-1.4 |

### Security Layers
1. **Device Security**: Auto-lock, biometric
2. **Data Security**: Encryption, secure storage
3. **Access Security**: PIN, rate limiting
4. **Recovery Security**: Mnemonic, backup
5. **Audit Security**: Logging, monitoring

---

## 📚 Key Commands & Code Snippets

### Secure Storage
```typescript
import * as SecureStore from 'expo-secure-store';

// Save
await SecureStore.setItemAsync('key', 'value', {
  keychainAccessible: SecureStore.WHEN_UNLOCKED
});

// Read
const value = await SecureStore.getItemAsync('key');

// Delete
await SecureStore.deleteItemAsync('key');
```

### Biometric Authentication
```typescript
import * as LocalAuthentication from 'expo-local-authentication';

// Check availability
const hasHardware = await LocalAuthentication.hasHardwareAsync();
const isEnrolled = await LocalAuthentication.isEnrolledAsync();

// Authenticate
const result = await LocalAuthentication.authenticateAsync({
  promptMessage: 'Authenticate to access wallet',
  fallbackLabel: 'Use PIN',
  disableDeviceFallback: false
});

if (result.success) {
  // Access granted
}
```

### PIN Recovery (Mnemonic)
```typescript
import * as bip39 from 'bip39';

// Generate mnemonic
const mnemonic = bip39.generateMnemonic(256); // 24 words

// Validate
const isValid = bip39.validateMnemonic(mnemonic);

// Recover
if (isValid) {
  const seed = bip39.mnemonicToSeedSync(mnemonic);
  // Derive PIN dari seed
}
```

### Encrypted Backup
```typescript
import * as Crypto from 'expo-crypto';

// Encrypt
const encrypt = async (data: string, password: string) => {
  const key = await Crypto.digestStringAsync(
    Crypto.CryptoDigestAlgorithm.SHA256,
    password
  );
  // Use key untuk encrypt data
  return encryptedData;
};

// Decrypt
const decrypt = async (encryptedData: string, password: string) => {
  const key = await Crypto.digestStringAsync(
    Crypto.CryptoDigestAlgorithm.SHA256,
    password
  );
  // Decrypt data
  return data;
};
```

---

## ✅ Acceptance Criteria Checklist

### US-1.1: PIN Recovery
- [ ] Mnemonic 12/24 kata generated
- [ ] Mnemonic tersimpan encrypted
- [ ] Recovery UI jelas dan mudah
- [ ] Tidak bisa bypass tanpa mnemonic
- [ ] Tested dengan berbagai skenario

### US-1.2: Biometric Binding
- [ ] Face ID/Touch ID (iOS) working
- [ ] Fingerprint (Android) working
- [ ] Credential encrypted dengan biometric key
- [ ] Fallback ke PIN berfungsi
- [ ] Per-credential setting

### US-1.3: Auto-Lock
- [ ] Timeout configurable (30s-Never)
- [ ] Background detection working
- [ ] Immediate lock berfungsi
- [ ] Lock pada device lock
- [ ] Settings UI

### US-1.4: Secure Backup
- [ ] Backup encrypted (AES-256)
- [ ] Cloud backup (iCloud/Drive) working
- [ ] Manual export berfungsi
- [ ] Restore tested successfully
- [ ] Backup verification

### US-1.5: Migration Tool
- [ ] Detect old version
- [ ] Migrate semua data
- [ ] Verification successful
- [ ] Tested dengan v0.5.x

### US-1.6: Audit Prep
- [ ] Architecture documented
- [ ] Threat model created
- [ ] Security controls documented
- [ ] Checklist prepared

### US-1.7: Enhanced Keychain
- [ ] Hardware-backed keys
- [ ] Key rotation implemented
- [ ] Secure deletion
- [ ] Access logging

### US-1.8: Rate Limiting
- [ ] Max 5 attempts
- [ ] Progressive delays
- [ ] Wallet wipe option (optional)
- [ ] Recovery mechanism

### US-1.9: Audit Logging
- [ ] Login/logout logged
- [ ] Credential ops logged
- [ ] Security events logged
- [ ] Privacy-compliant (no PII)
- [ ] Log viewer (dev mode)

### US-1.10: Security UI
- [ ] New settings screen
- [ ] Status dashboard
- [ ] Clear explanations
- [ ] Security recommendations

---

## 🧪 Testing Checklist

### Unit Tests
- [ ] Secure storage tests
- [ ] PIN recovery logic tests
- [ ] Biometric service tests
- [ ] Encryption/decryption tests
- [ ] Rate limiting tests

### Integration Tests
- [ ] End-to-end PIN recovery flow
- [ ] Biometric authentication flow
- [ ] Backup/restore flow
- [ ] Migration flow

### Platform Tests
- [ ] iOS testing (simulator + device)
- [ ] Android testing (emulator + device)
- [ ] Face ID testing (iPhone X+)
- [ ] Touch ID testing (iPhone with Touch ID)
- [ ] Fingerprint testing (Android)

### Security Tests
- [ ] Brute force attack test
- [ ] Data encryption verification
- [ ] Secure storage verification
- [ ] Memory dump analysis
- [ ] Network traffic analysis

---

## 🐛 Common Issues & Solutions

### Issue: Biometric Not Available
```typescript
// Check and handle gracefully
const hasHardware = await LocalAuthentication.hasHardwareAsync();
const isEnrolled = await LocalAuthentication.isEnrolledAsync();

if (!hasHardware || !isEnrolled) {
  // Fall back ke PIN only
  showWarning('Biometric not available, using PIN');
}
```

### Issue: Secure Store Fails
```typescript
// Implement fallback
try {
  await SecureStore.setItemAsync(key, value);
} catch (error) {
  // Use AsyncStorage dengan encryption
  const encrypted = await encrypt(value, masterKey);
  await AsyncStorage.setItem(key, encrypted);
}
```

### Issue: Migration Errors
```typescript
// Handle migration errors gracefully
try {
  await migrateData();
} catch (error) {
  // Log error dan continue
  logError('Migration failed', error);
  // Offer manual migration
  showMigrationError();
}
```

---

## 📊 Sprint Metrics

### Velocity
- **Planned**: 89 SP
- **Team Capacity**: 90 SP
- **Utilization**: 98.9%

### Team Allocation
- Security Engineer: 4 user stories (52 SP)
- React Native Dev 1: 3 user stories (29 SP)
- React Native Dev 2: 4 user stories (37 SP)
- UI/UX Designer: 1 user story (8 SP)

### Time Estimates
- Development: 120 jam (75%)
- Testing: 24 jam (15%)
- Documentation: 16 jam (10%)

---

## 🔗 Resources

### Internal Docs
- [README.md](./README.md) - Full documentation
- [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Implementation guide
- [diagrams/](./diagrams/) - Architecture diagrams

### External Resources
- OWASP Mobile Security: https://owasp.org/www-project-mobile-security/
- Expo Security APIs: https://docs.expo.dev/guides/security/
- React Native Security: https://reactnative.dev/docs/security

---

## 📞 Contact

### Internal Support
- **Security**: Security Engineer
- **Technical**: #technical Slack
- **Sprint**: Scrum Master

---

## 🎯 Definition of Done

Sprint 1 selesai ketika:

- ✅ 10 user stories completed
- ✅ All acceptance criteria met
- ✅ Code review approved
- ✅ Tests passing (> 80% coverage)
- ✅ Documentation complete
- ✅ Demo successful
- ✅ No critical bugs
- ✅ Ready for Sprint 2

---

**Status**: ✅ Ready  
**Version**: 1.0  
**Updated**: 2024

**Let's build secure wallet! 🔒**
