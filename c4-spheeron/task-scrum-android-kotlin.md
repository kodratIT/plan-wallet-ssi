# Sphereon Mobile Wallet - Native Android Kotlin
## Scrum Task Management (Summary)

## 📋 Project Overview

**Project**: Sphereon SSI Wallet - Native Android (Kotlin)  
**Duration**: 40-44 Weeks (10-11 Sprints @ 4 weeks)  
**Team**: 6-8 Android Developers  
**Total SP**: ~1,350 Story Points  
**Budget**: $700K - $950K

---

## 🏗️ Architecture

### Technology Stack
- **Language**: Kotlin 1.9+
- **UI**: Jetpack Compose (Material 3)
- **DI**: Hilt
- **Database**: Room + SQLCipher
- **Network**: Retrofit + OkHttp
- **Async**: Coroutines + Flow
- **SSI**: Indy SDK (JNI) + Aries Askar + AnonCreds

### Project Structure
```
:app
:core (:common, :network, :database, :security)
:domain (:models, :repository, :usecase)
:data (:repository-impl, :local, :remote)
:feature (:credentials, :connections, :proofs, :settings)
:ssi (:indy, :aries, :didcomm, :wallet)
```

---

## 📅 Sprint Breakdown (Summary)

### **Sprint 1** (Week 1-4): Foundation & Indy SDK [130 SP]
**Goal**: Android project foundation + SSI libraries integration

**Key Stories**:
- Multi-module project structure (13 SP)
- Hilt DI setup (8 SP)
- Room + SQLCipher database (13 SP)
- Jetpack Compose Material 3 (8 SP)
- Navigation Compose (8 SP)
- **Indy SDK JNI integration** (21 SP)
- **Aries Askar integration** (21 SP)
- **AnonCreds integration** (21 SP)
- Android Keystore wrapper (13 SP)
- CI/CD pipeline (13 SP)

**Deliverables**:
✅ Multi-module Android project  
✅ Indy SDK, Askar, AnonCreds working via JNI  
✅ Database encrypted with SQLCipher  
✅ Compose UI ready  

---

### **Sprint 2** (Week 5-8): DIDComm Foundation [130 SP]
**Goal**: DIDComm messaging, encryption, transport

**Key Stories**:
- DIDComm message models (8 SP)
- DID resolution service (13 SP)
- **DIDComm encryption (JWE)** - authcrypt/anoncrypt (21 SP)
- HTTP/HTTPS transport (13 SP)
- WebSocket transport (13 SP)
- **Mediator client** (21 SP)
- Message dispatcher/router (13 SP)
- Message storage (8 SP)
- Message queue (8 SP)

**Deliverables**:
✅ DIDComm v1/v2 support  
✅ End-to-end encryption  
✅ HTTP + WebSocket transport  
✅ Mediator integration  

---

### **Sprint 3** (Week 9-12): Aries Connection Protocol [130 SP]
**Goal**: Connection invitation, request, response

**Key Stories**:
- Connection state machine (13 SP)
- **Connection invitation handling** (13 SP)
- **Connection request generation** (13 SP)
- **Connection response handling** (13 SP)
- Connection repository & DB (8 SP)
- Connection use cases (13 SP)
- Connection ViewModels (8 SP)
- **QR code scanner** (CameraX + MLKit) (13 SP)
- Deep link handling (8 SP)
- **Connections list UI (Compose)** (13 SP)
- Connection detail UI (8 SP)

**Deliverables**:
✅ Full connection protocol  
✅ QR scanner working  
✅ Connections UI (Jetpack Compose)  

---

### **Sprint 4** (Week 13-16): Aries Credential Protocol [130 SP]
**Goal**: Credential issuance with AnonCreds

**Key Stories**:
- Credential state machine (13 SP)
- **Credential offer handling** (13 SP)
- **Credential request (AnonCreds)** (21 SP)
- **Credential reception & storage** (Askar + Room) (21 SP)
- Credential repository & DB (8 SP)
- Revocation status checking (13 SP)
- Credential use cases (13 SP)
- Credential ViewModels (8 SP)
- **Credential offer UI** (13 SP)
- **Credentials list UI** (13 SP)
- Credential detail UI (8 SP)

**Deliverables**:
✅ Credential issuance protocol  
✅ AnonCreds integration  
✅ Credentials UI (Compose)  
✅ Revocation checking  

---

### **Sprint 5** (Week 17-20): Aries Proof Protocol [130 SP]
**Goal**: Proof request/presentation with ZKP

**Key Stories**:
- Proof state machine (13 SP)
- **Proof request handling** (13 SP)
- **Credential matching for proofs** (13 SP)
- **ZKP proof generation (AnonCreds)** (21 SP)
- Proof presentation (13 SP)
- Proof repository & DB (8 SP)
- Proof use cases (13 SP)
- Proof ViewModels (8 SP)
- **Proof request UI** (13 SP)
- **Credential selector UI** (13 SP)
- Proof history UI (8 SP)

**Deliverables**:
✅ Proof protocol complete  
✅ Zero-knowledge proofs  
✅ Presentation UI  

---

### **Sprint 6** (Week 21-24): Complete UI/UX [140 SP]
**Goal**: All screens with Jetpack Compose

**Key Stories**:
- **Onboarding flow** (Tutorial, Terms, PIN, Biometric) (21 SP)
- **Home dashboard** (13 SP)
- Settings screens (13 SP)
- Notifications system (13 SP)
- **Security settings** (PIN change, biometric, auto-lock) (13 SP)
- **Material 3 theming** (light/dark) (8 SP)
- **Animations & transitions** (13 SP)
- Empty states (8 SP)
- Error handling UI (8 SP)
- Loading states (8 SP)
- Developer mode (8 SP)

**Deliverables**:
✅ Complete UI with Compose  
✅ Material 3 Design  
✅ Smooth animations  
✅ Onboarding flow  

---

### **Sprint 7** (Week 25-28): Advanced Features [130 SP]
**Goal**: OID4VCI/VP, SD-JWT, BBS+

**Key Stories**:
- **OpenID4VCI integration** (21 SP)
- **OpenID4VP integration** (21 SP)
- **SD-JWT (Selective Disclosure)** (13 SP)
- **BBS+ signatures** (13 SP)
- **Credential Manifest support** (13 SP)
- Presentation Exchange v2 (13 SP)
- Well-known DID configuration (8 SP)
- Credential Status List 2021 (8 SP)
- Advanced backup/restore (13 SP)
- NFC support (optional) (13 SP)

**Deliverables**:
✅ OpenID4VCI/VP  
✅ SD-JWT & BBS+  
✅ Credential Manifest  

---

### **Sprint 8** (Week 29-32): Enterprise Integrations [100 SP]
**Goal**: Microsoft Entra, VDX, EBSI

**Key Stories**:
- **Microsoft Entra Verified ID** (21 SP)
- **Sphereon VDX Platform** (21 SP)
- **EBSI integration** (did:ebsi) (21 SP)
- Organization wallet profiles (13 SP)
- Enterprise configuration (13 SP)
- Analytics & reporting (8 SP)

**Deliverables**:
✅ Enterprise integrations  
✅ Multi-organization support  

---

### **Sprint 9** (Week 33-36): Security & Performance [120 SP]
**Goal**: Audit, testing, optimization

**Key Stories**:
- **Security audit** (21 SP)
- **Penetration testing** (21 SP)
- **Performance optimization** (13 SP)
- **Memory leak fixes** (8 SP)
- **Battery optimization** (8 SP)
- **Accessibility (TalkBack, large text)** (13 SP)
- **Localization** (13 SP)
- Code obfuscation (ProGuard/R8) (8 SP)
- App signing & security (8 SP)

**Deliverables**:
✅ Security audit passed  
✅ Performance optimized  
✅ Accessible  

---

### **Sprint 10** (Week 37-40): Testing & Release [100 SP]
**Goal**: Production release to Google Play

**Key Stories**:
- **E2E testing (Espresso)** (21 SP)
- **Unit testing (>80% coverage)** (13 SP)
- **Integration testing** (13 SP)
- Interoperability testing (13 SP)
- **Bug bash & fixing** (21 SP)
- **Google Play submission** (13 SP)
- Production monitoring (8 SP)
- User documentation (8 SP)
- Developer documentation (8 SP)

**Deliverables**:
✅ App live on Google Play  
✅ Comprehensive testing  
✅ Documentation complete  

---

## 🎯 Key Technical Highlights

### Native Android Advantages
✅ **Performance**: Native code, no JS bridge  
✅ **Size**: Smaller APK (<40MB)  
✅ **Security**: Hardware-backed Keystore  
✅ **Integration**: Full Android platform access  

### Challenges
❌ **Longer Development**: 40 weeks vs 36 (React Native)  
❌ **Manual Aries Implementation**: No Bifold framework  
❌ **JNI Complexity**: Native library integration  
❌ **Single Platform**: Android only (no iOS)  

---

## 📊 Comparison: React Native vs Native Android

| Aspect | React Native | Native Android |
|--------|--------------|----------------|
| **Duration** | 36 weeks | 40 weeks |
| **Team Size** | 6-8 | 6-8 |
| **Story Points** | 775 SP | 1,350 SP |
| **Budget** | $525K-725K | $700K-950K |
| **Framework** | Expo + Bifold | Pure Android |
| **SSI SDK** | @sphereon/ssi-sdk | Manual Aries |
| **Performance** | Good | Excellent |
| **APK Size** | ~50MB | ~35MB |
| **Platforms** | iOS + Android | Android only |

---

## 🔑 Success Metrics

**Development**:
- Velocity: 120-135 SP/sprint
- Code coverage: >80%
- Detekt violations: <50

**Product**:
- App size: <40MB
- Startup time: <1.5s
- Crash-free: >99.7%
- Play Store rating: >4.7

---

## 📚 Documentation

Full detailed sprint documentation available with:
- Complete user stories with acceptance criteria
- Task breakdown with hour estimates
- Code examples for key components
- Architecture diagrams
- Database schemas
- API specifications

---

**Created**: October 2024  
**Status**: Production Planning  
**Target**: Native Android Kotlin Implementation
