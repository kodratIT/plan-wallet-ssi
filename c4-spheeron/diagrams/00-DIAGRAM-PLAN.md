# Sphereon Mobile Wallet - Comprehensive Diagram Plan
## Sebagai Pembuat Wallet: Penjelasan Sistem yang Sangat Detail

> **Tujuan**: Menjelaskan SETIAP aspek dari Sphereon Mobile Wallet sehingga pembaca **benar-benar memahami seluruh bagian sistem** - dari arsitektur tingkat tinggi hingga detail implementasi setiap komponen.

---

## 🎯 Filosofi Diagram Plan

Sebagai **pembuat wallet ini**, saya ingin memastikan bahwa:

1. **Setiap Layer** dijelaskan secara mendalam
2. **Setiap Component** memiliki diagram tersendiri jika kompleks
3. **Setiap Flow** dipetakan step-by-step
4. **Setiap Integration Point** jelas hubungannya
5. **Pembaca memahami WHY** setiap komponen ada dan BAGAIMANA mereka bekerja bersama

---

## 📊 Diagram Structure: 3 Kategori Utama

### KATEGORI A: Architecture Diagrams (Struktur Statis)
Menjelaskan BAGAIMANA sistem dibangun

### KATEGORI B: Component Deep-Dive Diagrams (Detail Internal)
Menjelaskan SETIAP komponen secara mendalam

### KATEGORI C: Dynamic Flow Diagrams (Interaksi Runtime)
Menjelaskan BAGAIMANA sistem berjalan saat digunakan

---

# KATEGORI A: ARCHITECTURE DIAGRAMS (Level 1-3 C4)

## A1. System Context Diagram
**File**: `01-system-context.puml`  
**C4 Level**: 1 - Context  
**Tujuan**: Menunjukkan Sphereon Wallet dalam ekosistem SSI secara keseluruhan

**Yang Ditampilkan**:
- **Actors**:
  - Credential Holder (user utama)
  - Credential Issuer (universitas, pemerintah, perusahaan)
  - Credential Verifier (employer, service provider)
  - Enterprise Administrator (untuk organizational wallet)
  
- **Core System**:
  - Sphereon Mobile Wallet (sistem yang kita buat)
  
- **External Systems** (11+ systems):
  - Issuer Systems (OID4VCI endpoints)
  - Verifier Systems (OID4VP endpoints)
  - DIDComm Mediator Service
  - Blockchain Ledgers (Sovrin, ION, EBSI, Cheqd)
  - Universal DID Resolver
  - Microsoft Entra Verified ID
  - Sphereon VDX Platform
  - EBSI Network
  - OCA Repository (credential branding)
  - Push Notification Services (FCM, APNs)
  - Cloud Backup Services (iCloud, Google Drive)
  - App Distribution (Play Store, App Store)

**Relationships**: Semua protokol dan interaksi dijelaskan (OID4VCI, OID4VP, DIDComm v2, HTTPS, dll)

---

## A2. Container Diagram (High-Level Architecture)
**File**: `02-container-diagram.puml`  
**C4 Level**: 2 - Container  
**Tujuan**: Menunjukkan major building blocks dalam wallet

**Containers Yang Ditampilkan** (12+ containers):
1. **Mobile Application** (React Native + Expo)
2. **SSI SDK Core** (@sphereon/ssi-sdk)
3. **DID Management Module**
4. **Credential Handler Module**
5. **Presentation Handler Module**
6. **OID4VCI Client**
7. **OID4VP Client**
8. **SIOPv2 Client**
9. **DIDComm v2 Engine**
10. **Presentation Exchange Engine**
11. **Key Management System**
12. **Data Persistence Layer** (TypeORM + SQLite)
13. **Secure Storage** (Keychain/Keystore)

**Interaksi**: Bagaimana containers berkomunikasi satu sama lain

---

## A3. Deployment Architecture Diagram
**File**: `03-deployment-architecture.puml`  
**C4 Level**: Deployment  
**Tujuan**: Menunjukkan bagaimana sistem di-deploy di production

**Deployment Nodes**:
- **Mobile Devices**:
  - Android Devices (SDK 26+)
  - iOS Devices (iOS 14+)
  
- **Cloud Infrastructure**:
  - DIDComm Mediator (Kubernetes cluster)
    - Load Balancer
    - Mediator Service Pods
    - Message Queue (Redis)
    - Database (PostgreSQL)
  
- **Blockchain Infrastructure**:
  - Sovrin Validator Nodes
  - ION Bitcoin Nodes
  - EBSI Nodes
  
- **Enterprise Services**:
  - Microsoft Azure (Entra VID)
  - Sphereon VDX Platform (AWS)
  
- **Supporting Infrastructure**:
  - Firebase Cloud Messaging
  - Apple Push Notification Service
  - Universal Resolver Service
  - OCA Repository Server

**Network Topology**: Zones, firewalls, load balancers, dll

---

# KATEGORI B: COMPONENT DEEP-DIVE DIAGRAMS

> **Ini adalah bagian PALING PENTING** - menjelaskan SETIAP komponen secara mendalam

---

## B1. Frontend/UI Layer - Complete Breakdown
**File**: `04-component-ui-layer.puml`  
**C4 Level**: 3 - Component  
**Tujuan**: Menjelaskan SELURUH komponen UI dan bagaimana mereka terorganisir

### B1.1 Screen Components (Detail Lengkap)

**Onboarding Screens**:
- WelcomeScreen (introduction slides)
- TermsAndConditionsScreen
- PINCreationScreen
- PINConfirmationScreen
- BiometricSetupScreen
- BackupOptionsScreen
- OnboardingCompleteScreen

**Main App Screens**:
- HomeScreen (Dashboard)
  - CredentialSummaryCard
  - QuickActionsMenu
  - RecentActivityList
  - NotificationBadge
  
- CredentialsScreen
  - CredentialListView (dengan filtering)
  - CredentialCard (dengan OCA rendering)
  - CredentialDetailScreen
  - CredentialOfferScreen
  - CredentialAcceptanceFlow
  
- ConnectionsScreen
  - ConnectionListView
  - ConnectionCard
  - ConnectionDetailScreen
  - QRScannerScreen (untuk invitations)
  
- ProofsScreen
  - ProofRequestScreen
  - CredentialSelectionScreen
  - AttributeSelectionScreen (selective disclosure)
  - ProofPreviewScreen
  - ProofHistoryScreen
  
- SettingsScreen
  - GeneralSettings
  - SecuritySettings
  - BackupSettings
  - LanguageSettings
  - ThemeSettings
  - DeveloperSettings

### B1.2 UI Component Library

**Design System Components**:
- Buttons (Primary, Secondary, Outline, Icon, FAB)
- Cards (Standard, Elevated, Outlined, Credential Card)
- Inputs (Text, PIN, Biometric, QR)
- Modals (Alert, Confirm, Bottom Sheet)
- Lists (Simple, Card, Grouped)
- Navigation (Tab Bar, Header, Drawer)
- Feedback (Toast, Snackbar, Loading, Error States)

**Theming**:
- ThemeProvider (Light/Dark mode)
- ColorScheme
- Typography System
- Spacing System
- Elevation System

**Localization**:
- i18n Provider
- Language Files (EN, NL, DE, SV, FI)
- Translation Hooks

### B1.3 Navigation System

**Navigation Structure**:
- AppNavigator (Root)
  - AuthNavigator (PIN/Biometric gate)
  - MainNavigator (Tab-based)
    - HomeStack
    - CredentialsStack
    - ConnectionsStack
    - ProofsStack
    - SettingsStack
  - ModalNavigator (Overlays)

**Deep Linking**:
- Custom URL Scheme Handler (sphereon://)
- Universal Links Handler
- QR Code Navigation

### B1.4 State Management

**Redux Store Structure**:
```
- app/
  - initialized
  - loading
  - error
- credentials/
  - byId
  - allIds
  - filters
  - selectedId
- connections/
  - byId
  - allIds
  - activeConnectionId
- proofs/
  - requests
  - history
- settings/
  - theme
  - language
  - security
- notifications/
  - unread
  - list
```

**React Context**:
- ThemeContext
- AuthContext
- LocalizationContext

### B1.5 Custom Hooks

Setiap hook dijelaskan dengan input/output dan dependencies:
- useCredentials() - CRUD credentials
- useConnections() - Manage connections
- useProofs() - Handle proof requests
- useDID() - DID operations
- useAuth() - Authentication state
- useQRScanner() - QR scanning
- useNotifications() - Notifications
- useBackup() - Backup/restore
- useTheme() - Theme switching
- useLocalization() - Language switching

**SEMUA ini dalam SATU diagram yang sangat detail**

---

## B2. SSI SDK Core - Deep Dive (Split menjadi Sub-Diagrams)

### B2.1. DID Management Subsystem
**File**: `05-component-did-management.puml`  
**Tujuan**: Menjelaskan SEMUA aspek DID management

**Components Detail**:

**DID Manager**:
- createDID(method, options)
- importDID(did, privateKey)
- exportDID(did)
- deleteDID(did)
- listDIDs()
- setDefaultDID(did)

**DID Resolver** (Multi-Method):
- UniversalResolver (fallback)
- Resolver Cache (performance)
- Resolution Options
  
**DID Method Providers** (Masing-masing dijelaskan):

1. **did:key Provider**:
   - Key types: Ed25519, Secp256k1, X25519
   - Resolution logic (from public key)
   - No registration needed
   - Use case: Ephemeral connections

2. **did:jwk Provider**:
   - JWK format support
   - Public key embedding
   - Use case: Simple key-based DIDs

3. **did:web Provider**:
   - Domain verification
   - .well-known/did.json
   - HTTPS requirement
   - Use case: Corporate identities

4. **did:ion Provider**:
   - Bitcoin anchoring
   - IPFS content addressing
   - Sidetree operations
   - Resolution via ION nodes
   - Use case: Long-lived DIDs

5. **did:ethr Provider**:
   - Ethereum registry
   - Smart contract interaction
   - Gas considerations
   - Use case: Blockchain-native apps

6. **did:ebsi Provider**:
   - EBSI ledger
   - EUDI Wallet compliance
   - Trusted issuer registry
   - Use case: EU credentials

**DID Registrar**:
- Registration logic per method
- Transaction signing
- Ledger writing
- Status tracking

**DID Document Manager**:
- Verification methods
- Service endpoints
- Key purposes (authentication, assertion, keyAgreement)
- Document updates

**All relationships and data flows explained**

---

### B2.2. Credential Management Subsystem
**File**: `06-component-credential-management.puml`  
**Tujuan**: Menjelaskan SELURUH credential lifecycle

**Components Detail**:

**VC Handler (Orchestrator)**:
- Credential offer handling
- Credential request generation
- Credential reception
- Credential verification
- Credential revocation check

**VC Issuer Module** (untuk self-issued credentials):
- Credential creation
- Signing with DID keys
- Schema validation
- Credential encoding (JWT/JSON-LD/SD-JWT)

**VC Holder Module**:
- Credential storage
- Credential organization (tags, categories)
- Credential search/filter
- Credential export/import
- Credential deletion

**VC Verifier Module**:
- Signature verification
- Issuer DID resolution
- Schema validation
- Revocation checking
- Expiry validation
- Trust framework evaluation

**Format Support Modules**:

1. **JWT-VC Handler**:
   - JWS signing (ES256K, EdDSA)
   - Header structure
   - Payload validation
   - Signature verification

2. **JSON-LD VC Handler**:
   - Linked Data Proofs
   - Context resolution
   - Ed25519Signature2020
   - BbsBlsSignature2020
   - Canonicalization (URDNA2015)

3. **SD-JWT Handler**:
   - Selective disclosure
   - Hash-based disclosure
   - Holder binding
   - Disclosure frame
   - Presentation creation

**Credential Schema Manager**:
- Schema retrieval (from ledger/cache)
- Schema validation (JSON Schema)
- Schema caching

**Credential Definition Manager**:
- Cred def retrieval
- Public key extraction
- Revocation registry info

**Revocation Manager**:
- Revocation registry query
- Status List 2021 support
- Revocation caching
- Background checking (WorkManager)

**All with detailed data flow**

---

### B2.3. Presentation Exchange Engine
**File**: `07-component-presentation-exchange.puml`  
**Tujuan**: Menjelaskan bagaimana PEx v2 bekerja

**Components**:

**Presentation Definition Parser**:
- Parse PEx v2 JSON
- Extract input descriptors
- Parse constraints
  - Field constraints
  - Format constraints
  - Predicate constraints (ZKP)
- Parse submission requirements

**Credential Matching Engine**:
- Query credential store
- Match by schema
- Match by issuer
- Match by attributes
- Match by format
- Score matching credentials
- Handle multiple credential options

**Constraint Evaluator**:
- Evaluate field constraints
- Evaluate format requirements
- Evaluate predicate proofs
- Handle logical operators (AND, OR, NOT)

**Presentation Builder**:
- Select credentials
- Apply selective disclosure
- Generate presentation submission
- Create descriptor map
- Sign presentation

**Submission Validator**:
- Validate against definition
- Check all constraints met
- Verify descriptor map

---

### B2.4. OpenID for Verifiable Credentials
**File**: `08-component-openid4vc.puml`  
**Tujuan**: Menjelaskan OID4VCI dan OID4VP implementation

**OID4VCI Client Components**:

**Discovery**:
- Issuer metadata endpoint (/.well-known/openid-credential-issuer)
- OAuth authorization server metadata
- Credential issuer metadata
- Supported credential types
- Supported grant types

**Authorization**:
- Pre-authorized code flow
- Authorization code flow (PKCE)
- Token endpoint
- Token response handling

**Credential Request**:
- Proof of possession (JWT)
  - Key binding
  - Nonce
  - Audience
- Credential request format
- Batch credential request
- Deferred credential flow

**Credential Response**:
- Credential parsing
- Format detection
- Credential storage
- Acceptance acknowledgment

**OID4VP Client Components**:

**Authorization Request**:
- Presentation definition in request
- Response mode (direct_post, redirect)
- Client metadata
- Nonce and state

**Presentation Response**:
- VP Token generation
- ID Token (if requested)
- State management

**SIOPv2 Components**:
- Self-issued OP endpoint
- DID authentication
- ID Token generation with DID proof

**All protocol flows mapped**

---

### B2.5. DIDComm v2 Messaging Engine
**File**: `09-component-didcomm-messaging.puml`  
**Tujuan**: Menjelaskan SEMUA aspek DIDComm v2

**Message Structure Components**:

**Message Builder**:
- Message ID generation
- Message type
- Thread management (thid, pthid)
- Message body
- Attachments
- Decorators (~timing, ~transport, etc.)

**Message Parser**:
- Parse plaintext message
- Extract message type
- Thread tracking
- Attachment handling

**Encryption Components**:

**Authcrypt** (Authenticated Encryption):
- Sender authentication + encryption
- Recipient key agreement (X25519)
- JWE creation (ECDH-ES+A256KW)
- Multi-recipient support
- Forward secrecy

**Anoncrypt** (Anonymous Encryption):
- No sender authentication
- Recipient encryption only
- Use case: Initial contact

**Signing**:
- JWS signing
- Non-repudiation

**DID Resolution for Messaging**:
- Resolve recipient DID
- Extract keyAgreement keys
- Extract service endpoints
- Cache DID documents

**Message Routing**:

**Mediator Protocol**:
- Coordinate Mediation (RFC 0211)
- Routing key registration
- Message pickup (RFC 0212)
- Batch pickup
- Live delivery mode
- Status messages

**Forwarding**:
- Forward message wrapping
- Multi-hop routing
- Route management

**Transport Layer**:

**HTTP Transport**:
- POST to service endpoint
- Response handling
- Timeout management

**WebSocket Transport**:
- Connection management
- Heartbeat/ping
- Message delivery
- Reconnection logic

**Message Queue**:
- Outbound message queue
- Retry logic with backoff
- Failed message handling
- Message persistence

**Message Dispatcher**:
- Route to protocol handlers
- Handler registration
- Unknown message handling
- Error responses

---

### B2.6. Cryptography & Key Management
**File**: `10-component-key-management.puml`  
**Tujuan**: Menjelaskan SEMUA crypto operations

**Key Manager Components**:

**Key Generation**:
- Algorithm selection (Ed25519, Secp256k1, Secp256r1, X25519)
- Key derivation (BIP32/39/44)
- Mnemonic generation
- Master key creation
- Child key derivation

**Key Storage**:
- Secure enclave (iOS)
- Android Keystore
- Key wrapping
- Encrypted storage

**Key Operations**:
- Signing
  - Ed25519 (EdDSA)
  - Secp256k1 (ES256K) - Bitcoin/Ethereum
  - Secp256r1 (ES256) - NIST P-256
- Verification
- Key agreement (ECDH)
  - X25519
- Encryption/Decryption
  - AES-256-GCM
  - ChaCha20-Poly1305

**Key Management System (KMS)**:
- Local KMS (default)
- AWS KMS (enterprise)
- Azure Key Vault (enterprise)
- Google Cloud KMS (enterprise)
- Hardware Security Module (HSM)

**Mnemonic Manager** (BIP39):
- Wordlist (English, etc.)
- Checksum validation
- Seed generation (512-bit)
- Seed storage (encrypted)

**HD Wallet** (BIP32/BIP44):
- Master key derivation
- Purpose (44' = BIP44)
- Coin type (0' = Bitcoin, 60' = Ethereum)
- Account, Change, Index
- Path: m/44'/0'/0'/0/0

**Crypto Providers**:

1. **Ed25519 Provider**:
   - EdDSA signing
   - Use case: DID keys, credential signing

2. **Secp256k1 Provider**:
   - ES256K signing
   - Bitcoin/Ethereum compatibility
   - Use case: Blockchain DIDs

3. **Secp256r1 Provider**:
   - ES256 signing
   - NIST standard
   - Use case: Enterprise PKI

4. **X25519 Provider**:
   - ECDH key agreement
   - Use case: DIDComm encryption

**All crypto flows explained dengan security boundaries**

---

### B2.7. Data Persistence Layer
**File**: `11-component-data-persistence.puml`  
**Tujuan**: Menjelaskan SEMUA data storage

**TypeORM Database**:

**Entities** (each explained in detail):

1. **CredentialEntity**:
   ```typescript
   - id: string (PK)
   - type: string
   - issuer: string
   - issuerName: string
   - issuerImageUrl: string
   - issuanceDate: timestamp
   - expirationDate: timestamp
   - credentialJson: text (encrypted)
   - attributesJson: text
   - schemaId: string
   - credDefId: string
   - revRegId: string
   - revocationStatus: enum
   - isFavorite: boolean
   - tags: json
   - metadata: json
   - createdAt: timestamp
   - updatedAt: timestamp
   ```

2. **ConnectionEntity**:
   ```typescript
   - id: string (PK)
   - theirLabel: string
   - theirDid: string
   - theirDidDoc: json
   - myDid: string
   - myDidDoc: json
   - state: enum (invited, requested, responded, completed)
   - invitationJson: text
   - theirImageUrl: string
   - createdAt: timestamp
   - updatedAt: timestamp
   ```

3. **DIDEntity**:
   ```typescript
   - did: string (PK)
   - didDocument: json
   - keys: json (encrypted)
   - method: string
   - alias: string
   - isDefault: boolean
   - createdAt: timestamp
   ```

4. **MessageEntity**:
   ```typescript
   - id: string (PK)
   - messageType: string
   - threadId: string
   - parentThreadId: string
   - from: string
   - to: string[]
   - messageJson: text
   - direction: enum (inbound, outbound)
   - status: enum (pending, sent, delivered, failed)
   - createdAt: timestamp
   ```

5. **ProofRequestEntity**:
   ```typescript
   - id: string (PK)
   - requestJson: json
   - presentationJson: json
   - verifier: string
   - status: enum
   - createdAt: timestamp
   ```

**DAOs (Data Access Objects)**:
- CredentialDao
- ConnectionDao
- DIDDao
- MessageDao
- ProofRequestDao

**Repositories**:
- CredentialRepository (business logic)
- ConnectionRepository
- DIDRepository
- MessageRepository
- ProofRequestRepository

**Database Migrations**:
- Version management
- Schema evolution
- Data migration scripts

**Caching Layer**:
- In-memory cache (LRU)
- DID document cache
- Schema cache
- Recently accessed credentials

**All with query optimization strategies**

---

## B3. Security Layer - Complete Breakdown
**File**: `12-component-security-layer.puml`  
**Tujuan**: Menjelaskan SEMUA security mechanisms

**Authentication Components**:

**PIN Management**:
- PIN creation with strength validation
- PIN hashing (Argon2id)
  - Memory: 64MB
  - Iterations: 3
  - Parallelism: 4
- PIN storage (hashed in Keystore)
- PIN verification
- Failed attempt tracking
- Progressive delays (exponential backoff)
- Max attempts (5)
- PIN recovery flow

**Biometric Management**:
- Biometric availability check
- Biometric enrollment
- Biometric authentication
  - Face ID (iOS)
  - Touch ID (iOS)
  - Fingerprint (Android)
  - Face Unlock (Android)
- Biometric key creation
- Biometric-bound encryption
- Fallback to PIN

**Session Management**:
- Session creation
- Session timeout (configurable: 30s, 1m, 5m, 15m, never)
- Auto-lock on background
- Lock on device lock
- Re-authentication requirement

**Encryption Components**:

**Data Encryption**:
- AES-256-GCM for data at rest
- Master key in Keystore
- Per-credential encryption keys
- Database encryption (SQLCipher)
- Keychain encryption (iOS)
- EncryptedSharedPreferences (Android)

**Communication Encryption**:
- TLS 1.3 for all HTTPS
- Certificate pinning
- DIDComm encryption (covered in B2.5)

**Key Storage**:

**iOS Keychain**:
- Keychain items
- Access control flags
- Keychain groups
- iCloud Keychain sync (optional)

**Android Keystore**:
- Hardware-backed keys
- StrongBox (if available)
- Key attestation
- Biometric-protected keys

**Secure Storage Wrapper**:
- Unified API for iOS/Android
- Automatic encryption
- Access logging (audit trail)

**Backup Security**:
- Backup encryption (AES-256)
- Password-based key derivation (PBKDF2)
- Cloud backup encryption
- Zero-knowledge backup option

**Network Security**:
- Certificate validation
- SSL pinning for critical endpoints
- Man-in-the-middle prevention
- Proxy detection

**Code Security**:
- Code obfuscation (ProGuard/R8, Hermes)
- Anti-tampering checks
- Root/Jailbreak detection
- Debug detection

**All security boundaries clearly marked**

---

## B4. Native Platform Integration
**File**: `13-component-native-integration.puml`  
**Tujuan**: Menjelaskan native module integration

**React Native Bridges**:

**QR Scanner Module**:
- Camera permission handling
- CameraX (Android) / AVFoundation (iOS)
- ML Kit barcode detection (Android) / Vision (iOS)
- QR code parsing
- Invitation URL extraction
- Error handling

**Biometric Module**:
- BiometricPrompt (Android) / LocalAuthentication (iOS)
- Availability check
- Authentication trigger
- Success/failure callbacks

**Secure Storage Module**:
- Keystore (Android) / Keychain (iOS)
- Store/retrieve operations
- Encryption wrapper
- Error handling

**Push Notification Module**:
- FCM (Android) / APNs (iOS)
- Token registration
- Notification reception
- Notification handling
- Deep link from notification

**Background Task Module**:
- WorkManager (Android) / BackgroundTasks (iOS)
- Periodic sync
- Credential revocation check
- Message pickup

**Deep Linking Module**:
- Custom URL scheme (sphereon://)
- Universal Links (iOS) / App Links (Android)
- Invitation parsing
- Navigation trigger

**File System Module**:
- Secure file storage
- Export/import operations
- Backup file management

**All with platform-specific implementations shown**

---

# KATEGORI C: DYNAMIC FLOW DIAGRAMS

> Menjelaskan BAGAIMANA sistem bekerja saat runtime - step by step

---

## C1. Credential Issuance Flows

### C1.1. OpenID4VCI Pre-Authorized Code Flow
**File**: `14-flow-oid4vci-pre-auth.puml`  
**Type**: Sequence Diagram  
**Tujuan**: Menjelaskan SETIAP step credential issuance via OID4VCI

**Actors**:
- User (Holder)
- Mobile Wallet
- Issuer System
- Issuer Authorization Server
- Issuer Credential Endpoint

**Detailed Steps** (20+ steps):
1. User scans QR code (credential offer)
2. Wallet parses credential offer URL
3. Wallet extracts pre-authorized code
4. Wallet displays issuer information
5. User reviews credential preview
6. User accepts offer
7. Wallet requests access token (pre-auth code + PIN)
8. Issuer AS validates pre-auth code
9. Issuer AS returns access token
10. Wallet generates proof of possession (DID key)
11. Wallet sends credential request (with PoP)
12. Issuer validates PoP
13. Issuer generates credential
14. Issuer signs credential
15. Issuer returns credential
16. Wallet validates credential signature
17. Wallet resolves issuer DID
18. Wallet validates issuer
19. Wallet stores credential
20. Wallet displays success message
21. Wallet updates UI

**All with technical details: HTTP methods, headers, body structure**

---

### C1.2. OpenID4VCI Authorization Code Flow
**File**: `15-flow-oid4vci-auth-code.puml`  
**Steps**: Similar but with full OAuth2 authorization flow

---

### C1.3. DIDComm Credential Issuance (Aries RFC)
**File**: `16-flow-didcomm-credential-issuance.puml`  
**Protocol**: Aries Issue Credential Protocol 2.0

**Detailed Steps**:
1. Connection already established
2. Issuer sends credential offer (DIDComm message)
3. Wallet receives offer via mediator
4. Wallet sends push notification
5. User opens app
6. Wallet displays offer
7. User accepts
8. Wallet generates credential request
9. Wallet packs request (authcrypt)
10. Wallet sends via mediator
11. Issuer receives request
12. Issuer generates credential
13. Issuer sends credential (DIDComm)
14. Wallet receives credential
15. Wallet unpacks (decrypt + verify)
16. Wallet validates credential
17. Wallet stores credential
18. Wallet sends acknowledgment
19. Protocol complete

**All message structures shown in detail**

---

## C2. Proof Presentation Flows

### C2.1. OpenID4VP Direct Post Flow
**File**: `17-flow-oid4vp-direct-post.puml`  
**Detailed Steps** (25+ steps):
1. User scans verifier QR code
2. Wallet parses authorization request
3. Wallet extracts presentation definition
4. Wallet runs PEx engine
5. PEx evaluates input descriptors
6. PEx queries credential store
7. PEx finds matching credentials
8. Wallet displays matched credentials
9. User selects credentials
10. User selects attributes (selective disclosure)
11. Wallet generates presentation
12. Wallet creates SD-JWT disclosures (if applicable)
13. Wallet generates holder binding JWT
14. Wallet signs presentation
15. Wallet creates submission descriptor
16. Wallet POSTs to response_uri
17. Verifier receives presentation
18. Verifier validates presentation
19. Verifier validates holder binding
20. Verifier validates credentials
21. Verifier resolves issuer DIDs
22. Verifier checks signatures
23. Verifier checks revocation
24. Verifier returns result
25. Wallet displays confirmation

---

### C2.2. DIDComm Present Proof Flow
**File**: `18-flow-didcomm-present-proof.puml`  
**Protocol**: Aries Present Proof Protocol 2.0

**Detailed Steps** including:
- Proof request (with predicates)
- Credential selection
- ZKP generation
- Revocation proof inclusion
- Presentation generation
- All AnonCreds operations

---

## C3. Connection Establishment Flows

### C3.1. DIDComm Connection Protocol (RFC 0160)
**File**: `19-flow-didcomm-connection.puml`  

**Detailed Steps**:
1. Issuer/Verifier generates invitation
2. Invitation displayed as QR code
3. User scans QR
4. Wallet parses invitation
5. Wallet displays connection preview
6. User accepts
7. Wallet creates ephemeral DID
8. Wallet generates DID document
9. Wallet stores DID + keys
10. Wallet creates connection request
11. Wallet packs request (anoncrypt)
12. Wallet sends to service endpoint
13. Issuer receives request
14. Issuer creates their DID
15. Issuer creates connection response
16. Issuer packs response (authcrypt)
17. Issuer sends via mediator
18. Mediator forwards to wallet
19. Push notification sent
20. Wallet receives response
21. Wallet unpacks response
22. Wallet validates response
23. Wallet stores connection
24. Wallet sends ACK
25. Connection complete

---

### C3.2. Out-of-Band Invitation (RFC 0434)
**File**: `20-flow-oob-invitation.puml`  
**Enhanced invitation with multiple protocols**

---

## C4. Key Management Flows

### C4.1. Wallet Initialization & Key Generation
**File**: `21-flow-wallet-initialization.puml`  

**Detailed Steps**:
1. User completes onboarding
2. App generates mnemonic (24 words)
3. Display mnemonic to user (backup)
4. User confirms mnemonic
5. Generate seed from mnemonic
6. Store encrypted seed in Keystore
7. Derive master key (BIP32)
8. Derive first DID key (m/44'/0'/0'/0/0)
9. Create did:key
10. Store DID in database
11. Set as default DID
12. Generate encryption keys
13. Initialize database
14. Create first self-attested credential
15. Wallet ready

---

### C4.2. DID Creation for Different Methods
**File**: `22-flow-did-creation.puml`  

Show different flows for:
- did:key (instant)
- did:web (domain setup)
- did:ion (Bitcoin anchoring)
- did:ethr (Ethereum transaction)

---

## C5. Backup & Restore Flows

### C5.1. Encrypted Backup Flow
**File**: `23-flow-backup-encrypted.puml`  

**Detailed Steps**:
1. User initiates backup
2. User sets backup password
3. Derive encryption key (PBKDF2)
4. Export all data:
   - Encrypted seed
   - DIDs
   - Credentials
   - Connections
   - Settings
5. Encrypt backup bundle (AES-256)
6. Generate backup metadata
7. Upload to cloud (iCloud/Google Drive)
8. Verify upload
9. Display backup confirmation

---

### C5.2. Restore from Backup Flow
**File**: `24-flow-restore-from-backup.puml`  

**Detailed Steps**:
1. User on new device
2. User selects restore
3. User enters backup password
4. Download backup from cloud
5. Derive decryption key
6. Decrypt backup bundle
7. Validate backup integrity
8. Import seed (to Keystore)
9. Import DIDs
10. Import credentials
11. Import connections
12. Restore settings
13. Re-initialize wallet
14. Verify restoration
15. Cleanup temporary data

---

## C6. Enterprise Integration Flows

### C6.1. Microsoft Entra Verified ID Issuance
**File**: `25-flow-entra-issuance.puml`  

**Detailed Steps**:
1. Employee authenticates to Azure AD
2. Company initiates credential issuance
3. Entra generates credential offer
4. Offer sent to employee (email/QR)
5. Wallet scans/opens offer
6. Wallet calls Entra Request API
7. Entra validates request
8. Entra checks policy
9. Entra generates VC
10. Wallet receives VC
11. Wallet validates Entra signature
12. Wallet stores enterprise credential
13. Acknowledgment to Entra

---

### C6.2. Sphereon VDX Platform Integration
**File**: `26-flow-vdx-integration.puml`  

**B2B credential exchange workflow**

---

### C6.3. EBSI Credential Flow (EUDI Wallet)
**File**: `27-flow-ebsi-eudi.puml`  

**EU Digital Identity Wallet compliance flow**

---

## C7. Error Handling & Recovery Flows

### C7.1. Network Error Handling
**File**: `28-flow-error-network.puml`  

**Scenarios**:
- Timeout handling
- Retry logic
- Offline mode
- Queue management

---

### C7.2. Credential Revocation Detected
**File**: `29-flow-credential-revoked.puml`  

**Detailed Steps**:
1. Background job runs
2. Check revocation registry
3. Credential found revoked
4. Update credential status
5. Notify user
6. Display revoked badge
7. Prevent presentation

---

### C7.3. DIDComm Mediator Failover
**File**: `30-flow-mediator-failover.puml`  

**High availability flow**

---

# 📊 DIAGRAM SUMMARY

## Total Diagrams: 30+

### Breakdown by Category:

**KATEGORI A: Architecture (3)**
- 01-system-context
- 02-container-diagram
- 03-deployment-architecture

**KATEGORI B: Component Deep-Dive (10)**
- 04-component-ui-layer
- 05-component-did-management
- 06-component-credential-management
- 07-component-presentation-exchange
- 08-component-openid4vc
- 09-component-didcomm-messaging
- 10-component-key-management
- 11-component-data-persistence
- 12-component-security-layer
- 13-component-native-integration

**KATEGORI C: Dynamic Flows (17)**
- Credential Issuance (3 flows)
- Proof Presentation (2 flows)
- Connection Establishment (2 flows)
- Key Management (2 flows)
- Backup & Restore (2 flows)
- Enterprise Integration (3 flows)
- Error Handling (3 flows)

---

## 🎯 Mengapa Plan Ini Sangat Detail?

### 1. **Comprehensive Coverage**
Setiap aspek sistem dijelaskan - tidak ada yang tersembunyi

### 2. **Layered Approach**
Dari high-level ke implementasi detail

### 3. **Multiple Perspectives**
- Structural (Component diagrams)
- Behavioral (Flow diagrams)
- Deployment (Infrastructure)

### 4. **Every Protocol Explained**
- OID4VCI step-by-step
- OID4VP step-by-step
- DIDComm protocol details
- Aries RFCs implementation

### 5. **Security Emphasis**
Security bukan afterthought - dijelaskan secara mendalam

### 6. **Real Implementation Details**
- Actual data structures
- Actual algorithms
- Actual protocols
- Actual APIs

### 7. **Error Scenarios**
Tidak hanya happy path - error handling juga dijelaskan

---

## 📝 Implementation Order

Saya akan membuat diagram dengan urutan:

### Phase 1: Foundation (Diagrams 1-3)
Architecture diagrams untuk big picture

### Phase 2: Core Components (Diagrams 4-13)
Detail setiap subsystem

### Phase 3: Flows (Diagrams 14-30)
Runtime behavior dan interactions

---

## 🎨 Diagram Standards

**Semua diagram akan menggunakan**:
- C4 Model notation (official)
- PlantUML syntax
- Consistent styling
- Clear legends
- Detailed annotations
- Technical specifications

**Setiap diagram akan include**:
- Title
- Description
- All components labeled
- All relationships labeled with protocols
- Data structures where relevant
- Algorithm descriptions where relevant
- Error paths where relevant

---

**Apakah Anda setuju dengan plan ini?**

Dengan 30+ diagram ini, pembaca akan **BENAR-BENAR MEMAHAMI**:
- ✅ Apa itu Sphereon Mobile Wallet
- ✅ Bagaimana setiap bagian bekerja
- ✅ Bagaimana semua bagian bekerja bersama
- ✅ Bagaimana credential flow end-to-end
- ✅ Bagaimana proof flow end-to-end
- ✅ Bagaimana security diimplementasikan
- ✅ Bagaimana enterprise integration bekerja
- ✅ Bagaimana error handling dilakukan

**Tidak ada yang tersembunyi. Semuanya dijelaskan.**

Apakah saya mulai membuat diagram ini sekarang?
