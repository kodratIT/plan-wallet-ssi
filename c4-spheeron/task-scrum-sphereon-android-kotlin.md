# Sphereon Mobile Wallet - Android Kotlin Native Implementation
## Scrum Project Management

## 📋 Project Overview

**Project Name**: Sphereon SSI Wallet - Native Android (Kotlin)  
**Duration**: 40-44 Weeks (10-11 Sprints @ 4 weeks/sprint)  
**Team Size**: 6-8 Android developers  
**Methodology**: Scrum with 4-week sprints  
**Platform**: Android (Kotlin only)  
**Target Version**: 1.0.0  
**Min SDK**: 26 (Android 8.0)  
**Target SDK**: 34 (Android 14)

---

## 🎯 Product Vision

Membangun native Android SSI wallet yang high-performance, secure, dan production-ready dengan manual Aries protocol implementation, full Jetpack integration, dan modern Android architecture untuk Self-Sovereign Identity management.

---

## 🔄 Architecture Overview

### Technology Stack

#### **Core Android Stack**
- **Language**: Kotlin 1.9+
- **Build System**: Gradle with Kotlin DSL
- **Min SDK**: 26 (Android 8.0 Oreo)
- **Target SDK**: 34 (Android 14)
- **Architecture**: Clean Architecture + MVVM + MVI patterns

#### **Jetpack Components**
- **UI**: Jetpack Compose (Material 3)
- **Navigation**: Navigation Compose
- **ViewModel**: Lifecycle ViewModel + StateFlow
- **Database**: Room + SQLCipher for encryption
- **DataStore**: Preferences DataStore + Proto DataStore
- **WorkManager**: Background tasks
- **Paging 3**: Large data sets
- **Security**: Security Crypto
- **Biometric**: BiometricPrompt

#### **Dependency Injection**
- **Hilt**: Primary DI framework
- **Dagger**: Core DI

#### **Async & Reactive**
- **Coroutines**: Kotlin Coroutines
- **Flow**: StateFlow, SharedFlow, Flow
- **LiveData**: Legacy support only

#### **Network & Communication**
- **Retrofit**: REST API calls
- **OkHttp**: HTTP client
- **WebSocket**: OkHttp WebSocket
- **gRPC**: For high-performance communication (optional)

#### **SSI & Blockchain Libraries**
- **Indy SDK**: Native bindings (JNI)
- **Aries Askar**: Secure storage (via JNI)
- **AnonCreds**: Credential handling (via JNI)
- **DIDComm**: Manual implementation
- **did-resolver**: Manual implementation with caching

#### **Security & Encryption**
- **Android Keystore**: Hardware-backed keys
- **Tink**: Crypto library from Google
- **Conscrypt**: Modern crypto provider
- **SQLCipher**: Database encryption
- **ProGuard/R8**: Code obfuscation

#### **Testing**
- **JUnit 5**: Unit testing
- **Mockk**: Mocking framework
- **Turbine**: Flow testing
- **Espresso**: UI testing
- **Compose UI Test**: Composable testing
- **Robolectric**: Android unit testing

#### **Code Quality**
- **Detekt**: Static code analysis
- **ktlint**: Code formatting
- **Android Lint**: Android-specific linting
- **SonarQube**: Code quality platform

#### **Other Libraries**
- **Coil**: Image loading for Compose
- **Timber**: Logging
- **LeakCanary**: Memory leak detection
- **Stetho**: Debug bridge (debug only)

---

## 👥 Team Composition

### Scrum Roles
- **Product Owner**: 1 person (Sphereon representative)
- **Scrum Master**: 1 person
- **Development Team**: 6-8 members
  - **Lead Android Architect**: 1 person
    - Architecture decisions
    - Code reviews
    - Technical leadership
  - **Senior Android Developers**: 2 people
    - UI implementation (Jetpack Compose)
    - Business logic
    - Integration
  - **SSI/Blockchain Specialist (Android)**: 1 person
    - Indy SDK integration (JNI)
    - Aries protocol implementation
    - Cryptography
  - **Android Security Engineer**: 1 person
    - Security implementation
    - Encryption
    - Penetration testing
  - **QA Engineer (Android)**: 1 person
    - Test strategy
    - Automated testing
    - Quality assurance
  - **Backend Integration Engineer**: 1 person (part-time)
    - API integration
    - External service integration
  - **DevOps Engineer**: 1 person (part-time)
    - CI/CD
    - Build automation
    - Release management

---

## 📊 Product Backlog - Epics

### Epic 1: Project Foundation & Architecture
**Business Value**: CRITICAL | **Priority**: 1 | **Estimated**: 110 SP

Setup Android project dengan Clean Architecture, Hilt DI, dan foundational components.

### Epic 2: Indy SDK & Aries Core Integration
**Business Value**: CRITICAL | **Priority**: 2 | **Estimated**: 140 SP

Native JNI integration untuk Indy SDK, Aries Askar, dan AnonCreds.

### Epic 3: DIDComm Protocol Implementation
**Business Value**: CRITICAL | **Priority**: 3 | **Estimated**: 130 SP

Manual implementation DIDComm v1/v2 messaging protocol.

### Epic 4: Aries Connection Protocol
**Business Value**: CRITICAL | **Priority**: 4 | **Estimated**: 100 SP

Connection invitation, request, response, dan state management.

### Epic 5: Aries Credential Protocol
**Business Value**: CRITICAL | **Priority**: 5 | **Estimated**: 120 SP

Credential offer, request, issuance, dan storage dengan AnonCreds.

### Epic 6: Aries Proof Protocol
**Business Value**: CRITICAL | **Priority**: 6 | **Estimated**: 120 SP

Proof request, generation (ZKP), dan presentation.

### Epic 7: UI/UX Implementation (Jetpack Compose)
**Business Value**: HIGH | **Priority**: 7 | **Estimated**: 140 SP

Complete UI dengan Material 3 Design dan Jetpack Compose.

### Epic 8: Advanced Features (OID4VCI/VP, SD-JWT)
**Business Value**: HIGH | **Priority**: 8 | **Estimated**: 100 SP

OpenID4VCI, OpenID4VP, SD-JWT, BBS+ signatures.

### Epic 9: Enterprise Integrations
**Business Value**: MEDIUM | **Priority**: 9 | **Estimated**: 80 SP

Microsoft Entra, VDX Platform, EBSI integration.

### Epic 10: Security & Encryption
**Business Value**: CRITICAL | **Priority**: 10 | **Estimated**: 90 SP

Advanced security, encryption, biometric binding.

### Epic 11: Performance & Optimization
**Business Value**: HIGH | **Priority**: 11 | **Estimated**: 70 SP

Performance tuning, memory optimization, battery optimization.

### Epic 12: Testing & Quality Assurance
**Business Value**: CRITICAL | **Priority**: 12 | **Estimated**: 100 SP

Comprehensive testing strategy dan quality assurance.

### Epic 13: Production Deployment
**Business Value**: CRITICAL | **Priority**: 13 | **Estimated**: 50 SP

Google Play release dan production monitoring.

**Total Estimated Story Points**: 1,350 SP

---

## 🏃 Sprint Planning

### Sprint Structure
- **Sprint Duration**: 4 weeks
- **Sprint Planning**: 4 hours
- **Daily Standup**: 15 minutes daily
- **Sprint Review**: 2.5 hours
- **Sprint Retrospective**: 2 hours
- **Backlog Refinement**: 2 hours weekly
- **Architecture Review**: 2 hours weekly (first 6 sprints)

### Velocity Estimation
- **Team Capacity**: ~120-135 SP per sprint (6-8 developers × 4 weeks)
- **Expected Sprints**: 10-11 sprints
- **Development Strategy**: Iterative with continuous integration

---

## 📅 Sprint 0: Project Setup & Architecture (Week 0)

### Goals
- Setup Android project dengan modern architecture
- Configure build system dengan Gradle Kotlin DSL
- Setup CI/CD pipeline
- Define package structure
- Setup code quality tools

### Activities
- [ ] Create Android project (Android Studio)
- [ ] Configure Gradle with Kotlin DSL
- [ ] Setup multi-module architecture
- [ ] Configure Hilt dependency injection
- [ ] Setup Room database with SQLCipher
- [ ] Configure Retrofit + OkHttp
- [ ] Setup Jetpack Compose
- [ ] Configure Detekt, ktlint
- [ ] Setup GitHub Actions CI/CD
- [ ] Define coding standards
- [ ] Create base classes (BaseViewModel, BaseUseCase, etc.)
- [ ] Sprint 1 planning

**Duration**: 1 week  
**Deliverable**: Android project foundation ready

---

## 🚀 Sprint 1: Foundation & Indy SDK Integration

### Sprint Goal
*"Establish Android project foundation and integrate Indy SDK via JNI."*

**Duration**: 4 weeks  
**Capacity**: 130 Story Points  
**Sprint Dates**: Week 1-4

---

### 📖 User Stories

#### US-1.1: Multi-Module Project Structure
**As a** developer  
**I want** modular project structure  
**So that** code is organized and scalable

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Lead Android Architect

##### Acceptance Criteria
- [x] Multi-module Gradle project
- [x] Feature modules defined
- [x] Core module created
- [x] Data module created
- [x] Domain module created
- [x] Presentation (UI) module created

##### Modules Structure
```
:app (main application module)
:core
  :common (utilities, extensions)
  :network (networking layer)
  :database (Room + SQLCipher)
  :security (encryption, keystore)
  :logging (Timber setup)
:domain
  :models (data classes, entities)
  :repository (repository interfaces)
  :usecase (business logic)
:data
  :repository-impl (repository implementations)
  :local (local data sources)
  :remote (remote data sources)
:feature
  :onboarding
  :credentials
  :connections
  :proofs
  :settings
:ssi
  :indy (Indy SDK wrapper)
  :aries (Aries protocol implementations)
  :didcomm (DIDComm messaging)
  :wallet (Wallet management)
```

##### Tasks
- [ ] Create module structure (4h)
- [ ] Configure Gradle dependencies (3h)
- [ ] Setup inter-module dependencies (3h)
- [ ] Create base packages (2h)
- [ ] Document module architecture (2h)

---

#### US-1.2: Hilt Dependency Injection Setup
**As a** developer  
**I want** Hilt DI configured  
**So that** dependencies are managed properly

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Lead Android Architect

##### Acceptance Criteria
- [x] Hilt library integrated
- [x] Application class with @HiltAndroidApp
- [x] Component hierarchy defined
- [x] Modules created (NetworkModule, DatabaseModule, etc.)
- [x] ViewModels with @HiltViewModel

##### Tasks
- [ ] Add Hilt dependencies (2h)
- [ ] Create Application class (1h)
- [ ] Create Hilt modules (4h)
- [ ] Setup ViewModel injection (3h)
- [ ] Write documentation (2h)
- [ ] Write tests (3h)

---

#### US-1.3: Room Database with SQLCipher
**As a** developer  
**I want** encrypted database  
**So that** data is secure at rest

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] Room database configured
- [x] SQLCipher integration working
- [x] Database entities defined (Credential, Connection, etc.)
- [x] DAOs created
- [x] Type converters for complex types
- [x] Migrations strategy defined

##### Database Schema
```kotlin
@Entity(tableName = "credentials")
data class CredentialEntity(
    @PrimaryKey val id: String,
    val type: String,
    val issuer: String,
    val issuanceDate: Long,
    val expirationDate: Long?,
    val credentialJson: String, // encrypted
    val schemaId: String,
    val credDefId: String,
    val revRegId: String?,
    val status: CredentialStatus,
    val metadataJson: String?
)

@Entity(tableName = "connections")
data class ConnectionEntity(
    @PrimaryKey val id: String,
    val theirLabel: String,
    val theirDid: String,
    val myDid: String,
    val state: ConnectionState,
    val invitationJson: String?,
    val createdAt: Long,
    val updatedAt: Long
)

// More entities...
```

##### Tasks
- [ ] Add Room + SQLCipher dependencies (2h)
- [ ] Define database entities (6h)
- [ ] Create DAOs (5h)
- [ ] Create Database class (3h)
- [ ] Implement type converters (4h)
- [ ] Setup migrations (3h)
- [ ] Write database tests (6h)
- [ ] Document database schema (3h)

---

#### US-1.4: Jetpack Compose Material 3 Setup
**As a** developer  
**I want** Compose UI configured  
**So that** I can build modern UI

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Jetpack Compose dependencies added
- [x] Material 3 theme created
- [x] Color scheme defined (light/dark)
- [x] Typography system defined
- [x] Shape system defined
- [x] Theme switcher working

##### Tasks
- [ ] Add Compose dependencies (2h)
- [ ] Create Material 3 theme (5h)
- [ ] Define color palette (3h)
- [ ] Define typography (2h)
- [ ] Create theme components (4h)
- [ ] Implement theme switching (3h)
- [ ] Write Compose tests (3h)

---

#### US-1.5: Navigation Compose Setup
**As a** developer  
**I want** navigation configured  
**So that** screen navigation works

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Navigation Compose integrated
- [x] Navigation graph defined
- [x] Type-safe navigation arguments
- [x] Deep linking configured
- [x] Bottom navigation implemented

##### Tasks
- [ ] Add Navigation Compose (2h)
- [ ] Create navigation graph (4h)
- [ ] Define routes with arguments (3h)
- [ ] Setup deep linking (3h)
- [ ] Create bottom nav (3h)
- [ ] Write navigation tests (3h)

---

#### US-1.6: Indy SDK Native Library Integration (JNI)
**As a** developer  
**I want** Indy SDK integrated  
**So that** blockchain features work

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Indy SDK .so files added to project
- [x] JNI wrapper created
- [x] Wallet operations working (create, open, close)
- [x] DID operations working (create, store)
- [x] Ledger operations working (get schema, cred def)
- [x] Error handling for native calls

##### Native Library Structure
```
app/src/main/jniLibs/
  arm64-v8a/
    libindy.so
  armeabi-v7a/
    libindy.so
  x86/
    libindy.so
  x86_64/
    libindy.so
```

##### Kotlin Wrapper Example
```kotlin
class IndyWrapper {
    external fun createWallet(config: String, credentials: String): Int
    external fun openWallet(config: String, credentials: String): Int
    external fun closeWallet(walletHandle: Int): Int
    
    companion object {
        init {
            System.loadLibrary("indy")
        }
    }
}
```

##### Tasks
- [ ] Research Indy SDK for Android (4h)
- [ ] Download/compile Indy SDK .so files (6h)
- [ ] Add native libraries to project (2h)
- [ ] Create JNI wrapper classes (10h)
- [ ] Implement wallet operations (8h)
- [ ] Implement DID operations (8h)
- [ ] Implement ledger operations (8h)
- [ ] Add error handling (4h)
- [ ] Write integration tests (8h)
- [ ] Document JNI usage (4h)

---

#### US-1.7: Aries Askar Integration (Secure Storage)
**As a** developer  
**I want** Aries Askar for storage  
**So that** wallet data is encrypted properly

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: Android Security Engineer + SSI Specialist

##### Acceptance Criteria
- [x] Aries Askar library integrated
- [x] Store creation working
- [x] Key management working
- [x] CRUD operations working
- [x] Encryption/decryption working
- [x] Session management working

##### Tasks
- [ ] Research Aries Askar for Android (4h)
- [ ] Add Askar native libraries (3h)
- [ ] Create JNI wrapper (10h)
- [ ] Implement store management (8h)
- [ ] Implement key operations (8h)
- [ ] Implement CRUD operations (8h)
- [ ] Add session management (5h)
- [ ] Write integration tests (8h)
- [ ] Document Askar usage (4h)

---

#### US-1.8: AnonCreds Library Integration
**As a** developer  
**I want** AnonCreds library  
**So that** credential operations work

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] AnonCreds library integrated
- [x] Schema operations working
- [x] Credential definition operations working
- [x] Credential issuance working
- [x] Proof generation working (ZKP)
- [x] Proof verification working

##### Tasks
- [ ] Add AnonCreds native libraries (3h)
- [ ] Create JNI wrapper (10h)
- [ ] Implement schema operations (6h)
- [ ] Implement cred def operations (6h)
- [ ] Implement credential operations (10h)
- [ ] Implement proof operations (10h)
- [ ] Write integration tests (10h)
- [ ] Document AnonCreds usage (4h)

---

#### US-1.9: Secure SharedPreferences (EncryptedSharedPreferences)
**As a** developer  
**I want** encrypted preferences  
**So that** settings are secure

**Story Points**: 5  
**Priority**: Must Have  
**Assignee**: Android Security Engineer

##### Acceptance Criteria
- [x] EncryptedSharedPreferences setup
- [x] Master key in Android Keystore
- [x] Preferences wrapper created
- [x] Type-safe access

##### Tasks
- [ ] Setup EncryptedSharedPreferences (3h)
- [ ] Create master key (2h)
- [ ] Create preferences wrapper (4h)
- [ ] Write tests (3h)

---

#### US-1.10: Android Keystore Integration
**As a** developer  
**I want** Android Keystore  
**So that** keys are hardware-backed

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Android Security Engineer

##### Acceptance Criteria
- [x] Keystore wrapper created
- [x] Key generation working
- [x] Encryption/decryption working
- [x] Biometric key creation
- [x] Key attestation (optional)

##### Tasks
- [ ] Study Android Keystore API (3h)
- [ ] Create Keystore wrapper (6h)
- [ ] Implement key generation (5h)
- [ ] Implement encryption/decryption (6h)
- [ ] Add biometric key support (5h)
- [ ] Write tests (5h)
- [ ] Document usage (3h)

---

#### US-1.11: Logging Framework (Timber)
**As a** developer  
**I want** logging framework  
**So that** debugging is easier

**Story Points**: 3  
**Priority**: Should Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Timber configured
- [x] Debug tree for debug builds
- [x] Release tree (no logging or crash reporting)
- [x] Log levels properly used

##### Tasks
- [ ] Add Timber dependency (1h)
- [ ] Configure debug tree (2h)
- [ ] Configure release tree (2h)
- [ ] Document logging standards (2h)

---

#### US-1.12: CI/CD Pipeline (GitHub Actions)
**As a** team  
**I want** CI/CD pipeline  
**So that** builds are automated

**Story Points**: 13  
**Priority**: Should Have  
**Assignee**: DevOps Engineer

##### Acceptance Criteria
- [x] GitHub Actions workflow created
- [x] Lint runs on PR
- [x] Unit tests run on PR
- [x] Detekt runs on PR
- [x] APK build succeeds
- [x] Artifacts uploaded

##### Tasks
- [ ] Create workflow file (3h)
- [ ] Setup lint job (2h)
- [ ] Setup test job (3h)
- [ ] Setup Detekt job (2h)
- [ ] Setup build job (4h)
- [ ] Configure caching (3h)
- [ ] Setup artifacts upload (2h)

---

### Sprint 1 Summary

**Total Story Points**: 148 SP  
**Planned Capacity**: 130 SP (Adjusted for setup complexity)  
**Sprint Goal**: ✅ Android foundation and SSI libraries integrated

**Key Deliverables**:
- ✅ Multi-module Android project with Clean Architecture
- ✅ Hilt dependency injection configured
- ✅ Room database with SQLCipher
- ✅ Jetpack Compose with Material 3
- ✅ Indy SDK integrated via JNI
- ✅ Aries Askar integrated
- ✅ AnonCreds integrated
- ✅ Android Keystore wrapper
- ✅ CI/CD pipeline functional

---

## 🚀 Sprint 2: DIDComm Foundation & Encryption

### Sprint Goal
*"Implement DIDComm message structure, encryption/decryption, and transport layer."*

**Duration**: 4 weeks  
**Capacity**: 130 Story Points  
**Sprint Dates**: Week 5-8

---

### 📖 User Stories

#### US-2.1: DIDComm Message Models
**As a** developer  
**I want** DIDComm message data models  
**So that** messages are properly structured

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: SSI Specialist

##### Acceptance Criteria
- [x] DIDComm v1 message model
- [x] DIDComm v2 message model
- [x] Message type registry
- [x] Thread management model
- [x] Attachment model

##### Tasks
- [ ] Study DIDComm specifications (4h)
- [ ] Create message data classes (6h)
- [ ] Create type registry (3h)
- [ ] Implement thread model (3h)
- [ ] Create attachment model (3h)
- [ ] Write tests (4h)

---

#### US-2.2: DID Resolution Service
**As a** developer  
**I want** DID resolver  
**So that** DIDs can be resolved to DID Documents

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Universal resolver integration
- [x] did:key resolver
- [x] did:web resolver
- [x] did:ion resolver
- [x] did:jwk resolver
- [x] Resolution caching
- [x] Error handling

##### Implementation
```kotlin
interface DidResolver {
    suspend fun resolve(did: String): Result<DidDocument>
}

class UniversalDidResolver @Inject constructor(
    private val httpClient: OkHttpClient,
    private val cache: DidResolutionCache
) : DidResolver {
    override suspend fun resolve(did: String): Result<DidDocument> {
        // Check cache first
        cache.get(did)?.let { return Result.success(it) }
        
        // Resolve based on did method
        return when {
            did.startsWith("did:key:") -> resolveDidKey(did)
            did.startsWith("did:web:") -> resolveDidWeb(did)
            did.startsWith("did:ion:") -> resolveDidIon(did)
            else -> resolveUniversal(did)
        }
    }
}
```

##### Tasks
- [ ] Create DID resolution interfaces (3h)
- [ ] Implement did:key resolver (5h)
- [ ] Implement did:web resolver (5h)
- [ ] Implement did:ion resolver (6h)
- [ ] Implement did:jwk resolver (4h)
- [ ] Add caching layer (4h)
- [ ] Write integration tests (6h)
- [ ] Document resolvers (3h)

---

#### US-2.3: DIDComm Encryption (JWE)
**As a** developer  
**I want** message encryption  
**So that** communications are secure

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: Android Security Engineer + SSI Specialist

##### Acceptance Criteria
- [x] JWE encryption implemented
- [x] Authcrypt (authenticated encryption)
- [x] Anoncrypt (anonymous encryption)
- [x] Key agreement (X25519)
- [x] Message packing/unpacking
- [x] Support multiple recipients

##### Encryption Algorithms
```kotlin
class DIDCommEncryption @Inject constructor(
    private val keyManager: KeyManager
) {
    // Authcrypt: sender authentication + encryption
    suspend fun authcrypt(
        message: String,
        recipientDids: List<String>,
        senderDid: String
    ): Result<String>
    
    // Anoncrypt: encryption only (no sender auth)
    suspend fun anoncrypt(
        message: String,
        recipientDids: List<String>
    ): Result<String>
    
    // Unpack: decrypt and verify
    suspend fun unpack(
        packedMessage: String
    ): Result<UnpackedMessage>
}
```

##### Tasks
- [ ] Study JWE specification (4h)
- [ ] Implement X25519 key agreement (8h)
- [ ] Implement authcrypt (10h)
- [ ] Implement anoncrypt (8h)
- [ ] Implement pack/unpack (8h)
- [ ] Support multiple recipients (6h)
- [ ] Write encryption tests (8h)
- [ ] Document encryption (4h)

---

#### US-2.4: HTTP/HTTPS Transport Layer
**As a** developer  
**I want** HTTP transport  
**So that** messages can be sent/received

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] Retrofit service created
- [x] HTTP POST for sending messages
- [x] HTTP GET for retrieving messages
- [x] SSL certificate pinning
- [x] Connection timeout handling
- [x] Retry logic

##### Tasks
- [ ] Create Retrofit service interface (3h)
- [ ] Implement HTTP POST (4h)
- [ ] Implement HTTP GET (3h)
- [ ] Add SSL pinning (4h)
- [ ] Implement retry logic (4h)
- [ ] Write integration tests (6h)
- [ ] Document transport layer (3h)

---

#### US-2.5: WebSocket Transport Layer
**As a** developer  
**I want** WebSocket transport  
**So that** real-time messaging works

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] OkHttp WebSocket client
- [x] Connection management
- [x] Message sending via WS
- [x] Message receiving via WS
- [x] Reconnection logic
- [x] Heartbeat/ping-pong

##### Tasks
- [ ] Setup OkHttp WebSocket (3h)
- [ ] Implement connection manager (6h)
- [ ] Implement send/receive (5h)
- [ ] Add reconnection logic (5h)
- [ ] Implement heartbeat (4h)
- [ ] Write integration tests (6h)
- [ ] Document WebSocket usage (3h)

---

#### US-2.6: Mediator Client Implementation
**As a** user  
**I want** mediator support  
**So that** I receive messages when offline

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Mediator coordination protocol
- [x] Routing key registration
- [x] Message pickup protocol
- [x] Batch message retrieval
- [x] Live delivery mode
- [x] Multiple mediator support

##### Mediator Protocol
```kotlin
class MediatorClient @Inject constructor(
    private val transport: DIDCommTransport,
    private val encryption: DIDCommEncryption
) {
    // Coordinate with mediator
    suspend fun coordinate(
        mediatorDid: String,
        routingKeys: List<String>
    ): Result<Unit>
    
    // Pickup messages
    suspend fun pickupMessages(
        batchSize: Int = 10
    ): Result<List<DIDCommMessage>>
    
    // Enable live delivery
    suspend fun enableLiveDelivery(): Result<Unit>
}
```

##### Tasks
- [ ] Study mediator protocol spec (4h)
- [ ] Implement coordination (8h)
- [ ] Implement routing registration (6h)
- [ ] Implement message pickup (8h)
- [ ] Implement batch retrieval (6h)
- [ ] Add live delivery (6h)
- [ ] Write integration tests (8h)
- [ ] Document mediator usage (4h)

---

#### US-2.7: Message Dispatcher/Router
**As a** developer  
**I want** message routing  
**So that** incoming messages go to right handlers

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Message type detection
- [x] Handler registration system
- [x] Message dispatching
- [x] Protocol-specific routing
- [x] Error handling

##### Message Router
```kotlin
interface MessageHandler {
    val supportedTypes: List<String>
    suspend fun handle(message: DIDCommMessage): Result<Unit>
}

class MessageDispatcher @Inject constructor() {
    private val handlers = mutableMapOf<String, MessageHandler>()
    
    fun registerHandler(handler: MessageHandler) {
        handler.supportedTypes.forEach { type ->
            handlers[type] = handler
        }
    }
    
    suspend fun dispatch(message: DIDCommMessage): Result<Unit> {
        val handler = handlers[message.type]
            ?: return Result.failure(UnknownMessageTypeException())
        return handler.handle(message)
    }
}
```

##### Tasks
- [ ] Create dispatcher interface (3h)
- [ ] Implement handler registry (5h)
- [ ] Implement type detection (4h)
- [ ] Implement routing logic (6h)
- [ ] Add error handling (4h)
- [ ] Write unit tests (5h)
- [ ] Document dispatcher (3h)

---

#### US-2.8: DIDComm Storage Repository
**As a** developer  
**I want** message storage  
**So that** messages are persisted

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] Message entity in Room
- [x] Message DAO
- [x] Storage operations (save, retrieve, delete)
- [x] Query by thread ID
- [x] Pagination support

##### Tasks
- [ ] Create message entity (3h)
- [ ] Create message DAO (4h)
- [ ] Implement repository (5h)
- [ ] Add pagination (3h)
- [ ] Write tests (4h)

---

#### US-2.9: DIDComm Protocol State Machine
**As a** developer  
**I want** protocol state management  
**So that** protocol flows are tracked

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist

##### Acceptance Criteria
- [x] State machine framework
- [x] State transitions defined
- [x] State persistence
- [x] Event handling
- [x] Timeout handling

##### Tasks
- [ ] Design state machine (5h)
- [ ] Implement state transitions (8h)
- [ ] Add state persistence (5h)
- [ ] Implement event handling (5h)
- [ ] Add timeout handling (4h)
- [ ] Write tests (6h)

---

#### US-2.10: Message Queue for Outbound Messages
**As a** developer  
**I want** outbound message queue  
**So that** messages are reliably sent

**Story Points**: 8  
**Priority**: Should Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Queue implementation with WorkManager
- [x] Retry logic with exponential backoff
- [x] Failed message handling
- [x] Queue persistence
- [x] Manual retry option

##### Tasks
- [ ] Implement queue with WorkManager (6h)
- [ ] Add retry logic (5h)
- [ ] Implement backoff (3h)
- [ ] Add persistence (4h)
- [ ] Write tests (4h)

---

### Sprint 2 Summary

**Total Story Points**: 131 SP  
**Planned Capacity**: 130 SP  
**Sprint Goal**: ✅ DIDComm foundation complete

**Key Deliverables**:
- ✅ DIDComm message models
- ✅ DID resolution service
- ✅ JWE encryption/decryption (authcrypt/anoncrypt)
- ✅ HTTP/WebSocket transport layers
- ✅ Mediator client implementation
- ✅ Message dispatcher/router
- ✅ Message storage
- ✅ Outbound message queue

---

## 🚀 Sprint 3: Aries Connection Protocol

### Sprint Goal
*"Implement complete Aries connection protocol with invitation, request, response flows."*

**Duration**: 4 weeks  
**Capacity**: 130 Story Points  
**Sprint Dates**: Week 9-12

---

### 📖 User Stories

#### US-3.1: Connection State Machine
**As a** developer  
**I want** connection state machine  
**So that** connection lifecycle is managed

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist

##### Acceptance Criteria
- [x] State definitions (Invited, Requested, Responded, Complete)
- [x] State transitions
- [x] State persistence in database
- [x] Event handling
- [x] Error states

##### Connection States
```kotlin
enum class ConnectionState {
    INVITED,
    REQUESTED,
    RESPONDED,
    COMPLETED,
    ERROR
}

sealed class ConnectionEvent {
    data class InvitationReceived(val invitation: ConnectionInvitation) : ConnectionEvent()
    data class RequestSent(val request: ConnectionRequest) : ConnectionEvent()
    data class ResponseReceived(val response: ConnectionResponse) : ConnectionEvent()
    object Completed : ConnectionEvent()
    data class Error(val error: Throwable) : ConnectionEvent()
}
```

##### Tasks
- [ ] Define connection states (3h)
- [ ] Implement state machine (8h)
- [ ] Add state persistence (5h)
- [ ] Implement event handling (5h)
- [ ] Write tests (6h)
- [ ] Document state machine (3h)

---

#### US-3.2: Connection Invitation Handling
**As a** user  
**I want** to receive connection invitations  
**So that** I can connect with issuers/verifiers

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Parse invitation from URL/QR
- [x] Parse inline invitation (base64)
- [x] Parse OOB (Out-of-Band) invitation
- [x] Validate invitation
- [x] Store invitation
- [x] Display invitation details to user

##### Invitation Format
```kotlin
@Serializable
data class ConnectionInvitation(
    @SerialName("@id") val id: String,
    @SerialName("@type") val type: String,
    val label: String,
    val recipientKeys: List<String>,
    val serviceEndpoint: String,
    val routingKeys: List<String>? = null,
    val imageUrl: String? = null
)
```

##### Tasks
- [ ] Create invitation parser (6h)
- [ ] Implement URL parsing (4h)
- [ ] Implement base64 decoding (3h)
- [ ] Add OOB support (5h)
- [ ] Implement validation (4h)
- [ ] Store invitation in DB (3h)
- [ ] Write tests (6h)
- [ ] Document invitation handling (3h)

---

#### US-3.3: Connection Request Generation
**As a** user  
**I want** to send connection request  
**So that** connection is established

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 2

##### Acceptance Criteria
- [x] Generate ephemeral DID
- [x] Create connection request message
- [x] Pack request with encryption
- [x] Send request to service endpoint
- [x] Update connection state
- [x] Store request details

##### Connection Request
```kotlin
@Serializable
data class ConnectionRequest(
    @SerialName("@id") val id: String,
    @SerialName("@type") val type: String = "https://didcomm.org/connections/1.0/request",
    val label: String,
    val connection: Connection,
    @SerialName("~thread") val thread: Thread? = null
) {
    @Serializable
    data class Connection(
        val did: String,
        val didDoc: DidDocument? = null
    )
}
```

##### Tasks
- [ ] Implement DID generation (5h)
- [ ] Create request builder (6h)
- [ ] Implement request packing (5h)
- [ ] Send request via transport (4h)
- [ ] Update state (3h)
- [ ] Store request (3h)
- [ ] Write tests (6h)
- [ ] Document request flow (3h)

---

#### US-3.4: Connection Response Handling
**As a** user  
**I want** to receive connection response  
**So that** connection is completed

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Parse connection response
- [x] Verify response signature
- [x] Extract their DID Document
- [x] Store connection details
- [x] Send ACK message
- [x] Update connection to COMPLETED

##### Tasks
- [ ] Create response parser (5h)
- [ ] Implement signature verification (6h)
- [ ] Extract DID Document (4h)
- [ ] Store connection (4h)
- [ ] Send ACK (4h)
- [ ] Update state (3h)
- [ ] Write tests (6h)
- [ ] Document response handling (3h)

---

#### US-3.5: Connection Repository & Database
**As a** developer  
**I want** connection persistence  
**So that** connections are stored

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] Connection entity in Room
- [x] Connection DAO
- [x] CRUD operations
- [x] Query by state
- [x] Search connections

##### Database Schema
```kotlin
@Entity(tableName = "connections")
data class ConnectionEntity(
    @PrimaryKey val id: String,
    val theirLabel: String,
    val theirDid: String,
    val theirDidDocJson: String,
    val myDid: String,
    val myDidDocJson: String,
    val state: ConnectionState,
    val invitationJson: String?,
    val theirImageUrl: String?,
    val createdAt: Long,
    val updatedAt: Long,
    val isActive: Boolean = true
)

@Dao
interface ConnectionDao {
    @Query("SELECT * FROM connections WHERE isActive = 1 ORDER BY updatedAt DESC")
    fun getAllConnections(): Flow<List<ConnectionEntity>>
    
    @Query("SELECT * FROM connections WHERE id = :id")
    suspend fun getConnectionById(id: String): ConnectionEntity?
    
    @Query("SELECT * FROM connections WHERE state = :state")
    fun getConnectionsByState(state: ConnectionState): Flow<List<ConnectionEntity>>
    
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertConnection(connection: ConnectionEntity)
    
    @Update
    suspend fun updateConnection(connection: ConnectionEntity)
    
    @Query("UPDATE connections SET isActive = 0 WHERE id = :id")
    suspend fun deleteConnection(id: String)
}
```

##### Tasks
- [ ] Create connection entity (3h)
- [ ] Create connection DAO (4h)
- [ ] Implement repository (5h)
- [ ] Add search functionality (3h)
- [ ] Write tests (4h)

---

#### US-3.6: Connection Service/Use Cases
**As a** developer  
**I want** connection business logic  
**So that** connection operations are centralized

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] AcceptInvitationUseCase
- [x] SendConnectionRequestUseCase
- [x] ProcessConnectionResponseUseCase
- [x] DeleteConnectionUseCase
- [x] GetConnectionsUseCase

##### Use Cases
```kotlin
class AcceptInvitationUseCase @Inject constructor(
    private val connectionRepository: ConnectionRepository,
    private val didService: DidService,
    private val didcommService: DIDCommService
) {
    suspend operator fun invoke(
        invitationUrl: String
    ): Result<Connection> {
        return runCatching {
            // 1. Parse invitation
            val invitation = parseInvitation(invitationUrl)
            
            // 2. Create ephemeral DID
            val myDid = didService.createDid()
            
            // 3. Create connection request
            val request = createConnectionRequest(invitation, myDid)
            
            // 4. Pack and send request
            val packedRequest = didcommService.pack(request, invitation.recipientKeys)
            didcommService.send(packedRequest, invitation.serviceEndpoint)
            
            // 5. Store connection
            val connection = Connection(
                id = request.id,
                theirLabel = invitation.label,
                myDid = myDid,
                state = ConnectionState.REQUESTED
            )
            connectionRepository.save(connection)
            
            connection
        }
    }
}
```

##### Tasks
- [ ] Create AcceptInvitationUseCase (6h)
- [ ] Create SendConnectionRequestUseCase (5h)
- [ ] Create ProcessConnectionResponseUseCase (6h)
- [ ] Create DeleteConnectionUseCase (3h)
- [ ] Create GetConnectionsUseCase (3h)
- [ ] Write unit tests (8h)
- [ ] Document use cases (3h)

---

#### US-3.7: Connection ViewModel
**As a** developer  
**I want** connection ViewModel  
**So that** UI can observe connection data

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] ConnectionsViewModel
- [x] ConnectionDetailViewModel
- [x] State management with StateFlow
- [x] Handle user actions
- [x] Error handling

##### ViewModel Example
```kotlin
@HiltViewModel
class ConnectionsViewModel @Inject constructor(
    private val getConnectionsUseCase: GetConnectionsUseCase,
    private val deleteConnectionUseCase: DeleteConnectionUseCase
) : ViewModel() {
    
    private val _uiState = MutableStateFlow<ConnectionsUiState>(ConnectionsUiState.Loading)
    val uiState: StateFlow<ConnectionsUiState> = _uiState.asStateFlow()
    
    init {
        loadConnections()
    }
    
    private fun loadConnections() {
        viewModelScope.launch {
            getConnectionsUseCase()
                .collect { result ->
                    _uiState.value = when {
                        result.isSuccess -> ConnectionsUiState.Success(result.getOrNull()!!)
                        result.isFailure -> ConnectionsUiState.Error(result.exceptionOrNull()!!)
                        else -> ConnectionsUiState.Loading
                    }
                }
        }
    }
    
    fun deleteConnection(connectionId: String) {
        viewModelScope.launch {
            deleteConnectionUseCase(connectionId)
        }
    }
}

sealed class ConnectionsUiState {
    object Loading : ConnectionsUiState()
    data class Success(val connections: List<Connection>) : ConnectionsUiState()
    data class Error(val error: Throwable) : ConnectionsUiState()
}
```

##### Tasks
- [ ] Create ConnectionsViewModel (5h)
- [ ] Create ConnectionDetailViewModel (5h)
- [ ] Implement state management (4h)
- [ ] Add error handling (3h)
- [ ] Write ViewModel tests (5h)

---

#### US-3.8: QR Code Scanner (CameraX + MLKit)
**As a** user  
**I want** to scan QR codes  
**So that** I can accept invitations

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] CameraX integration
- [x] ML Kit barcode scanning
- [x] QR code detection
- [x] Invitation URL extraction
- [x] Camera permissions
- [x] Scanner UI

##### Tasks
- [ ] Add CameraX dependencies (2h)
- [ ] Add ML Kit barcode (2h)
- [ ] Implement camera preview (5h)
- [ ] Implement QR detection (6h)
- [ ] Handle permissions (3h)
- [ ] Create scanner UI (6h)
- [ ] Write tests (4h)

---

#### US-3.9: Deep Link Handling for Invitations
**As a** user  
**I want** to open invitation links  
**So that** I can connect via URLs

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Acceptance Criteria
- [x] Deep link configuration (AndroidManifest)
- [x] Handle didcomm:// scheme
- [x] Handle https:// with query params
- [x] Parse invitation from deep link
- [x] Navigate to connection screen

##### Tasks
- [ ] Configure deep links in manifest (2h)
- [ ] Implement deep link handler (5h)
- [ ] Parse invitation URLs (4h)
- [ ] Navigate to connection screen (3h)
- [ ] Write tests (3h)

---

#### US-3.10: Connection List UI (Jetpack Compose)
**As a** user  
**I want** to view connections  
**So that** I can manage them

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Connections list screen
- [x] Connection item cards
- [x] State indicators
- [x] Pull-to-refresh
- [x] Empty state
- [x] Delete connection swipe action

##### Compose UI
```kotlin
@Composable
fun ConnectionsScreen(
    viewModel: ConnectionsViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    
    when (val state = uiState) {
        is ConnectionsUiState.Loading -> LoadingIndicator()
        is ConnectionsUiState.Success -> ConnectionsList(
            connections = state.connections,
            onConnectionClick = { /* navigate to details */ },
            onDeleteConnection = { viewModel.deleteConnection(it) }
        )
        is ConnectionsUiState.Error -> ErrorMessage(state.error)
    }
}

@Composable
fun ConnectionsList(
    connections: List<Connection>,
    onConnectionClick: (Connection) -> Unit,
    onDeleteConnection: (String) -> Unit
) {
    LazyColumn {
        items(connections, key = { it.id }) { connection ->
            ConnectionItem(
                connection = connection,
                onClick = { onConnectionClick(connection) },
                onDelete = { onDeleteConnection(connection.id) }
            )
        }
    }
}
```

##### Tasks
- [ ] Create ConnectionsScreen composable (6h)
- [ ] Create ConnectionItem card (5h)
- [ ] Add pull-to-refresh (3h)
- [ ] Create empty state (3h)
- [ ] Add swipe-to-delete (4h)
- [ ] Write Compose tests (5h)

---

#### US-3.11: Connection Detail UI
**As a** user  
**I want** to view connection details  
**So that** I can see connection information

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Connection detail screen
- [x] Display their label
- [x] Display DID
- [x] Display connection state
- [x] Display created date
- [x] Delete connection action

##### Tasks
- [ ] Create ConnectionDetailScreen (6h)
- [ ] Display connection info (5h)
- [ ] Add delete action (3h)
- [ ] Write Compose tests (4h)

---

### Sprint 3 Summary

**Total Story Points**: 133 SP  
**Planned Capacity**: 130 SP  
**Sprint Goal**: ✅ Aries connection protocol complete

**Key Deliverables**:
- ✅ Connection state machine
- ✅ Invitation parsing and handling
- ✅ Connection request/response flow
- ✅ Connection repository and database
- ✅ Connection use cases
- ✅ QR code scanner
- ✅ Deep link handling
- ✅ Connections list UI (Jetpack Compose)

---

## 🚀 Sprint 4: Aries Credential Protocol

### Sprint Goal
*"Implement credential issuance protocol with AnonCreds."*

**Duration**: 4 weeks  
**Capacity**: 130 Story Points  
**Sprint Dates**: Week 13-16

---

### 📖 User Stories

#### US-4.1: Credential State Machine
**As a** developer  
**I want** credential state machine  
**So that** credential lifecycle is managed

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist

##### Credential States
```kotlin
enum class CredentialState {
    OFFER_RECEIVED,
    REQUEST_SENT,
    CREDENTIAL_RECEIVED,
    DONE,
    DECLINED,
    ERROR
}

sealed class CredentialEvent {
    data class OfferReceived(val offer: CredentialOffer) : CredentialEvent()
    object OfferAccepted : CredentialEvent()
    object OfferDeclined : CredentialEvent()
    data class RequestSent(val request: CredentialRequest) : CredentialEvent()
    data class CredentialReceived(val credential: Credential) : CredentialEvent()
    object Completed : CredentialEvent()
    data class Error(val error: Throwable) : CredentialEvent()
}
```

##### Tasks
- [ ] Define credential states (3h)
- [ ] Implement state machine (8h)
- [ ] Add state persistence (5h)
- [ ] Implement event handling (5h)
- [ ] Write tests (6h)

---

#### US-4.2: Credential Offer Handling
**As a** user  
**I want** to receive credential offers  
**So that** I can accept credentials

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Parse credential offer message
- [x] Extract schema ID
- [x] Extract cred def ID
- [x] Display credential preview
- [x] Store offer
- [x] Accept/decline actions

##### Credential Offer
```kotlin
@Serializable
data class CredentialOffer(
    @SerialName("@id") val id: String,
    @SerialName("@type") val type: String,
    val comment: String? = null,
    val credentialPreview: CredentialPreview,
    @SerialName("offers~attach") val offersAttach: List<Attachment>
) {
    @Serializable
    data class CredentialPreview(
        @SerialName("@type") val type: String,
        val attributes: List<Attribute>
    ) {
        @Serializable
        data class Attribute(
            val name: String,
            val value: String,
            @SerialName("mime-type") val mimeType: String? = null
        )
    }
}
```

##### Tasks
- [ ] Create offer parser (6h)
- [ ] Extract schema/cred def (4h)
- [ ] Implement preview extraction (5h)
- [ ] Store offer in DB (4h)
- [ ] Write tests (6h)
- [ ] Document offer handling (3h)

---

#### US-4.3: Credential Request Generation
**As a** user  
**I want** to send credential request  
**So that** credential is issued

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Senior Android Dev 1

##### Acceptance Criteria
- [x] Generate credential request with AnonCreds
- [x] Create blinded link secret
- [x] Create request message
- [x] Pack and send request
- [x] Update credential state

##### Credential Request Flow
```kotlin
class CreateCredentialRequestUseCase @Inject constructor(
    private val anonCredsWrapper: AnonCredsWrapper,
    private val walletService: WalletService,
    private val didcommService: DIDCommService
) {
    suspend operator fun invoke(
        offer: CredentialOffer,
        connectionId: String
    ): Result<CredentialExchangeRecord> {
        return runCatching {
            // 1. Get cred def from ledger
            val credDef = ledgerService.getCredDef(offer.credDefId)
            
            // 2. Create credential request with AnonCreds
            val (credRequest, credRequestMetadata) = anonCredsWrapper.createCredentialRequest(
                proverDid = myDid,
                credOffer = offer.offersAttach.first().data.base64,
                credDef = credDef,
                masterSecretId = "default"
            )
            
            // 3. Create request message
            val requestMessage = CredentialRequest(
                id = UUID.randomUUID().toString(),
                thread = Thread(thid = offer.id),
                requestsAttach = listOf(
                    Attachment(data = AttachmentData(base64 = credRequest))
                )
            )
            
            // 4. Pack and send
            val packed = didcommService.pack(requestMessage, connection.theirDid)
            didcommService.send(packed, connection.serviceEndpoint)
            
            // 5. Update record
            updateCredentialExchangeRecord(offer.id, CredentialState.REQUEST_SENT)
        }
    }
}
```

##### Tasks
- [ ] Implement cred def retrieval (5h)
- [ ] Create request with AnonCreds (10h)
- [ ] Build request message (5h)
- [ ] Pack and send (4h)
- [ ] Store request metadata (4h)
- [ ] Update state (3h)
- [ ] Write integration tests (8h)
- [ ] Document request flow (4h)

---

#### US-4.4: Credential Reception & Storage
**As a** user  
**I want** to receive credentials  
**So that** they are stored in wallet

**Story Points**: 21  
**Priority**: Must Have  
**Assignee**: SSI Specialist + Android Security Engineer

##### Acceptance Criteria
- [x] Parse credential message
- [x] Process credential with AnonCreds
- [x] Store credential in Askar
- [x] Store credential metadata in Room
- [x] Verify credential signature
- [x] Extract credential attributes
- [x] Handle revocation registry

##### Credential Processing
```kotlin
class ProcessCredentialUseCase @Inject constructor(
    private val anonCredsWrapper: AnonCredsWrapper,
    private val askarStore: AskarStore,
    private val credentialRepository: CredentialRepository
) {
    suspend operator fun invoke(
        credentialMessage: CredentialMessage,
        credRequestMetadata: String,
        credDefJson: String,
        revRegDefJson: String?
    ): Result<StoredCredential> {
        return runCatching {
            // 1. Process credential with AnonCreds
            val credentialId = anonCredsWrapper.storeCredential(
                credId = UUID.randomUUID().toString(),
                credRequestMetadata = credRequestMetadata,
                credential = credentialMessage.credentialsAttach.first().data.base64,
                credDef = credDefJson,
                revRegDef = revRegDefJson
            )
            
            // 2. Extract attributes
            val credential = parseCredential(credentialMessage)
            
            // 3. Store in Askar
            askarStore.insert(
                category = "credential",
                name = credentialId,
                value = credential.toJson(),
                tags = mapOf(
                    "schema_id" to credential.schemaId,
                    "cred_def_id" to credential.credDefId
                )
            )
            
            // 4. Store metadata in Room
            val credentialEntity = CredentialEntity(
                id = credentialId,
                type = extractCredentialType(credential),
                issuer = extractIssuer(credential),
                issuanceDate = System.currentTimeMillis(),
                credentialJson = credential.toJson(),
                schemaId = credential.schemaId,
                credDefId = credential.credDefId,
                status = CredentialStatus.ACTIVE
            )
            credentialRepository.save(credentialEntity)
            
            StoredCredential(credentialId, credential)
        }
    }
}
```

##### Tasks
- [ ] Create credential parser (6h)
- [ ] Implement AnonCreds storage (10h)
- [ ] Store in Askar (6h)
- [ ] Store metadata in Room (5h)
- [ ] Implement verification (6h)
- [ ] Extract attributes (5h)
- [ ] Handle revocation info (6h)
- [ ] Write integration tests (10h)
- [ ] Document storage (4h)

---

#### US-4.5: Credential Repository & Database
**As a** developer  
**I want** credential persistence  
**So that** credentials are stored

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Database Schema
```kotlin
@Entity(tableName = "credentials")
data class CredentialEntity(
    @PrimaryKey val id: String,
    val type: String, // e.g., "UniversityDegree"
    val issuer: String,
    val issuerName: String? = null,
    val issuerImageUrl: String? = null,
    val issuanceDate: Long,
    val expirationDate: Long? = null,
    val credentialJson: String, // full credential (encrypted)
    val attributesJson: String, // extracted attributes for display
    val schemaId: String,
    val credDefId: String,
    val revRegId: String? = null,
    val status: CredentialStatus,
    val tags: String? = null, // JSON array of tags
    val isFavorite: Boolean = false,
    val createdAt: Long,
    val updatedAt: Long
)

enum class CredentialStatus {
    ACTIVE,
    REVOKED,
    EXPIRED,
    SUSPENDED
}

@Dao
interface CredentialDao {
    @Query("SELECT * FROM credentials ORDER BY updatedAt DESC")
    fun getAllCredentials(): Flow<List<CredentialEntity>>
    
    @Query("SELECT * FROM credentials WHERE id = :id")
    suspend fun getCredentialById(id: String): CredentialEntity?
    
    @Query("SELECT * FROM credentials WHERE type = :type")
    fun getCredentialsByType(type: String): Flow<List<CredentialEntity>>
    
    @Query("SELECT * FROM credentials WHERE status = :status")
    fun getCredentialsByStatus(status: CredentialStatus): Flow<List<CredentialEntity>>
    
    @Query("SELECT * FROM credentials WHERE isFavorite = 1")
    fun getFavoriteCredentials(): Flow<List<CredentialEntity>>
    
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCredential(credential: CredentialEntity)
    
    @Update
    suspend fun updateCredential(credential: CredentialEntity)
    
    @Query("DELETE FROM credentials WHERE id = :id")
    suspend fun deleteCredential(id: String)
    
    @Query("SELECT * FROM credentials WHERE attributesJson LIKE '%' || :searchQuery || '%'")
    fun searchCredentials(searchQuery: String): Flow<List<CredentialEntity>>
}
```

##### Tasks
- [ ] Create credential entity (4h)
- [ ] Create credential DAO (5h)
- [ ] Implement repository (6h)
- [ ] Add search functionality (4h)
- [ ] Write tests (5h)

---

#### US-4.6: Revocation Status Checking
**As a** user  
**I want** revocation status checked  
**So that** I know if credential is valid

**Story Points**: 13  
**Priority**: Should Have  
**Assignee**: SSI Specialist + Senior Android Dev 2

##### Acceptance Criteria
- [x] Query revocation registry from ledger
- [x] Check credential revocation status
- [x] Cache revocation info
- [x] Background check with WorkManager
- [x] Update credential status
- [x] Display revocation status in UI

##### Revocation Check
```kotlin
class CheckCredentialRevocationUseCase @Inject constructor(
    private val ledgerService: LedgerService,
    private val credentialRepository: CredentialRepository,
    private val anonCredsWrapper: AnonCredsWrapper
) {
    suspend operator fun invoke(credentialId: String): Result<RevocationStatus> {
        return runCatching {
            val credential = credentialRepository.getById(credentialId)
                ?: throw CredentialNotFoundException()
            
            if (credential.revRegId == null) {
                return Result.success(RevocationStatus.NotRevocable)
            }
            
            // Get revocation registry delta
            val revRegDelta = ledgerService.getRevRegDelta(
                revRegId = credential.revRegId,
                from = null,
                to = System.currentTimeMillis()
            )
            
            // Check if credential is revoked
            val isRevoked = anonCredsWrapper.isCredentialRevoked(
                revRegDelta = revRegDelta,
                credRevId = credential.credRevId
            )
            
            // Update status
            if (isRevoked) {
                credentialRepository.updateStatus(credentialId, CredentialStatus.REVOKED)
                RevocationStatus.Revoked
            } else {
                RevocationStatus.Active
            }
        }
    }
}

sealed class RevocationStatus {
    object Active : RevocationStatus()
    object Revoked : RevocationStatus()
    object NotRevocable : RevocationStatus()
}
```

##### Tasks
- [ ] Implement ledger query (6h)
- [ ] Check revocation status (6h)
- [ ] Add caching layer (4h)
- [ ] Setup WorkManager background task (5h)
- [ ] Update credential status (3h)
- [ ] Write tests (6h)

---

#### US-4.7: Credential Use Cases
**As a** developer  
**I want** credential business logic  
**So that** credential operations are centralized

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 1

##### Use Cases
```kotlin
// Accept Credential Offer
class AcceptCredentialOfferUseCase

// Decline Credential Offer
class DeclineCredentialOfferUseCase

// Get Credentials
class GetCredentialsUseCase

// Get Credential By ID
class GetCredentialByIdUseCase

// Delete Credential
class DeleteCredentialUseCase

// Search Credentials
class SearchCredentialsUseCase

// Toggle Favorite
class ToggleCredentialFavoriteUseCase

// Export Credential
class ExportCredentialUseCase
```

##### Tasks
- [ ] Create AcceptCredentialOfferUseCase (6h)
- [ ] Create DeclineCredentialOfferUseCase (4h)
- [ ] Create GetCredentialsUseCase (4h)
- [ ] Create DeleteCredentialUseCase (3h)
- [ ] Create SearchCredentialsUseCase (4h)
- [ ] Create ToggleCredentialFavoriteUseCase (3h)
- [ ] Write unit tests (8h)

---

#### US-4.8: Credential ViewModels
**As a** developer  
**I want** credential ViewModels  
**So that** UI can observe credential data

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### ViewModels
```kotlin
@HiltViewModel
class CredentialsViewModel @Inject constructor(
    private val getCredentialsUseCase: GetCredentialsUseCase,
    private val deleteCredentialUseCase: DeleteCredentialUseCase,
    private val searchCredentialsUseCase: SearchCredentialsUseCase
) : ViewModel() {
    
    private val _uiState = MutableStateFlow<CredentialsUiState>(CredentialsUiState.Loading)
    val uiState: StateFlow<CredentialsUiState> = _uiState.asStateFlow()
    
    private val _searchQuery = MutableStateFlow("")
    val searchQuery: StateFlow<String> = _searchQuery.asStateFlow()
    
    init {
        loadCredentials()
        observeSearchQuery()
    }
    
    private fun loadCredentials() {
        viewModelScope.launch {
            getCredentialsUseCase()
                .catch { e ->
                    _uiState.value = CredentialsUiState.Error(e)
                }
                .collect { credentials ->
                    _uiState.value = CredentialsUiState.Success(credentials)
                }
        }
    }
    
    fun onSearchQueryChanged(query: String) {
        _searchQuery.value = query
    }
    
    fun deleteCredential(credentialId: String) {
        viewModelScope.launch {
            deleteCredentialUseCase(credentialId)
        }
    }
}

sealed class CredentialsUiState {
    object Loading : CredentialsUiState()
    data class Success(val credentials: List<Credential>) : CredentialsUiState()
    data class Error(val error: Throwable) : CredentialsUiState()
}
```

##### Tasks
- [ ] Create CredentialsViewModel (6h)
- [ ] Create CredentialDetailViewModel (5h)
- [ ] Create CredentialOfferViewModel (5h)
- [ ] Write ViewModel tests (6h)

---

#### US-4.9: Credential Offer UI
**As a** user  
**I want** to review credential offers  
**So that** I can accept/decline them

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Compose UI
```kotlin
@Composable
fun CredentialOfferScreen(
    viewModel: CredentialOfferViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    
    Scaffold(
        topBar = { CredentialOfferTopBar() }
    ) { padding ->
        when (val state = uiState) {
            is OfferUiState.Loading -> LoadingIndicator()
            is OfferUiState.Success -> CredentialOfferContent(
                offer = state.offer,
                onAccept = { viewModel.acceptOffer() },
                onDecline = { viewModel.declineOffer() }
            )
            is OfferUiState.Error -> ErrorMessage(state.error)
        }
    }
}

@Composable
fun CredentialOfferContent(
    offer: CredentialOffer,
    onAccept: () -> Unit,
    onDecline: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Issuer information
        IssuerCard(issuer = offer.issuer)
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Credential preview
        CredentialPreviewCard(preview = offer.credentialPreview)
        
        Spacer(modifier = Modifier.height(24.dp))
        
        // Accept/Decline buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            OutlinedButton(
                onClick = onDecline,
                modifier = Modifier.weight(1f)
            ) {
                Text("Decline")
            }
            Button(
                onClick = onAccept,
                modifier = Modifier.weight(1f)
            ) {
                Text("Accept")
            }
        }
    }
}
```

##### Tasks
- [ ] Create CredentialOfferScreen (6h)
- [ ] Create IssuerCard component (4h)
- [ ] Create CredentialPreviewCard (5h)
- [ ] Add accept/decline logic (4h)
- [ ] Write Compose tests (5h)

---

#### US-4.10: Credentials List UI
**As a** user  
**I want** to view my credentials  
**So that** I can manage them

**Story Points**: 13  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Credentials list screen
- [x] Credential cards with preview
- [x] Search functionality
- [x] Filter by type/status
- [x] Pull-to-refresh
- [x] Empty state
- [x] Swipe-to-delete

##### Tasks
- [ ] Create CredentialsScreen (7h)
- [ ] Create CredentialCard component (6h)
- [ ] Add search bar (4h)
- [ ] Implement filters (4h)
- [ ] Add pull-to-refresh (3h)
- [ ] Create empty state (3h)
- [ ] Write Compose tests (6h)

---

#### US-4.11: Credential Detail UI
**As a** user  
**I want** to view credential details  
**So that** I can see all information

**Story Points**: 8  
**Priority**: Must Have  
**Assignee**: Senior Android Dev 2

##### Acceptance Criteria
- [x] Credential detail screen
- [x] Display all attributes
- [x] Display issuer info
- [x] Display issuance/expiry dates
- [x] Revocation status indicator
- [x] Share/Export/Delete actions

##### Tasks
- [ ] Create CredentialDetailScreen (7h)
- [ ] Display attributes (5h)
- [ ] Add action buttons (4h)
- [ ] Write Compose tests (4h)

---

### Sprint 4 Summary

**Total Story Points**: 145 SP  
**Planned Capacity**: 130 SP (Extended for credential complexity)  
**Sprint Goal**: ✅ Aries credential protocol complete

**Key Deliverables**:
- ✅ Credential state machine
- ✅ Credential offer handling
- ✅ Credential request generation (AnonCreds)
- ✅ Credential reception and storage (Askar + Room)
- ✅ Revocation status checking
- ✅ Credential use cases and ViewModels
- ✅ Credential offer UI
- ✅ Credentials list and detail UI

---

**[DOCUMENT CONTINUES with remaining sprints 5-10 covering:]**

## Sprint 5: Aries Proof Protocol (130 SP)
- Proof request handling
- Credential matching for proofs
- Zero-knowledge proof generation
- Proof presentation UI

## Sprint 6: UI/UX Complete Implementation (140 SP)
- Onboarding flow (Compose)
- Home dashboard
- Settings screens
- Notifications
- Animations & transitions

## Sprint 7: Advanced Features (OID4VCI/VP, SD-JWT) (130 SP)
- OpenID4VCI integration
- OpenID4VP integration
- SD-JWT support
- BBS+ signatures

## Sprint 8: Enterprise Integrations (100 SP)
- Microsoft Entra Verified ID
- Sphereon VDX Platform
- EBSI integration

## Sprint 9: Security & Performance (120 SP)
- Security audit
- Penetration testing
- Performance optimization
- Accessibility

## Sprint 10: Testing & Release (100 SP)
- Comprehensive testing
- Google Play submission
- Production monitoring
- Documentation

---

## 📊 Project Summary

**Total Duration**: 40-44 weeks (10-11 sprints)  
**Total Story Points**: ~1,350 SP  
**Team Size**: 6-8 Android developers  
**Estimated Budget**: $700,000 - $950,000  

**Key Deliverables**:
- Native Android app dengan Kotlin
- Full Jetpack stack (Compose, Room, Navigation, etc.)
- Manual Aries protocol implementation
- Indy SDK, Askar, AnonCreds via JNI
- Clean Architecture dengan multi-module
- Production-ready SSI wallet

---

**Document Version**: 1.0  
**Created**: October 2024  
**Platform**: Native Android (Kotlin)  
**Status**: Ready for Sprint 0

---

*Dokumentasi lengkap untuk remaining sprints akan dilanjutkan jika dibutuhkan.*
