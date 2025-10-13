yes# Sphereon Mobile Wallet - Dokumentasi Lengkap Self-Sovereign Identity (SSI)

## 1. Executive Summary

**Sphereon Mobile Wallet** adalah aplikasi dompet digital open-source berbasis Self-Sovereign Identity (SSI) yang memberikan kontrol penuh kepada pengguna atas data dan identitas digital mereka. Aplikasi ini dibangun menggunakan teknologi React Native dengan Expo framework, mendukung platform iOS dan Android, serta mengimplementasikan standar W3C dan OpenID untuk Verifiable Credentials.

**Status Proyek:** Beta (Versi 0.5.3)  
**Lisensi:** Apache 2.0 (sebelumnya GPLv3)  
**Repository:** https://github.com/Sphereon-Opensource/mobile-wallet  
**Platform:** iOS & Android  

---

## 2. Visi dan Tujuan Aplikasi

### 2.1 Visi Utama
Menciptakan ekosistem identitas digital yang:
- **Privacy-First:** Data disimpan hanya di perangkat pengguna, tidak ada pihak ketiga yang memiliki akses
- **User-Controlled:** Pengguna memiliki kontrol penuh atas informasi yang dibagikan
- **Interoperable:** Mendukung standar internasional (W3C, OpenID, DIF)
- **Decentralized:** Tidak bergantung pada otoritas terpusat
- **Open Source:** Transparan dan dapat diaudit oleh komunitas

### 2.2 Tujuan Fungsional
1. **Credential Management:** Menerima, menyimpan, dan mengelola Verifiable Credentials dari berbagai issuer
2. **Selective Disclosure:** Memungkinkan pengguna berbagi informasi tertentu saja (tidak semua data)
3. **Multi-Identity Support:** Mendukung multiple profiles dan identitas digital
4. **Cross-Platform Compatibility:** Berfungsi di iOS dan Android dengan pengalaman yang konsisten
5. **Standards Compliance:** Implementasi penuh standar W3C DID, VC, dan protokol OpenID

---

## 3. Arsitektur Sistem

### 3.1 Arsitektur Level Tinggi (C4 - Context Diagram)

```
┌─────────────────────────────────────────────────────────────┐
│                      SSI ECOSYSTEM                           │
│                                                              │
│  ┌──────────┐         ┌──────────────┐        ┌──────────┐ │
│  │          │         │              │        │          │ │
│  │  Issuer  │────────▶│   Sphereon   │◀───────│ Verifier │ │
│  │ (Pemberi │         │    Mobile    │        │ (Pemeriksa│ │
│  │   ID)    │         │    Wallet    │        │    ID)   │ │
│  │          │         │   (Holder)   │        │          │ │
│  └──────────┘         └──────────────┘        └──────────┘ │
│       │                      │                      │       │
│       │                      │                      │       │
│       └──────────────────────┴──────────────────────┘       │
│                                                              │
│  Protocols: OID4VCI, OID4VP, SIOPv2, DIDComm v2             │
└─────────────────────────────────────────────────────────────┘
```

**Aktor Utama:**
- **Holder (Wallet User):** Pemilik dan pengendali data identitas
- **Issuer:** Entitas yang menerbitkan Verifiable Credentials (contoh: universitas, pemerintah, perusahaan)
- **Verifier:** Pihak yang memverifikasi kredensial (contoh: employer, bank, layanan online)

### 3.2 Arsitektur Aplikasi (C4 - Container Diagram)

```
┌───────────────────────────────────────────────────────────────┐
│                   SPHEREON MOBILE WALLET                       │
│                                                                │
│  ┌────────────────────────────────────────────────────────┐  │
│  │              UI LAYER (React Native)                    │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐             │  │
│  │  │ Onboarding│  │Credential│  │  QR      │             │  │
│  │  │  Screens  │  │  Views   │  │ Scanner  │             │  │
│  │  └──────────┘  └──────────┘  └──────────┘             │  │
│  └────────────────────────────────────────────────────────┘  │
│                           ↕                                   │
│  ┌────────────────────────────────────────────────────────┐  │
│  │           STATE MANAGEMENT (Redux)                      │  │
│  │  • Credential Store  • User Profile  • App Settings    │  │
│  └────────────────────────────────────────────────────────┘  │
│                           ↕                                   │
│  ┌────────────────────────────────────────────────────────┐  │
│  │         BUSINESS LOGIC LAYER (SSI-SDK)                  │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐             │  │
│  │  │   DID    │  │    VC    │  │   Key    │             │  │
│  │  │ Manager  │  │ Handler  │  │ Manager  │             │  │
│  │  └──────────┘  └──────────┘  └──────────┘             │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐             │  │
│  │  │ OID4VCI  │  │ OID4VP   │  │ SIOPv2   │             │  │
│  │  │  Client  │  │  Client  │  │  Client  │             │  │
│  │  └──────────┘  └──────────┘  └──────────┘             │  │
│  └────────────────────────────────────────────────────────┘  │
│                           ↕                                   │
│  ┌────────────────────────────────────────────────────────┐  │
│  │          DATA PERSISTENCE LAYER                         │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐             │  │
│  │  │ TypeORM  │  │ SQLite   │  │ Secure   │             │  │
│  │  │ Database │  │ Database │  │ Storage  │             │  │
│  │  └──────────┘  └──────────┘  └──────────┘             │  │
│  └────────────────────────────────────────────────────────┘  │
│                           ↕                                   │
│  ┌────────────────────────────────────────────────────────┐  │
│  │          SECURITY LAYER                                 │  │
│  │  • Biometric Auth  • PIN Protection  • Encrypted Keys  │  │
│  │  • Mnemonic Seed   • Key Derivation (BIP32/39/44)     │  │
│  └────────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────────┘
```

### 3.3 Technology Stack Detail

#### Frontend Layer
- **Framework:** React Native (Expo 50+)
- **Language:** TypeScript
- **State Management:** Redux / Context API
- **Navigation:** React Navigation
- **UI Components:** Custom components + React Native Paper
- **Styling:** StyleSheet API
- **Build System:** EAS (Expo Application Services)

#### Business Logic Layer
- **SSI-SDK:** Core SDK dari Sphereon untuk SSI functionality
  - `@sphereon/ssi-sdk-core`
  - `@sphereon/did-auth-siop`
  - `@sphereon/OID4VCI-client`
  - `@sphereon/pex` (Presentation Exchange)
  - `@sphereon/ssi-sdk-crypto-extensions`

#### Data Persistence
- **ORM:** TypeORM
- **Database:** SQLite (on-device)
- **Secure Storage:** React Native Keychain / Expo SecureStore
- **Encryption:** AES-256 for sensitive data

#### Cryptography & Key Management
- **Mnemonic Generation:** BIP39 (12/24-word seeds)
- **Key Derivation:** BIP32, BIP44 hierarchical deterministic keys
- **Signature Algorithms:** 
  - Ed25519 (EdDSA)
  - Secp256k1 (ES256K)
  - Secp256r1 (ES256)
- **Hashing:** SHA-256, SHA-512

---

## 4. Komponen Arsitektur Detail

### 4.1 DID (Decentralized Identifier) Management

**Supported DID Methods:**
- `did:ion` - Microsoft ION (Bitcoin anchored)
- `did:key` - Cryptographic key-based DIDs
- `did:jwk` - JSON Web Key DIDs
- `did:web` - Web-based DIDs
- `did:ethr` - Ethereum-based DIDs
- `did:cheqd` - Cheqd network DIDs
- `did:ebsi` - European Blockchain Services Infrastructure (upcoming)

**DID Resolution:**
```typescript
// Contoh proses resolusi DID
DIDResolver.resolve('did:ion:EiD...xyz')
  → DID Document {
      @context: [...],
      id: 'did:ion:EiD...xyz',
      verificationMethod: [...],
      authentication: [...],
      assertionMethod: [...]
    }
```

### 4.2 Verifiable Credentials Processing

**Format yang Didukung:**
1. **JWT-VC (JSON Web Token Verifiable Credentials)**
   ```json
   {
     "header": { "alg": "ES256K", "kid": "did:key:..." },
     "payload": {
       "iss": "did:ion:issuer",
       "sub": "did:key:holder",
       "vc": {
         "@context": ["https://www.w3.org/2018/credentials/v1"],
         "type": ["VerifiableCredential", "UniversityDegreeCredential"],
         "credentialSubject": { ... }
       }
     },
     "signature": "..."
   }
   ```

2. **JSON-LD VC (Linked Data Proofs)**
   ```json
   {
     "@context": ["https://www.w3.org/2018/credentials/v1"],
     "type": ["VerifiableCredential"],
     "issuer": "did:web:university.edu",
     "issuanceDate": "2023-01-01T00:00:00Z",
     "credentialSubject": { ... },
     "proof": {
       "type": "Ed25519Signature2020",
       "created": "2023-01-01T00:00:00Z",
       "verificationMethod": "did:web:university.edu#key-1",
       "proofPurpose": "assertionMethod",
       "proofValue": "z..."
     }
   }
   ```

3. **SD-JWT (Selective Disclosure JWT)**
   - Mendukung selective disclosure untuk privacy
   - Pengguna dapat memilih claim mana yang dibagikan

### 4.3 Protokol Issuance (OID4VCI)

**OpenID for Verifiable Credential Issuance Flow:**

```
┌──────────┐                    ┌──────────┐                ┌──────────┐
│  Issuer  │                    │  Wallet  │                │   User   │
└────┬─────┘                    └────┬─────┘                └────┬─────┘
     │                               │                           │
     │  1. Generate Credential Offer │                           │
     │─────────────────────────────▶│                           │
     │   (QR Code / Deep Link)       │                           │
     │                               │                           │
     │                               │  2. Scan / Open Link      │
     │                               │◀──────────────────────────│
     │                               │                           │
     │  3. Resolve Credential Offer  │                           │
     │◀──────────────────────────────│                           │
     │                               │                           │
     │  4. Return Metadata           │                           │
     │─────────────────────────────▶│                           │
     │   (supported credentials,     │                           │
     │    issuer info, etc.)         │                           │
     │                               │                           │
     │                               │  5. User Reviews & Accepts│
     │                               │◀──────────────────────────│
     │                               │                           │
     │  6. Authorization Request     │                           │
     │   (if required)               │                           │
     │◀──────────────────────────────│                           │
     │                               │                           │
     │  7. Access Token              │                           │
     │─────────────────────────────▶│                           │
     │                               │                           │
     │  8. Credential Request        │                           │
     │   + Proof of Possession       │                           │
     │◀──────────────────────────────│                           │
     │                               │                           │
     │  9. Issue Credential          │                           │
     │─────────────────────────────▶│                           │
     │                               │                           │
     │                               │ 10. Store Credential      │
     │                               │──────────────────────────▶│
     │                               │     (in wallet)           │
```

**Key Steps:**
1. **Credential Offer:** Issuer generates QR atau deep link
2. **Metadata Discovery:** Wallet fetch issuer capabilities
3. **Authorization:** Optional OAuth2/OIDC flow
4. **Proof of Possession:** Wallet proves control of DID
5. **Issuance:** Credential diterbitkan dan disimpan secara terenkripsi

### 4.4 Protokol Presentation (OID4VP)

**OpenID for Verifiable Presentations Flow:**

```
┌──────────┐                    ┌──────────┐                ┌──────────┐
│ Verifier │                    │  Wallet  │                │   User   │
└────┬─────┘                    └────┬─────┘                └────┬─────┘
     │                               │                           │
     │  1. Generate Presentation Req │                           │
     │─────────────────────────────▶│                           │
     │   (QR Code / Deep Link)       │                           │
     │   + Presentation Definition   │                           │
     │                               │                           │
     │                               │  2. Scan / Open Link      │
     │                               │◀──────────────────────────│
     │                               │                           │
     │                               │  3. Parse Requirements    │
     │                               │  (Presentation Exchange)  │
     │                               │                           │
     │                               │  4. Match Credentials     │
     │                               │  (find suitable VCs)      │
     │                               │                           │
     │                               │  5. User Consent          │
     │                               │◀──────────────────────────│
     │                               │  (select what to share)   │
     │                               │                           │
     │  6. Verifiable Presentation   │                           │
     │◀──────────────────────────────│                           │
     │   + Proof of Control (DID)    │                           │
     │                               │                           │
     │  7. Verify Presentation       │                           │
     │   - Signature verification    │                           │
     │   - DID resolution            │                           │
     │   - Credential validation     │                           │
     │                               │                           │
     │  8. Return Result             │                           │
     │─────────────────────────────▶│                           │
     │   (success / failure)         │                           │
     │                               │                           │
     │                               │  9. Show Confirmation     │
     │                               │──────────────────────────▶│
```

**Presentation Exchange:**
- Verifier mengirim **Presentation Definition** (apa yang dibutuhkan)
- Wallet melakukan **Credential Selection** (matching algoritma)
- User melakukan **Consent & Selective Disclosure**
- Wallet membuat **Verifiable Presentation** dengan proof

### 4.5 Security Architecture

#### Key Management
```
Mnemonic Seed (BIP39)
       │
       ├─▶ Master Key (BIP32)
       │         │
       │         ├─▶ Identity Key 1 (m/44'/0'/0')
       │         │         └─▶ DID:key:abc...
       │         │
       │         ├─▶ Identity Key 2 (m/44'/0'/1')
       │         │         └─▶ DID:ion:def...
       │         │
       │         └─▶ Credential Keys (per-credential)
       │
       └─▶ Backup & Recovery (encrypted, optional cloud)
```

**Security Measures:**
1. **Device-Level:**
   - PIN/Biometric authentication
   - Secure Enclave (iOS) / Keystore (Android)
   - No cloud sync by default

2. **Cryptographic:**
   - End-to-end encryption
   - Zero-knowledge proofs (untuk selective disclosure)
   - Key rotation capabilities

3. **Application-Level:**
   - Certificate pinning untuk network calls
   - Code obfuscation
   - Anti-tampering mechanisms
   - Secure random number generation

4. **Data Storage:**
   - SQLCipher untuk database encryption
   - Sensitive data never in plain text
   - Automatic key expiration

---

## 5. Fitur dan Capability Detail

### 5.1 Onboarding Process
1. **Welcome Flow:** Introduction to SSI concepts
2. **Terms & Conditions:** Privacy policy & user agreement
3. **Personal Information:** Local profile creation (tidak di-share)
4. **PIN Setup:** 6-digit PIN dengan verification
5. **Biometric Setup:** Optional Face ID / Touch ID / Fingerprint
6. **Seed Generation:** Automatic mnemonic creation
7. **Backup Options:** Manual backup atau cloud (encrypted)

### 5.2 Credential Management
- **Add Credentials:** Via QR, deep link, NFC (upcoming)
- **View Credentials:** Card view + detail view
- **Organize:** Categories, tags, favorites
- **Search & Filter:** Full-text search
- **Expiry Management:** Notifications untuk expired credentials
- **Revocation Check:** Automatic status check
- **Backup & Restore:** Export/import credentials

### 5.3 Presentation Features
- **QR Scanning:** Camera-based scanning untuk presentation requests
- **Selective Disclosure:** Pilih data mana yang di-share
- **Consent Management:** Explicit user approval
- **History & Audit:** Log semua presentation activities
- **Offline Verification:** Support untuk offline scenarios

### 5.4 Identity Management
- **Multiple Profiles:** Personal, professional, dll
- **Multiple DIDs:** Per profile atau per use-case
- **DID Methods:** Support berbagai DID methods
- **DID Document Management:** Update services, keys, dll

### 5.5 Localization
Mendukung bahasa:
- English
- Dutch
- German
- Swedish (v0.5.3)
- Finnish (v0.5.3)

---

## 6. Integrasi dan Interoperability

### 6.1 Platform Integrations
1. **Microsoft Entra Verified ID**
   - Enterprise credential issuance
   - Azure AD integration
   
2. **Sphereon VDX Platform**
   - Verifiable Data Exchange
   - Enterprise SSI solutions

3. **EBSI (European Blockchain Services Infrastructure)**
   - EU Digital Identity Wallet compliance (upcoming)
   - Cross-border credential exchange

### 6.2 Standard Compliance
- **W3C Standards:**
  - DID Core 1.0
  - Verifiable Credentials Data Model 1.1
  - DID Resolution

- **OpenID Standards:**
  - OIDC (OpenID Connect)
  - SIOPv2 (Self-Issued OpenID Provider v2)
  - OID4VCI (OpenID for Verifiable Credential Issuance)
  - OID4VP (OpenID for Verifiable Presentations)

- **DIF Standards:**
  - Presentation Exchange v2
  - DIDComm Messaging v2
  - Well-Known DID Configuration
  - Credential Manifest

- **Other Standards:**
  - JWT VC Presentation Profile
  - JSON-LD Signatures
  - BBS+ Signatures (untuk zero-knowledge proofs)
  - SD-JWT (Selective Disclosure JWT)

---

## 7. Use Cases dan Skenario Penggunaan

### 7.1 Education Sector
**Scenario:** Universitas menerbitkan ijazah digital
- Student menerima credential via OID4VCI
- Credential berisi degree, grades, graduation date
- Student share ke employer dengan selective disclosure (hanya nama dan degree, tanpa grades)
- Employer verify credential authenticity secara real-time

### 7.2 Healthcare
**Scenario:** Pasien menerima medical records
- Hospital issue vaccination certificate
- Patient store di wallet dengan encryption
- Patient share ke travel authority saat perjalanan
- Offline verification support untuk areas dengan koneksi terbatas

### 7.3 Government Services
**Scenario:** Digital citizen ID
- Government issue citizen credential
- Contains: name, address, birth date, photo
- Selective disclosure untuk age verification (e.g., untuk purchase alkohol, hanya share "over 18" tanpa reveal exact age)
- Single credential untuk multiple services

### 7.4 Financial Services
**Scenario:** KYC (Know Your Customer) digital
- Bank issue KYC credential setelah verification
- User reuse credential untuk open account di bank lain
- Reduce redundant KYC processes
- Privacy-preserving identity verification

### 7.5 Corporate Identity
**Scenario:** Employee badge digital
- Company issue employee credential
- Access control untuk building dan systems
- Business card replacement
- Integration dengan corporate systems

---

## 8. Development dan Testing

### 8.1 Development Setup
```bash
# Clone repository
git clone https://github.com/Sphereon-Opensource/mobile-wallet

# Install dependencies
yarn install

# Setup environment variables
cp .env.example .env

# Run on iOS
yarn ios

# Run on Android
yarn android

# Run tests
yarn test

# Build for production
eas build --platform ios
eas build --platform android
```

### 8.2 Testing Strategy
1. **Unit Tests:** Jest untuk business logic
2. **Integration Tests:** API dan SDK integration
3. **E2E Tests:** Detox untuk user flows
4. **Security Tests:** Penetration testing, code audit
5. **Interoperability Tests:** Cross-platform testing dengan various issuers/verifiers

### 8.3 CI/CD Pipeline
- **GitHub Actions:** Automated testing
- **EAS Build:** Cloud-based builds
- **CodePush:** Hot updates untuk non-native changes
- **Security Scanning:** Automated vulnerability detection

---

## 9. Deployment dan Distribution

### 9.1 App Stores
- **Apple App Store:** https://apps.apple.com/us/app/sphereon-wallet/id1661096796
- **Google Play Store:** https://play.google.com/store/apps/details?id=com.sphereon.ssi.wallet

### 9.2 Enterprise Distribution
- **MDM Support:** Mobile Device Management integration
- **Custom Branding:** White-label options
- **Private Deployment:** On-premise atau private cloud

---

## 10. Roadmap dan Future Development

### 10.1 Upcoming Features (marked with * in repo)
- [ ] **Credential Manifest Support:** Richer credential metadata
- [ ] **Enhanced Rendering:** Graphical card views dengan branding
- [ ] **VC API Integration:** RESTful API untuk issuance/verification
- [ ] **CHAPI Support:** Credential Handler API
- [ ] **DIDComm v2 Messaging:** Peer-to-peer secure messaging
- [ ] **WACI DIDComm:** Wallet and Credential Interactions
- [ ] **EBSI Integration:** Full EU Digital Identity Wallet compliance
- [ ] **Biometric Binding:** Bind credentials to biometric data
- [ ] **NFC Support:** Contactless credential exchange
- [ ] **Bluetooth LE:** Proximity-based verification

### 10.2 Research Areas
- **Zero-Knowledge Proofs:** Enhanced privacy dengan ZKP
- **Post-Quantum Cryptography:** Future-proof encryption
- **Decentralized Storage:** IPFS/Filecoin untuk credential backup
- **Cross-Chain DIDs:** Multi-blockchain support

---

## 11. Security Considerations dan Best Practices

### 11.1 Threat Model
1. **Device Compromise:** Malware, physical access
   - Mitigation: Secure Enclave, encryption at rest
   
2. **Network Attacks:** MITM, eavesdropping
   - Mitigation: TLS, certificate pinning, end-to-end encryption
   
3. **Phishing:** Fake issuers/verifiers
   - Mitigation: Domain verification, trusted issuer registry
   
4. **Credential Theft:** Export/backup compromise
   - Mitigation: Encrypted backups, password protection
   
5. **Side-Channel Attacks:** Timing attacks, power analysis
   - Mitigation: Constant-time cryptographic operations

### 11.2 Privacy Best Practices
- **Minimal Disclosure:** Share only necessary information
- **Unlinkability:** Prevent tracking across interactions
- **Pairwise DIDs:** Different DID per relationship
- **Zero-Knowledge Proofs:** Prove claims without revealing data
- **Revocation Privacy:** Privacy-preserving revocation checks

---

## 12. Community dan Kontribusi

### 12.1 Open Source Community
- **Contributors:** 20+ active contributors
- **Stars:** 85 GitHub stars
- **Forks:** 26 forks
- **License:** Apache 2.0 (permissive, commercial-friendly)

### 12.2 Contributing
```bash
# Fork repository
# Create feature branch
git checkout -b feature/amazing-feature

# Commit changes
git commit -m "Add amazing feature"

# Push and create PR
git push origin feature/amazing-feature
```

### 12.3 Code Standards
- **TypeScript:** Strict mode enabled
- **ESLint:** Code quality checks
- **Prettier:** Code formatting
- **Husky:** Pre-commit hooks
- **Conventional Commits:** Semantic versioning

---

## 13. Performance dan Scalability

### 13.1 Performance Metrics
- **App Size:** ~50MB (iOS/Android)
- **Startup Time:** <2 seconds
- **QR Scan:** <500ms
- **Credential Verification:** <1 second
- **Database Query:** <100ms for typical operations

### 13.2 Scalability
- **Credentials:** Support up to 1000+ credentials per wallet
- **DIDs:** Multiple DIDs per profile
- **Offline Support:** Full functionality without network
- **Low-End Devices:** Support untuk devices dengan limited resources

---

## 14. Compliance dan Regulations

### 14.1 GDPR Compliance
- **Data Minimization:** Only store necessary data
- **Right to Erasure:** Users can delete all data
- **Data Portability:** Export/import functionality
- **Consent Management:** Explicit consent untuk data sharing

### 14.2 eIDAS 2.0 (European Digital Identity)
- **EUDI Wallet Compliance:** Working towards full compliance
- **Cross-Border Recognition:** Support untuk EU-wide credentials
- **Security Requirements:** Meet Level of Assurance (LoA) requirements

### 14.3 Other Regulations
- **CCPA (California):** Privacy rights compliance
- **PIPEDA (Canada):** Personal information protection
- **POPIA (South Africa):** Data protection compliance

---

## 15. Technical Debt dan Known Issues

### 15.1 Current Limitations (Beta Status)
- **PIN Recovery:** No recovery mechanism (planned)
- **Backup Complexity:** Manual backup process
- **Limited Credential Types:** Not all credential formats fully tested
- **Performance:** Some operations could be optimized
- **UI/UX:** Ongoing improvements needed

### 15.2 Known Issues
- **Walt.id Integration:** ProofPurpose missing in some scenarios
- **TypeORM Debug Mode:** Issues in development environment
- **Checksum Issues:** Windows/Unix platform differences

---

## 16. Monitoring dan Analytics

### 16.1 Telemetry (Privacy-Preserving)
- **App Crashes:** Anonymous crash reporting
- **Performance Metrics:** App performance data
- **Usage Patterns:** Anonymous usage statistics
- **No PII:** No personally identifiable information collected

### 16.2 Error Handling
- **Graceful Degradation:** App continues functioning despite errors
- **User-Friendly Messages:** Clear error communication
- **Debug Logs:** Detailed logs untuk troubleshooting (development only)

---

## 17. Documentation dan Resources

### 17.1 Developer Documentation
- **GitHub README:** https://github.com/Sphereon-Opensource/mobile-wallet
- **SSI-SDK Docs:** https://github.com/Sphereon-Opensource/ssi-sdk
- **API Documentation:** Generated via TypeDoc
- **Architecture Decision Records (ADR):** Design decisions documented

### 17.2 User Documentation
- **In-App Help:** Contextual help screens
- **Video Tutorials:** Onboarding dan feature demos
- **FAQ:** Common questions dan troubleshooting

### 17.3 Community Resources
- **Discord:** Developer community
- **GitHub Discussions:** Feature requests dan Q&A
- **Blog:** Technical articles dan updates

---

## 18. Testing Issuers dan Verifiers

### 18.1 Demo Issuers (untuk Testing)
1. **Sphereon Demo:** https://ssi.sphereon.com/demo/issuer/
2. **Dutch Blockchain Coalition:** https://ssi.dutchblockchaincoalition.org/demo/issuer/
3. **Future Mobility Alliance:** https://ssi.future-mobility-alliance.org/demo/issuer/
4. **Diwala:** https://oidc4vc.diwala.io/issue
5. **Mattr:** https://launchpad.mattrlabs.com/

### 18.2 Interoperability Testing
- **JFF Plugfest:** Participated in W3C-EDU Plugfest 2
- **Cross-Vendor Testing:** Tested dengan multiple SSI vendors
- **Standards Compliance:** Validated against specification test suites

---

## 19. Ecosystem dan Partnerships

### 19.1 Technology Partners
- **Microsoft:** Entra Verified ID integration
- **Mattr:** Credential issuance platform
- **Walt.id:** SSI infrastructure provider
- **Diwala:** Education credentials platform

### 19.2 Standards Bodies
- **W3C:** Verifiable Credentials Working Group
- **DIF (Decentralized Identity Foundation):** Multiple working groups
- **OpenID Foundation:** OpenID4VC working group
- **EBSI:** European Blockchain Services Infrastructure

---

## 20. Conclusion

Sphereon Mobile Wallet adalah implementasi production-ready dari Self-Sovereign Identity wallet yang:

**Strengths:**
- ✅ Open-source dengan Apache 2.0 license
- ✅ Standards-compliant (W3C, OpenID, DIF)
- ✅ Cross-platform (iOS & Android)
- ✅ Privacy-preserving by design
- ✅ Active development dan community
- ✅ Enterprise-ready dengan integrations

**Ideal For:**
- 🎓 Educational institutions
- 🏥 Healthcare providers
- 🏛️ Government services
- 🏢 Corporate identity management
- 💳 Financial services KYC
- 🌐 Any organization needing verifiable digital credentials

**Next Steps:**
1. Download dari App Store / Play Store
2. Complete onboarding process
3. Test dengan demo issuers
4. Integrate dengan existing systems
5. Contribute ke open-source development

---

## Appendix A: Glossary

- **SSI:** Self-Sovereign Identity - model identitas digital dimana user memiliki kontrol penuh
- **DID:** Decentralized Identifier - identifier yang terdesentralisasi dan cryptographically verifiable
- **VC:** Verifiable Credential - credential digital yang cryptographically secure
- **VP:** Verifiable Presentation - bundel VC yang di-share dengan verifier
- **Holder:** Pemilik wallet dan credentials
- **Issuer:** Entity yang menerbitkan credentials
- **Verifier:** Entity yang memverifikasi credentials
- **OID4VCI:** OpenID for Verifiable Credential Issuance
- **OID4VP:** OpenID for Verifiable Presentations
- **SIOPv2:** Self-Issued OpenID Provider version 2
- **PEx:** Presentation Exchange - format untuk credential requests
- **BIP:** Bitcoin Improvement Proposal (digunakan untuk key derivation)

---

## Appendix B: References

### Standards
1. W3C DID Core: https://www.w3.org/TR/did-core/
2. W3C Verifiable Credentials: https://www.w3.org/TR/vc-data-model/
3. OpenID4VCI: https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html
4. OpenID4VP: https://openid.net/specs/openid-4-verifiable-presentations-1_0.html
5. SIOPv2: https://openid.net/specs/openid-connect-self-issued-v2-1_0.html
6. Presentation Exchange: https://identity.foundation/presentation-exchange/

### Repositories
1. Mobile Wallet: https://github.com/Sphereon-Opensource/mobile-wallet
2. SSI-SDK: https://github.com/Sphereon-Opensource/ssi-sdk
3. Crypto Extensions: https://github.com/Sphereon-Opensource/SSI-SDK-crypto-extensions

### Organizations
1. Sphereon: https://sphereon.com/
2. W3C: https://www.w3.org/
3. DIF: https://identity.foundation/
4. OpenID Foundation: https://openid.net/

---

**Dokumen ini dibuat pada:** Oktober 2024  
**Version:** 1.0  
**Author:** Sphereon Development Team  
**Last Updated:** Based on mobile-wallet v0.5.3  
**Status:** Living Document (akan diupdate seiring development)
