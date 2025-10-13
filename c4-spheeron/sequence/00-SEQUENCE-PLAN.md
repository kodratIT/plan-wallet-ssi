# Sphereon Wallet - Sequence Diagram Plan
## KATEGORI C: Dynamic Flow Diagrams (Runtime Behavior)

> **Tujuan**: Menjelaskan BAGAIMANA sistem bekerja saat runtime - setiap interaksi dijelaskan step-by-step dengan sequence diagram yang sangat detail.

---

## 📋 Overview

Sequence diagram ini melengkapi component diagram yang sudah dibuat. Jika component diagram menjelaskan **STRUKTUR** sistem, maka sequence diagram menjelaskan **BEHAVIOR** sistem saat digunakan.

**Total Sequence Diagrams**: 17 diagrams
**Format**: PlantUML Sequence Diagram
**Detail Level**: Sangat tinggi - setiap step dijelaskan dengan pesan, parameter, return value

---

## 🎯 Grouping Sequence Diagrams

### Grup 1: Credential Issuance (3 diagrams)
Alur lengkap menerima credential dari issuer

### Grup 2: Proof Presentation (2 diagrams)
Alur lengkap mempresentasikan proof ke verifier

### Grup 3: Connection Establishment (2 diagrams)
Alur lengkap membangun koneksi dengan issuer/verifier

### Grup 4: Key Management (2 diagrams)
Alur lengkap inisialisasi wallet dan pembuatan DID

### Grup 5: Backup & Restore (2 diagrams)
Alur lengkap backup dan restore data wallet

### Grup 6: Enterprise Integration (3 diagrams)
Alur integrasi dengan platform enterprise

### Grup 7: Error Handling & Recovery (3 diagrams)
Alur penanganan error dan recovery

---

# 📊 DETAIL SEQUENCE DIAGRAMS

## GRUP 1: CREDENTIAL ISSUANCE FLOWS (3 diagrams)

### SD-01: OpenID4VCI Pre-Authorized Code Flow
**File**: `01-seq-oid4vci-pre-auth.puml`  
**Protocol**: OpenID for Verifiable Credential Issuance (Pre-Auth)  
**Trigger**: User scans QR code credential offer

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. OID4VCI Client
4. Key Manager
5. DID Manager
6. Credential Store
7. Issuer Authorization Server
8. Issuer Credential Endpoint

**High-Level Steps** (akan dijelaskan detail):
1. **QR Scan & Parse** (3 steps)
   - User scans QR code
   - Parse credential offer URL
   - Extract pre-authorized code & issuer metadata

2. **Issuer Discovery** (4 steps)
   - Fetch .well-known/openid-credential-issuer
   - Parse issuer metadata
   - Validate credential types supported
   - Display issuer info to user

3. **User Review** (2 steps)
   - Display credential preview
   - User accepts/rejects

4. **Token Request** (5 steps)
   - Prepare token request (pre-auth code + PIN)
   - POST to token endpoint
   - Validate token response
   - Store access token
   - Handle token errors

5. **Proof of Possession** (6 steps)
   - Select/create DID for credential
   - Get DID private key from Key Manager
   - Generate JWT proof (key binding)
   - Include nonce, audience, DID
   - Sign with DID key
   - Validate proof structure

6. **Credential Request** (5 steps)
   - Build credential request (with PoP)
   - POST to credential endpoint
   - Handle response (immediate vs deferred)
   - Parse credential (JWT/JSON-LD/SD-JWT)
   - Validate credential structure

7. **Credential Validation** (7 steps)
   - Resolve issuer DID
   - Verify credential signature
   - Validate credential schema
   - Check credential expiry
   - Validate credential subject (matches holder DID)
   - Check revocation status (if applicable)
   - Validate credential metadata

8. **Store & Display** (4 steps)
   - Store credential in database
   - Fetch OCA bundle (branding)
   - Update credential list UI
   - Show success message

**Total Steps**: ~36 detailed interactions
**Error Scenarios**: Network error, Invalid token, Invalid credential, Signature verification failed

---

### SD-02: OpenID4VCI Authorization Code Flow
**File**: `02-seq-oid4vci-auth-code.puml`  
**Protocol**: OpenID for Verifiable Credential Issuance (Auth Code + PKCE)  
**Trigger**: User scans QR code requiring full OAuth2 authorization

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. OID4VCI Client
4. Key Manager
5. DID Manager
6. Credential Store
7. Issuer Authorization Server
8. Issuer Credential Endpoint
9. Browser (for authorization)

**Perbedaan dengan SD-01**:
- Ada full OAuth2 authorization flow dengan PKCE
- User perlu login/consent di issuer website
- Lebih kompleks tapi lebih aman

**High-Level Steps**:
1. **QR Scan & Parse** (sama seperti SD-01)
2. **Issuer Discovery** (sama seperti SD-01)
3. **Authorization Request** (8 steps)
   - Generate code verifier (PKCE)
   - Generate code challenge (SHA-256)
   - Build authorization URL
   - Open browser with authorization URL
   - User login di issuer
   - User consent
   - Redirect back to wallet dengan auth code
   - Parse redirect URL

4. **Token Exchange** (6 steps)
   - Build token request (auth code + code verifier)
   - POST to token endpoint
   - Validate PKCE
   - Receive access token
   - Store tokens
   - Handle token errors

5. **Proof of Possession** (sama seperti SD-01)
6. **Credential Request** (sama seperti SD-01)
7. **Credential Validation** (sama seperti SD-01)
8. **Store & Display** (sama seperti SD-01)

**Total Steps**: ~45 detailed interactions

---

### SD-03: DIDComm Credential Issuance Flow
**File**: `03-seq-didcomm-credential-issuance.puml`  
**Protocol**: Aries Issue Credential Protocol 2.0 (RFC 0453)  
**Trigger**: Issuer sends credential offer via DIDComm

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. DIDComm Handler
4. Message Queue
5. Mediator Service
6. Key Manager
7. DID Resolver
8. Credential Store
9. Issuer Agent
10. Push Notification Service

**High-Level Steps**:
1. **Connection Prerequisite** (2 steps)
   - Verify connection exists
   - Get connection details

2. **Receive Offer** (8 steps)
   - Issuer sends offer-credential message
   - Message routed via mediator
   - Mediator forwards to wallet
   - Wallet receives encrypted message
   - Push notification sent
   - User opens app
   - Unpack message (authcrypt decrypt)
   - Validate sender DID

3. **Parse Offer** (5 steps)
   - Parse credential preview
   - Extract credential format
   - Extract attachment (if any)
   - Display offer to user
   - User accepts/rejects

4. **Request Credential** (7 steps)
   - Build request-credential message
   - Include thread ID (from offer)
   - Include holder DID
   - Include formats
   - Pack message (authcrypt)
   - Send via mediator
   - Confirm sent

5. **Receive Credential** (10 steps)
   - Issuer generates credential
   - Issuer sends issue-credential message
   - Routed via mediator
   - Push notification
   - User opens app
   - Unpack message
   - Validate message type
   - Validate thread
   - Extract credential from attachment
   - Validate credential structure

6. **Validate Credential** (sama seperti SD-01)

7. **Acknowledge** (5 steps)
   - Build ack message
   - Include thread ID
   - Pack message
   - Send via mediator
   - Update protocol state to complete

8. **Store & Display** (sama seperti SD-01)

**Total Steps**: ~40 detailed interactions
**DIDComm Message Types**: offer-credential, request-credential, issue-credential, ack

---

## GRUP 2: PROOF PRESENTATION FLOWS (2 diagrams)

### SD-04: OpenID4VP Direct Post Flow
**File**: `04-seq-oid4vp-direct-post.puml`  
**Protocol**: OpenID for Verifiable Presentations  
**Trigger**: User scans verifier QR code

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. OID4VP Client
4. Presentation Exchange Engine
5. Credential Store
6. Key Manager
7. DID Manager
8. Verifier Service

**High-Level Steps**:
1. **QR Scan & Parse** (4 steps)
   - User scans verifier QR
   - Parse authorization request
   - Extract presentation definition
   - Extract response_uri, nonce, client_id

2. **Presentation Definition Analysis** (6 steps)
   - Parse PEx v2 JSON
   - Extract input descriptors
   - Parse constraints (field, format, predicate)
   - Parse submission requirements
   - Identify required credential types
   - Build query for credential store

3. **Credential Matching** (8 steps)
   - Query credential store
   - Filter by schema/type
   - Filter by issuer (if required)
   - Match field constraints
   - Match format requirements
   - Calculate match score
   - Rank matched credentials
   - Handle no-match scenario

4. **User Selection** (5 steps)
   - Display matched credentials
   - Show required vs optional fields
   - User selects credentials
   - User selects attributes (selective disclosure)
   - Confirm selection

5. **Presentation Generation** (10 steps)
   - Get selected credentials
   - Apply selective disclosure
     - For SD-JWT: select disclosure claims
     - For JSON-LD: apply frame
     - For JWT: include all (no selective)
   - Generate presentation wrapper
   - Create submission descriptor
     - Descriptor map
     - Path references
   - Generate holder binding
     - Create holder binding JWT
     - Include nonce, audience
     - Sign with holder DID key
   - Combine into VP token

6. **Presentation Validation** (5 steps)
   - Validate VP structure
   - Validate against PEx definition
   - Check all constraints satisfied
   - Check submission descriptor correctness
   - Validate holder binding

7. **Send Presentation** (6 steps)
   - Build POST request
   - Include VP token, presentation_submission
   - POST to response_uri
   - Handle verifier response
     - Immediate: redirect_uri with result
     - Async: polling endpoint
   - Display result to user
   - Store presentation history

**Total Steps**: ~44 detailed interactions
**Selective Disclosure Formats**: SD-JWT (hash-based), JSON-LD VC (frame-based)

---

### SD-05: DIDComm Present Proof Flow
**File**: `05-seq-didcomm-present-proof.puml`  
**Protocol**: Aries Present Proof Protocol 2.0 (RFC 0454)  
**Trigger**: Verifier sends proof request via DIDComm

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. DIDComm Handler
4. Presentation Engine
5. Credential Store
6. AnonCreds Engine (for ZKP)
7. Key Manager
8. Mediator Service
9. Verifier Agent
10. Push Notification Service

**High-Level Steps**:
1. **Receive Proof Request** (sama seperti SD-03 receive offer)

2. **Parse Request** (8 steps)
   - Parse request-presentation message
   - Extract proof format (Indy, DIF PEx, etc.)
   - Parse requested attributes
   - Parse requested predicates (ZKP)
     - age >= 18
     - balance > 10000
   - Parse restrictions (issuer, schema)
   - Display request to user
   - Show what data requested
   - User accepts/rejects

3. **Credential Selection** (AnonCreds specific) (10 steps)
   - Query credentials by schema
   - Filter by issuer restrictions
   - For each requested attribute:
     - Find credential containing attribute
   - For each predicate:
     - Find credential containing attribute
     - Check if ZKP possible
   - Handle multiple credential scenarios
   - User selects credentials
   - Validate selection satisfies request
   - Get credential definitions
   - Get revocation registries

4. **Generate Proof** (AnonCreds ZKP) (15 steps)
   - Get blinded credential secrets
   - Get credential signature
   - For revealed attributes:
     - Include attribute value
     - Include encoded value (hash)
   - For predicates:
     - Generate ZKP (without revealing actual value)
     - Prove age >= 18 without revealing age
   - Generate proof of non-revocation
     - Get revocation tails
     - Generate accumulator witness
     - Create non-revocation proof
   - Combine into presentation
   - Self-attest requested_predicates (if any)
   - Sign presentation
   - Validate proof structure

5. **Send Proof** (DIDComm) (6 steps)
   - Build presentation message
   - Attach proof in formats~attach
   - Include thread ID
   - Pack message (authcrypt)
   - Send via mediator
   - Update protocol state

6. **Receive Acknowledgment** (5 steps)
   - Verifier validates proof
   - Verifier sends ack or problem-report
   - Wallet receives response
   - Unpack message
   - Display result to user

7. **Store History** (2 steps)
   - Store proof request & presentation
   - Update UI

**Total Steps**: ~46 detailed interactions
**ZKP Highlight**: Predicate proofs tanpa reveal actual value
**Revocation**: Non-revocation proof included

---

## GRUP 3: CONNECTION ESTABLISHMENT FLOWS (2 diagrams)

### SD-06: DIDComm Connection Protocol
**File**: `06-seq-didcomm-connection.puml`  
**Protocol**: DIDComm Connection Protocol (RFC 0160)  
**Trigger**: User scans connection invitation QR

**Participants**:
1. User (Holder)
2. Mobile Wallet UI
3. QR Scanner
4. DIDComm Handler
5. DID Manager
6. Key Manager
7. Connection Store
8. Mediator Service
9. Inviter Agent (Issuer/Verifier)

**High-Level Steps**:
1. **Scan Invitation** (5 steps)
   - User scans QR code
   - Parse invitation URL
   - Extract invitation JSON
   - Validate invitation structure
   - Display inviter info to user

2. **User Review** (3 steps)
   - Show inviter name, image, purpose
   - User accepts/rejects
   - If reject, stop

3. **Create Ephemeral DID** (8 steps)
   - Generate new did:peer (method 2)
   - Create Ed25519 key pair (for signing)
   - Create X25519 key pair (for encryption)
   - Build DID document
     - Add authentication key
     - Add keyAgreement key
     - Add service endpoint (mediator)
   - Store DID + keys securely
   - Set DID for this connection

4. **Register with Mediator** (7 steps)
   - Connect to mediator
   - Send coordinate-mediation request
   - Mediator assigns inbox
   - Wallet receives mediation grant
   - Register routing keys
   - Update DID document with mediator endpoint
   - Confirm registration

5. **Send Connection Request** (8 steps)
   - Build connection-request message
   - Include wallet DID
   - Include wallet DID document
   - Include label (wallet name)
   - Include image URL
   - Pack message (anoncrypt - no prior relationship)
   - Send to inviter service endpoint
   - Store connection as "requested" state

6. **Receive Connection Response** (12 steps)
   - Inviter creates their DID
   - Inviter builds connection-response
   - Inviter includes their DID + DID doc
   - Inviter packs with authcrypt (now can authenticate)
   - Inviter sends via mediator
   - Mediator stores in wallet inbox
   - Push notification sent
   - User opens app
   - Wallet polls/receives message
   - Wallet unpacks message
   - Validate message type
   - Extract inviter DID + DID document

7. **Validate & Store Connection** (8 steps)
   - Validate inviter DID document
   - Resolve inviter DID (verify)
   - Extract inviter keys
   - Extract inviter service endpoints
   - Store connection details
     - Their DID, label, image
     - Our DID for this connection
     - State = "responded"
   - Update UI (new connection)
   - Prepare acknowledgment

8. **Send Acknowledgment** (6 steps)
   - Build ack message
   - Include thread ID
   - Pack message (authcrypt)
   - Send via mediator to inviter
   - Update connection state = "complete"
   - Connection established ✓

**Total Steps**: ~57 detailed interactions
**DID Method**: did:peer (method 2) for pairwise DIDs
**Encryption**: Anoncrypt for request, Authcrypt for response/ack

---

### SD-07: Out-of-Band Invitation Flow
**File**: `07-seq-oob-invitation.puml`  
**Protocol**: Out-of-Band Protocol (RFC 0434)  
**Trigger**: Multi-protocol invitation (can start connection OR credential issuance)

**Participants**: (sama seperti SD-06 plus)
- Protocol Router
- OID4VCI Client (if invitation includes OID4VCI)

**High-Level Steps**:
1. **Scan OOB Invitation** (6 steps)
   - Parse OOB invitation
   - Check invitation type
   - Extract goal_code (connect, issue, verify)
   - Extract services (DIDComm, OID4VCI, OID4VP)
   - Extract attachments (credential offer, proof request)
   - Determine flow

2. **Route to Appropriate Flow** (3 steps)
   - If goal = "connect" → DIDComm Connection (SD-06)
   - If goal = "issue" + OID4VCI → OID4VCI Flow (SD-01/02)
   - If goal = "issue" + DIDComm → DIDComm Issuance (SD-03)
   - If goal = "verify" → Presentation Flow (SD-04/05)

3. **Continue with Selected Flow** (see respective SD)

**Total Steps**: ~10 + selected flow
**Flexibility**: One QR for multiple protocols

---

## GRUP 4: KEY MANAGEMENT FLOWS (2 diagrams)

### SD-08: Wallet Initialization & Key Generation
**File**: `08-seq-wallet-initialization.puml`  
**Trigger**: User completes onboarding

**Participants**:
1. User
2. Onboarding UI
3. Wallet Initializer
4. Key Manager
5. HD Wallet (BIP32/39)
6. DID Manager
7. Secure Storage (Keystore/Keychain)
8. Database Manager
9. Credential Store

**High-Level Steps**:
1. **User Completes Onboarding** (4 steps)
   - Welcome screens
   - Terms & conditions accepted
   - PIN created & confirmed
   - Biometric setup (optional)

2. **Generate Mnemonic** (7 steps)
   - Generate 256-bit entropy
   - Encode to 24 words (BIP39)
   - Display mnemonic to user
   - User writes down (backup)
   - User confirms mnemonic (quiz)
   - Validate confirmation
   - Proceed if correct

3. **Generate Seed** (5 steps)
   - Generate seed from mnemonic (512-bit)
   - Apply optional passphrase
   - Derive master key (BIP32)
   - Encrypt seed with PIN-derived key
   - Store encrypted seed in Keystore

4. **Derive First Keys** (10 steps)
   - Derive first account key (m/44'/0'/0'/0/0)
   - Generate Ed25519 key pair
   - Store private key in Keystore
   - Generate key ID
   - Create did:key from public key
   - Build DID document
   - Store DID in database
   - Set as default DID
   - Generate X25519 encryption key
   - Store encryption key

5. **Initialize Database** (6 steps)
   - Run migrations
   - Create tables (Credentials, Connections, DIDs, etc.)
   - Initialize empty stores
   - Set wallet metadata (created date, version)
   - Set wallet ID (UUID)
   - Commit

6. **Generate Master Encryption Key** (5 steps)
   - Derive encryption key from seed
   - Store in Keystore (hardware-backed)
   - Use for database encryption
   - Use for field-level encryption
   - Test encryption/decryption

7. **Create Self-Attested Credential** (optional) (6 steps)
   - Generate first credential (wallet info)
   - Include wallet DID, created date
   - Sign with wallet DID key
   - Store credential
   - Display in wallet
   - Welcome message

8. **Complete Initialization** (3 steps)
   - Set wallet state = "initialized"
   - Navigate to home screen
   - Show tutorial (optional)

**Total Steps**: ~46 detailed interactions
**Security Highlights**: 
- Mnemonic never stored unencrypted
- PIN-based encryption with Argon2id
- Hardware-backed key storage

---

### SD-09: DID Creation for Different Methods
**File**: `09-seq-did-creation.puml`  
**Trigger**: User creates new DID (dari settings)

**Participants**:
1. User
2. Settings UI
3. DID Manager
4. Key Manager
5. DID Registrar
6. Method-specific providers
7. Blockchain/Ledger (for some methods)

**Multiple Sub-Flows** (4 different DID methods):

#### Sub-Flow 1: Create did:key (Instant)
**Steps** (5 steps):
1. Generate key pair (Ed25519 or Secp256k1)
2. Create did:key from public key
3. Build DID document (auto-derived)
4. Store DID + keys
5. Ready to use (no registration needed)

#### Sub-Flow 2: Create did:web (Domain-based)
**Steps** (12 steps):
1. User enters domain
2. Validate domain ownership requirement
3. Generate key pair
4. Create did:web (did:web:example.com)
5. Build DID document
6. Export DID document JSON
7. Instruct user to upload to:
   - https://example.com/.well-known/did.json
8. User uploads file
9. Verify upload (resolve did:web)
10. If successful, store DID
11. If failed, show error
12. Complete

#### Sub-Flow 3: Create did:ion (Bitcoin-anchored)
**Steps** (18 steps):
1. Generate key pairs (multiple for recovery)
2. Create ION DID document
3. Add public keys
4. Add service endpoints
5. Build ION create operation
6. Generate long-form DID (includes full state)
7. Store DID (usable immediately with long-form)
8. Submit operation to ION node
9. ION node batches operations
10. ION writes to IPFS
11. ION anchors to Bitcoin blockchain
12. Wait for confirmation (10 min - 1 hour)
13. Poll ION node for anchor status
14. Once anchored, get short-form DID
15. Update DID record (now can use short-form)
16. Display confirmation
17. Store anchor proof
18. DID fully registered

#### Sub-Flow 4: Create did:ethr (Ethereum)
**Steps** (15 steps):
1. Generate key pair (Secp256k1)
2. Derive Ethereum address from public key
3. Create did:ethr DID (did:ethr:0x...)
4. Build DID document
5. User needs ETH for gas
6. Check wallet balance
7. Build Ethereum transaction
   - Call EthereumDIDRegistry contract
   - setAttribute(did, key, value)
8. Estimate gas
9. Display gas cost to user
10. User confirms
11. Sign transaction
12. Send to Ethereum network
13. Wait for confirmation (15s - 2min)
14. Verify registration (call contract)
15. Store DID + transaction hash

**Total Steps**: ~50 across all methods
**Method Comparison Shown**: Instant vs Domain vs Blockchain

---

## GRUP 5: BACKUP & RESTORE FLOWS (2 diagrams)

### SD-10: Encrypted Backup Flow
**File**: `10-seq-backup-encrypted.puml`  
**Trigger**: User initiates backup from settings

**Participants**:
1. User
2. Settings UI
3. Backup Manager
4. Database Manager
5. Key Manager
6. Encryption Service
7. Credential Store
8. Connection Store
9. Cloud Service (iCloud/Google Drive)

**High-Level Steps**:
1. **Initiate Backup** (4 steps)
   - User selects "Backup Wallet"
   - Show backup options (cloud vs file)
   - User selects cloud
   - Prompt for backup password

2. **Password Setup** (6 steps)
   - User enters backup password
   - User confirms password
   - Validate password strength
     - Min 12 characters
     - Mix of upper, lower, numbers, symbols
   - Derive encryption key (PBKDF2)
     - 100,000 iterations
     - Random salt
   - Store salt (needed for restore)
   - Confirm password accepted

3. **Collect Data** (12 steps)
   - Export encrypted seed from Keystore
   - Export all DIDs from database
   - Export all credentials
   - Export all connections
   - Export message history (optional)
   - Export settings
   - Export metadata (wallet ID, version)
   - Export key references
   - Calculate total size
   - Show progress to user
   - Validate data completeness
   - Create data manifest

4. **Encrypt Backup** (8 steps)
   - Create backup bundle JSON
   - Generate random IV
   - Encrypt bundle with AES-256-GCM
     - Key from PBKDF2
     - IV random per backup
     - Authenticated encryption
   - Generate authentication tag
   - Calculate backup hash
   - Create backup metadata
     - Backup date
     - Wallet ID
     - Data version
     - Salt, IV
   - Package encrypted data + metadata
   - Validate encrypted bundle

5. **Upload to Cloud** (10 steps)
   - Check cloud service availability
   - Authenticate to cloud (OAuth)
   - Check cloud storage space
   - Create backup folder
   - Generate backup filename
     - sphereon_backup_2024-01-15_abc123.bak
   - Upload encrypted file
   - Show upload progress
   - Verify upload (check hash)
   - Store backup metadata locally
   - Display success message

6. **Backup Verification** (5 steps)
   - Download uploaded file
   - Verify file hash
   - Test decryption (with password)
   - Confirm data integrity
   - Show verification result

**Total Steps**: ~45 detailed interactions
**Security**: 
- Password never stored
- PBKDF2 for key derivation
- AES-256-GCM authenticated encryption
- Cloud file is useless without password

---

### SD-11: Restore from Backup Flow
**File**: `11-seq-restore-from-backup.puml`  
**Trigger**: User on new device, selects "Restore Wallet"

**Participants**: (sama seperti SD-10)

**High-Level Steps**:
1. **Initiate Restore** (3 steps)
   - User on fresh app install
   - User selects "Restore from Backup"
   - Show restore options (cloud vs file)

2. **Authenticate to Cloud** (5 steps)
   - User selects cloud provider
   - OAuth login flow
   - List available backups
   - User selects backup file
   - Download backup file

3. **Password Entry** (4 steps)
   - Prompt for backup password
   - User enters password
   - Extract salt from backup metadata
   - Derive decryption key (PBKDF2)

4. **Decrypt Backup** (8 steps)
   - Extract IV from metadata
   - Attempt decryption (AES-256-GCM)
   - Validate authentication tag
   - If tag invalid → wrong password
   - If valid → decrypt successful
   - Parse backup bundle JSON
   - Validate bundle structure
   - Extract data sections

5. **Validate Backup** (6 steps)
   - Check backup version compatibility
   - Validate wallet ID
   - Check data manifest
   - Verify all sections present
   - Calculate data hash
   - Confirm integrity

6. **Restore Seed & Keys** (10 steps)
   - Extract encrypted seed
   - Import seed to Keystore
   - Derive master key
   - Re-derive child keys
   - Validate key derivation
   - Import encryption keys
   - Test key operations (sign test message)
   - Store keys in Keystore
   - Set up encryption master key
   - Confirm keys restored

7. **Restore Database** (12 steps)
   - Drop existing database (if any)
   - Run migrations (create tables)
   - Import DIDs
     - Validate DID format
     - Store in database
     - Set default DID
   - Import Credentials
     - Decrypt credential data
     - Validate credentials
     - Store in database
   - Import Connections
     - Restore connection state
     - Store in database
   - Import Message history
   - Import Settings
   - Commit transactions
   - Verify record counts

8. **Restore Configuration** (6 steps)
   - Restore wallet settings
   - Restore security settings
   - Restore language preference
   - Restore theme
   - Restore notification settings
   - Apply configuration

9. **Re-initialize Wallet** (8 steps)
   - Initialize Key Manager
   - Initialize DID Manager
   - Initialize Credential Manager
   - Initialize Connection Manager
   - Re-register with mediator (new device)
     - Update routing keys
     - Get new inbox
   - Update service endpoints in DID documents
   - Synchronize with cloud (check for new messages)
   - Complete initialization

10. **Verify Restoration** (7 steps)
    - Display restored credential count
    - Display restored connection count
    - Display restored DID count
    - Verify default DID set
    - Test signature operation
    - Test encryption operation
    - Show success message

11. **Cleanup** (3 steps)
    - Delete temporary files
    - Clear decryption keys from memory
    - Navigate to home screen

**Total Steps**: ~72 detailed interactions
**Critical**: 
- Wrong password = cannot decrypt
- New device = need new mediator registration
- DID documents may need service endpoint updates

---

## GRUP 6: ENTERPRISE INTEGRATION FLOWS (3 diagrams)

### SD-12: Microsoft Entra Verified ID Issuance
**File**: `12-seq-entra-issuance.puml`  
**Platform**: Microsoft Entra Verified ID (formerly Azure AD VID)  
**Trigger**: Employee receives credential from company

**Participants**:
1. Employee (User)
2. Mobile Wallet
3. Company HR System
4. Microsoft Entra Verified ID Service
5. Entra Request API
6. Entra Issuing Service
7. Azure AD (authentication)
8. ION (DID anchoring)

**High-Level Steps**:
1. **Employee Authentication** (5 steps)
   - Employee logs in to company portal
   - Azure AD authentication (SSO)
   - MFA verification
   - User authenticated
   - HR system session established

2. **Credential Issuance Trigger** (4 steps)
   - HR admin initiates issuance
   - Select credential type (EmployeeID)
   - Select employee
   - Configure credential claims

3. **Entra Request Creation** (8 steps)
   - HR system calls Entra Request API
   - Include employee data
   - Include credential type
   - Entra validates request
   - Entra checks policy
   - Entra generates credential offer
   - Entra creates QR code / deep link
   - Return offer to HR system

4. **Deliver to Employee** (3 steps)
   - HR system sends email/notification
   - Include QR code or link
   - Employee receives notification

5. **Employee Scans Offer** (sama seperti SD-01 QR scan)

6. **Wallet Connects to Entra** (10 steps)
   - Parse credential offer (OpenID4VCI)
   - Extract Entra issuer URL
   - Fetch Entra issuer metadata
   - Validate Entra as trusted issuer
   - Display company info (branding)
   - User accepts offer
   - Wallet requests token
   - Entra validates request
   - Entra checks employee authorization
   - Entra returns access token

7. **Proof of Possession** (7 steps)
   - Wallet generates/selects DID
   - Create PoP JWT
   - Include employee DID
   - Sign with DID key
   - Send credential request to Entra
   - Include PoP
   - Entra validates PoP

8. **Credential Generation** (10 steps)
   - Entra retrieves employee data
   - Entra applies credential rules
   - Entra creates VC (W3C format)
   - Include claims:
     - employeeId
     - name
     - department
     - startDate
   - Entra signs with company DID
   - Company DID anchored on ION
   - Entra returns credential
   - Wallet receives credential
   - Wallet validates Entra signature
   - Wallet resolves company DID (did:ion)

9. **Store & Branding** (6 steps)
   - Wallet stores credential
   - Fetch company branding (logo, colors)
   - Apply OCA styling
   - Update credential list
   - Show success message
   - Employee can now use for access

**Total Steps**: ~53 interactions
**Highlights**:
- Integration with Azure AD
- Company DID on ION blockchain
- OCA branding for company credentials
- Policy-based issuance

---

### SD-13: Sphereon VDX Platform Integration
**File**: `13-seq-vdx-integration.puml`  
**Platform**: Sphereon VDX (Verifiable Data Exchange)  
**Use Case**: B2B credential exchange

**Participants**:
1. Company A (Credential Holder)
2. Company B (Credential Requester)
3. Mobile Wallet (Company A employee)
4. Sphereon VDX Platform
5. VDX API Gateway
6. Credential Exchange Service
7. Notification Service

**High-Level Steps**:
1. **B2B Agreement Setup** (6 steps)
   - Company B requests credential from Company A
   - Specify credential type needed
   - Specify purpose & legal basis
   - Company A reviews request
   - Company A approves data sharing
   - VDX creates exchange template

2. **Employee Consent Request** (8 steps)
   - VDX sends notification to employee
   - Employee opens wallet
   - Display consent request
     - Requesting party (Company B)
     - Purpose of request
     - Data being shared
     - Legal basis
   - Employee reviews
   - Employee consents/rejects
   - If consent, continue
   - Store consent record (GDPR)

3. **Credential Preparation** (7 steps)
   - Wallet retrieves requested credential
   - Apply company policy
   - Selective disclosure (if applicable)
   - Generate presentation
   - Sign presentation
   - Include consent proof
   - Package for VDX

4. **Secure Transfer via VDX** (10 steps)
   - Wallet uploads to VDX
   - VDX receives presentation
   - VDX validates presentation
   - VDX logs transfer (audit trail)
   - VDX encrypts for Company B
   - VDX notifies Company B
   - Company B retrieves data
   - Company B validates
   - VDX confirms delivery
   - VDX notifies wallet (transfer complete)

5. **Audit & Compliance** (5 steps)
   - VDX creates audit log
   - Include timestamp, parties, purpose
   - Store consent record
   - Enable revocation by employee
   - Provide transparency dashboard

**Total Steps**: ~36 interactions
**Highlights**:
- GDPR-compliant consent
- Audit trail for B2B exchange
- Employee maintains control
- Secure platform-mediated transfer

---

### SD-14: EBSI Credential Flow (EUDI Wallet)
**File**: `14-seq-ebsi-eudi.puml`  
**Platform**: EBSI (European Blockchain Services Infrastructure)  
**Compliance**: EUDI Wallet ARF (EU Digital Identity)  
**Use Case**: EU compliant diploma credential

**Participants**:
1. Student (Citizen)
2. EUDI Wallet (Sphereon)
3. University Issuer
4. EBSI Trusted Issuers Registry
5. EBSI Ledger
6. EBSI Timestamp Service
7. OpenID4VCI Server (university)

**High-Level Steps**:
1. **Verify Trusted Issuer** (8 steps)
   - Student requests diploma
   - University initiates issuance
   - Wallet queries EBSI Trusted Issuers Registry
   - Check university is authorized issuer
   - Verify for credential type "Diploma"
   - Verify university DID on EBSI
   - Validate accreditation
   - Confirm trusted issuer

2. **EUDI Compliant OID4VCI** (similar to SD-01 but with) (12 steps)
   - Additional EUDI requirements
   - PID (Personal Identification Data) verification
   - eIDAS-compliant authentication
   - Qualified Electronic Signature (QES)
   - Student authenticates (strong auth)
   - Student verifies identity
   - Proceed with OID4VCI flow
   - Include EUDI attestation
   - University generates diploma VC
   - Sign with QES
   - Include EBSI proofs
   - Return to wallet

3. **Anchor to EBSI** (10 steps)
   - Wallet receives credential
   - Validate credential against EBSI schema
   - Wallet sends to EBSI Timestamp Service
   - EBSI creates timestamp proof
   - EBSI writes hash to ledger
   - EBSI returns timestamp proof
   - Wallet attaches timestamp to credential
   - Credential now has immutable proof
   - Store credential with timestamp
   - Display with EBSI verified badge

4. **Verification Process** (8 steps)
   - Employer requests diploma proof
   - Wallet generates presentation
   - Include EBSI timestamp proof
   - Employer verifies:
     - University is trusted issuer (EBSI registry)
     - Credential signature valid
     - Timestamp valid (EBSI ledger)
     - Credential not expired
     - Credential not revoked (EBSI revocation)
   - All checks pass
   - Diploma verified ✓
   - Cross-border recognition (EU-wide)

**Total Steps**: ~38 interactions
**EBSI Highlights**:
- EU-wide trusted issuer registry
- Blockchain timestamp proof
- EUDI Wallet ARF compliant
- Cross-border credential recognition
- Qualified signatures

---

## GRUP 7: ERROR HANDLING & RECOVERY FLOWS (3 diagrams)

### SD-15: Network Error Handling & Retry
**File**: `15-seq-error-network.puml`  
**Scenarios**: Timeout, Connection Lost, Server Error

**Participants**:
1. User
2. Mobile Wallet
3. Network Layer
4. Retry Manager
5. Message Queue
6. UI (Error Display)
7. External Service (issuer/verifier/mediator)

**Multiple Sub-Scenarios**:

#### Scenario A: Connection Timeout During Credential Request
**Steps** (15 steps):
1. Wallet sends credential request
2. Network layer sends HTTP POST
3. Timeout occurs (30s no response)
4. Network layer throws timeout error
5. Retry Manager catches error
6. Check retry policy
   - Max retries: 3
   - Backoff: exponential (2s, 4s, 8s)
7. First retry (after 2s)
8. Send request again
9. Timeout again
10. Second retry (after 4s)
11. Send request again
12. Success - response received
13. Parse response
14. Continue credential flow
15. Display success

#### Scenario B: Complete Network Loss (Offline Mode)
**Steps** (12 steps):
1. User loses network connection
2. Wallet detects offline
3. Display offline banner
4. Queue outbound messages
5. Disable actions requiring network
   - Credential requests
   - Proof presentations
6. Enable offline actions
   - View credentials
   - View connections
   - Prepare presentations (draft)
7. User reconnects
8. Wallet detects online
9. Hide offline banner
10. Process message queue (FIFO)
11. Retry queued operations
12. Update UI

#### Scenario C: Server Returns 500 Error
**Steps** (10 steps):
1. Wallet sends request
2. Server returns 500 Internal Server Error
3. Network layer receives error response
4. Check if retryable (500 is retryable)
5. Retry Manager schedules retry
6. Exponential backoff
7. Retry request
8. If persistent (3 failures)
9. Display user-friendly error
10. Store failed operation for manual retry

**Total Scenarios**: 3
**Total Steps**: ~37 across scenarios

---

### SD-16: Credential Revocation Detection & Handling
**File**: `16-seq-credential-revoked.puml`  
**Trigger**: Background job or pre-presentation check

**Participants**:
1. Background Job (WorkManager/BackgroundTasks)
2. Revocation Checker
3. Credential Store
4. Revocation Registry (Ledger)
5. Status List 2021 Service
6. Notification Service
7. User

**High-Level Steps**:
1. **Background Check Scheduled** (4 steps)
   - WorkManager schedules periodic task
   - Every 24 hours (configurable)
   - Job triggered
   - Fetch all credentials to check

2. **Check Each Credential** (loop) (10 steps per credential)
   - Get credential revocation info
   - Determine revocation method:
     - Status List 2021 (most common)
     - Credential Status (REST API)
     - Revocation Registry (AnonCreds/Indy)
   - If Status List 2021:
     - Fetch status list URL
     - Download compressed bitstring
     - Decompress
     - Check credential index bit
     - If bit = 1 → revoked
     - If bit = 0 → valid
   - Cache status list (1 hour)
   - Update credential status in DB
   - If status changed to revoked:
     - Mark credential as revoked
     - Trigger notification

3. **Notify User** (6 steps)
   - Create notification
   - Include credential name, issuer
   - Send push notification
   - Display in notification center
   - Update credential UI (revoked badge)
   - When user opens:
     - Show revoked alert
     - Explain implications
     - Suggest contacting issuer

4. **Pre-Presentation Check** (8 steps)
   - User about to present credential
   - Wallet performs real-time check
   - Query revocation status
   - If revoked:
     - Block presentation
     - Display error to user
     - Cannot use revoked credential
     - Remove from selection
   - If valid:
     - Proceed with presentation
     - Include fresh revocation proof (AnonCreds)

5. **Bulk Revocation Handling** (6 steps)
   - Multiple credentials from same issuer
   - Issuer revokes batch
   - Status list updated
   - Background job detects
   - Mark all as revoked
   - Notify user once (grouped)

**Total Steps**: ~34 interactions
**Revocation Methods Supported**:
- Status List 2021 (W3C standard)
- AnonCreds revocation registry
- REST API status check

---

### SD-17: DIDComm Mediator Failover & High Availability
**File**: `17-seq-mediator-failover.puml`  
**Scenario**: Primary mediator goes down

**Participants**:
1. Mobile Wallet
2. Connection Manager
3. DIDComm Message Router
4. Primary Mediator
5. Secondary Mediator (backup)
6. Health Check Service
7. Load Balancer

**High-Level Steps**:
1. **Normal Operation** (4 steps)
   - Wallet connected to primary mediator
   - Messages routed via primary
   - Heartbeat every 30s
   - All functioning normally

2. **Detect Primary Failure** (8 steps)
   - Send heartbeat/ping
   - No response (timeout 10s)
   - Retry ping (2nd attempt)
   - No response
   - Retry ping (3rd attempt)
   - No response
   - Mark primary as down
   - Trigger failover

3. **Failover to Secondary** (12 steps)
   - Load mediator configuration
   - Get secondary mediator URL
   - Test connectivity to secondary
   - Secondary responds OK
   - Connect to secondary mediator
   - Send coordinate-mediation request
   - Secondary accepts
   - Receive new routing inbox
   - Update wallet configuration
   - Update DID documents (service endpoints)
     - For all DIDs using mediator
     - Update to secondary URL
   - Notify connections (connection update message)
   - Failover complete

4. **Message Synchronization** (10 steps)
   - Query secondary for queued messages
   - Secondary retrieves from shared storage
   - Messages preserved (using message queue)
   - Download all pending messages
   - Process messages (batch-pickup)
   - Decrypt messages
   - Route to protocol handlers
   - Send acknowledgments
   - Mark messages as delivered
   - Sync complete

5. **Primary Recovery Detection** (8 steps)
   - Background task monitors primary
   - Primary comes back online
   - Detect primary available
   - Test primary health
   - Primary fully recovered
   - Optionally fail-back to primary
     - Or stay on secondary (if stable)
   - Update configuration
   - Log failover event

6. **Message Routing During Failover** (6 steps)
   - Incoming message to primary (old endpoint)
   - Primary down, message lost?
   - No - using load balancer
   - Load balancer routes to healthy mediator
   - Message delivered to secondary
   - Wallet receives via secondary

**Total Steps**: ~48 interactions
**HA Features**:
- Multiple mediator support
- Automatic failover
- Message queue preservation
- Load balancer routing
- Zero message loss

---

# 📊 SUMMARY & STATISTICS

## Diagram Count by Group

| Group | Count | Status |
|-------|-------|--------|
| Credential Issuance | 3 | Pending |
| Proof Presentation | 2 | Pending |
| Connection Establishment | 2 | Pending |
| Key Management | 2 | Pending |
| Backup & Restore | 2 | Pending |
| Enterprise Integration | 3 | Pending |
| Error Handling | 3 | Pending |
| **TOTAL** | **17** | **0/17** |

## Complexity Metrics

| Diagram | Participants | Steps | Complexity |
|---------|--------------|-------|------------|
| SD-01 | 8 | ~36 | High |
| SD-02 | 9 | ~45 | High |
| SD-03 | 10 | ~40 | High |
| SD-04 | 8 | ~44 | Very High |
| SD-05 | 10 | ~46 | Very High |
| SD-06 | 9 | ~57 | Very High |
| SD-07 | 10 | ~10+ | Medium |
| SD-08 | 9 | ~46 | High |
| SD-09 | 7 | ~50 | High |
| SD-10 | 9 | ~45 | High |
| SD-11 | 9 | ~72 | Very High |
| SD-12 | 8 | ~53 | Very High |
| SD-13 | 7 | ~36 | Medium |
| SD-14 | 7 | ~38 | High |
| SD-15 | 7 | ~37 | Medium |
| SD-16 | 7 | ~34 | Medium |
| SD-17 | 7 | ~48 | High |

**Average Steps per Diagram**: ~42 steps  
**Total Interaction Steps**: ~717 detailed interactions

## Protocol Coverage

### Standards & Protocols Explained:
- ✅ OpenID4VCI (Pre-Auth & Auth Code)
- ✅ OpenID4VP (Direct Post)
- ✅ SIOPv2
- ✅ DIDComm v2 (Connection, Issue, Present Proof)
- ✅ Presentation Exchange v2
- ✅ Aries RFC 0160 (Connection)
- ✅ Aries RFC 0434 (Out-of-Band)
- ✅ Aries RFC 0453 (Issue Credential)
- ✅ Aries RFC 0454 (Present Proof)
- ✅ W3C Verifiable Credentials (JWT, JSON-LD, SD-JWT)
- ✅ AnonCreds with ZKP
- ✅ Status List 2021 (Revocation)
- ✅ BIP32/39/44 (HD Wallet)
- ✅ DID Methods (did:key, did:web, did:ion, did:ethr, did:peer, did:ebsi)
- ✅ EBSI/EUDI Wallet compliance

## Format Support

### Credential Formats:
- JWT-VC (JSON Web Token)
- JSON-LD VC (Linked Data Proofs)
- SD-JWT (Selective Disclosure JWT)
- AnonCreds (ZKP credentials)

### Signature Types:
- EdDSA (Ed25519)
- ES256K (Secp256k1)
- ES256 (Secp256r1)
- BbsBlsSignature2020 (selective disclosure)

### Encryption:
- JWE (ECDH-ES+A256KW)
- Authcrypt (DIDComm)
- Anoncrypt (DIDComm)
- AES-256-GCM

---

# 🎯 IMPLEMENTATION PRIORITY

## Phase 1: Core Flows (Must-Have)
1. **SD-01**: OpenID4VCI Pre-Auth (most common)
2. **SD-04**: OpenID4VP Direct Post (most common)
3. **SD-08**: Wallet Initialization (foundational)
4. **SD-10**: Backup (critical for users)
5. **SD-11**: Restore (critical for users)

## Phase 2: DIDComm Flows (P2P)
6. **SD-06**: DIDComm Connection
7. **SD-03**: DIDComm Credential Issuance
8. **SD-05**: DIDComm Present Proof

## Phase 3: Advanced Features
9. **SD-02**: OID4VCI Auth Code (less common, but needed)
10. **SD-07**: Out-of-Band Invitation
11. **SD-09**: Multi-Method DID Creation
12. **SD-16**: Revocation Detection

## Phase 4: Enterprise Integration
13. **SD-12**: Microsoft Entra
14. **SD-14**: EBSI/EUDI
15. **SD-13**: VDX Platform

## Phase 5: Reliability
16. **SD-15**: Network Error Handling
17. **SD-17**: Mediator Failover

---

# 📝 DIAGRAM STANDARDS & CONVENTIONS

## PlantUML Sequence Diagram Format

```plantuml
@startuml
!theme c4_sequence from https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/themes

title Sequence Diagram Title

actor User
participant "Wallet UI" as Wallet
participant "Service" as Service
database "Database" as DB

User -> Wallet: action
activate Wallet
Wallet -> Service: request
activate Service
Service -> DB: query
activate DB
DB --> Service: result
deactivate DB
Service --> Wallet: response
deactivate Service
Wallet --> User: display
deactivate Wallet

note right of Service
  Important notes
  and explanations
end note

@enduml
```

## Standard Elements

### Participants
- `actor` - User/Human
- `participant` - Application/Service
- `database` - Data Store
- `boundary` - External System
- `control` - Controller/Manager

### Messages
- `->` - Synchronous call
- `-->` - Return/Response
- `->>` - Asynchronous message
- `-->>` - Async response

### Activation
- `activate` / `deactivate` - Show active processing

### Grouping
- `group` - Logical grouping of steps
- `alt` / `else` - Alternative flows
- `opt` - Optional flow
- `loop` - Repeated steps
- `par` - Parallel execution

### Notes
- `note left/right/over` - Add explanations
- Include technical details in notes

---

# ✅ COMPLETION CRITERIA

Setiap sequence diagram dianggap complete jika:

1. **All participants listed** - Tidak ada actor yang missing
2. **All steps detailed** - Setiap interaksi explained
3. **All messages labeled** - Tahu apa yang dikirim
4. **Technical details included** - Protocol, format, parameters
5. **Error paths shown** - Happy path + error scenarios
6. **Notes explain WHY** - Bukan hanya WHAT
7. **Validation logic shown** - Checks and balances
8. **Security highlights** - Encryption, signing, auth
9. **Data structures referenced** - Know what's being passed
10. **Links to component diagrams** - Cross-reference

---

# 🚀 NEXT STEPS

1. **Review this plan** - Pastikan semua flow tercakup
2. **Prioritize diagrams** - Mana yang paling penting dulu
3. **Start creating** - Buat sequence diagram satu per satu
4. **Validate against implementation** - Sesuai dengan code
5. **Iterate** - Refine berdasarkan feedback

---

# 📌 NOTES

- Sequence diagram ini **melengkapi** component diagram yang sudah ada
- Focus on **runtime behavior** dan **protocol interactions**
- Sangat detail - setiap step dijelaskan
- Cover **happy path** dan **error scenarios**
- Dapat dijadikan **implementation guide** untuk developer
- Dapat dijadikan **documentation** untuk user/auditor

---

**Sequence diagrams ini akan menjadi panduan LENGKAP untuk memahami BAGAIMANA Sphereon Wallet bekerja di production.**

Apakah plan ini sudah sesuai? Apakah ada flow yang perlu ditambahkan atau diubah?
