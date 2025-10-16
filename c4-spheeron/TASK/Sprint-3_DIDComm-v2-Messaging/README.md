# Sprint 3: DIDComm v2 & Messaging

## 📋 Ringkasan Task

**Task**: Sprint 3 - DIDComm v2 & Messaging  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Prioritas**: TINGGI - Protokol messaging dan komunikasi  
**Platform**: iOS & Android (React Native + Expo)

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan messaging DIDComm v2 lengkap dengan WACI DIDComm untuk pertukaran credential."*

---

## ✅ Objektif

Setelah menyelesaikan Sprint 3:

1. ✅ Protocol DIDComm v2 diimplementasikan
2. ✅ Dukungan mediator v2 yang ditingkatkan
3. ✅ WACI DIDComm untuk penerbitan credential
4. ✅ WACI DIDComm untuk presentasi
5. ✅ UI/UX messaging berfungsi
6. ✅ Push notifications untuk pesan
7. ✅ Message queue dan retry logic
8. ✅ DID resolver yang ditingkatkan

---

## 📊 User Stories

### US-3.1: Implementasi Protocol DIDComm v2
**Sebagai** developer  
**Saya ingin** dukungan DIDComm v2  
**Sehingga** wallet dapat menggunakan protokol messaging terbaru

**Story Points**: 21  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 1

#### Kriteria Penerimaan
- [x] Struktur pesan DIDComm v2
- [x] Routing pesan
- [x] Forward secrecy
- [x] Threading pesan
- [x] Dukungan attachments
- [x] Kompatibilitas mundur dengan v1

#### Task Breakdown
- [ ] Pelajari spesifikasi DIDComm v2 (6 jam)
- [ ] Implementasi struktur pesan v2 (8 jam)
- [ ] Implementasi protokol routing (8 jam)
- [ ] Tambahkan forward secrecy dengan ECDH (6 jam)
- [ ] Implementasi message threading (5 jam)
- [ ] Tambahkan dukungan attachments (5 jam)
- [ ] Pastikan kompatibilitas v1 (6 jam)
- [ ] Tulis integration tests (8 jam)
- [ ] Dokumentasi implementasi (4 jam)

**Total Estimasi**: 56 jam

**Implementation Notes**:
- Library: `@sphereon/ssi-sdk-didcomm-v2` untuk DIDComm v2 operations
- Message format: Menggunakan format DIDComm v2 sesuai spec terbaru
- Encryption: Authenticated encryption dengan ECDH-ES+A256KW
- Threading: `thid` (thread ID) dan `pthid` (parent thread ID) support
- Attachments: Base64 encoded dengan multiple formats (JSON, binary, links)
- Backward compatibility: Automatic detection dan conversion dari v1 ke v2

---

### US-3.2: DIDComm Mediator v2
**Sebagai** pengguna  
**Saya ingin** dukungan mediator yang ditingkatkan  
**Sehingga** saya dapat menerima pesan dengan andal

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 2

#### Kriteria Penerimaan
- [x] Protokol koordinasi mediator
- [x] Dukungan multiple mediator
- [x] Failover mediator
- [x] Batch message pickup
- [x] Mode live delivery

#### Task Breakdown
- [ ] Implementasi protokol koordinasi mediator (6 jam)
- [ ] Tambahkan dukungan multi-mediator (6 jam)
- [ ] Implementasi automatic failover (5 jam)
- [ ] Tambahkan batch message pickup (4 jam)
- [ ] Implementasi live delivery dengan WebSocket (5 jam)
- [ ] Test berbagai skenario mediator (6 jam)
- [ ] Tulis integration tests (4 jam)

**Total Estimasi**: 36 jam

**Implementation Notes**:
- Service: `MediatorService.ts` - Complete mediator coordination
- Protocol: Coordinate-mediation, pickup-delivery, live-delivery
- Multiple mediators: Primary dan backup mediator configuration
- Failover: Automatic detection dan switch ke backup mediator
- Batch pickup: Efficient message retrieval dengan pagination
- Live delivery: WebSocket connection untuk real-time messaging
- Storage: Queue pesan untuk offline message handling

---

### US-3.3: WACI DIDComm - Penerbitan Credential
**Sebagai** pengguna  
**Saya ingin** WACI DIDComm untuk penerbitan  
**Sehingga** saya dapat menerima credential via messaging

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 1

#### Kriteria Penerimaan
- [x] Alur penerbitan WACI diimplementasikan
- [x] Penanganan pesan offer
- [x] Pembuatan pesan request
- [x] Pengiriman credential
- [x] Penanganan acknowledgment

#### Task Breakdown
- [ ] Pelajari spesifikasi WACI DIDComm (4 jam)
- [ ] Implementasi WACI issuance protocol (8 jam)
- [ ] Tangani pesan credential-offer (5 jam)
- [ ] Generate pesan credential-request (5 jam)
- [ ] Tangani pengiriman credential-issue (5 jam)
- [ ] Tambahkan message acknowledgments (3 jam)
- [ ] Tulis integration tests (6 jam)
- [ ] Dokumentasi implementasi (3 jam)

**Total Estimasi**: 39 jam

**Implementation Notes**:
- Service: `WACIIssuanceService.ts` - Complete WACI issuance flow
- Messages: offer-credential, request-credential, issue-credential, ack
- Flow: Issuer sends offer → Holder accepts → Issuer issues → Holder acknowledges
- UI: `CredentialOfferScreen.tsx` untuk menampilkan offer
- Preview: Credential preview sebelum acceptance
- Validation: Schema validation untuk semua message types
- Error handling: Proper error messages dan retry logic

---

### US-3.4: WACI DIDComm - Presentasi
**Sebagai** pengguna  
**Saya ingin** WACI DIDComm untuk presentasi  
**Sehingga** saya dapat berbagi credential via messaging

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 2

#### Kriteria Penerimaan
- [x] Alur presentasi WACI diimplementasikan
- [x] Penanganan pesan request
- [x] Pembuatan pesan presentasi
- [x] Penanganan acknowledgment
- [x] Penanganan error

#### Task Breakdown
- [ ] Implementasi WACI presentation protocol (8 jam)
- [ ] Tangani pesan presentation-request (5 jam)
- [ ] Generate pesan presentation-submit (6 jam)
- [ ] Tambahkan message acknowledgments (3 jam)
- [ ] Implementasi comprehensive error handling (4 jam)
- [ ] Tulis integration tests (6 jam)
- [ ] Dokumentasi implementasi (3 jam)

**Total Estimasi**: 35 jam

**Implementation Notes**:
- Service: `WACIPresentationService.ts` - Complete WACI presentation flow
- Messages: request-presentation, present-proof, ack, problem-report
- Flow: Verifier requests → Holder selects credentials → Holder presents → Verifier verifies
- UI: `PresentationRequestScreen.tsx` untuk menampilkan request
- Credential selection: UI untuk memilih credentials yang matching
- Selective disclosure: Support untuk pilih field mana yang di-share
- Verification: Client-side verification sebelum sending

---

### US-3.5: UI/UX Messaging
**Sebagai** pengguna  
**Saya ingin** interface messaging  
**Sehingga** saya dapat melihat pesan saya

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: UI/UX Designer + React Native Dev 1

#### Kriteria Penerimaan
- [x] Layar daftar pesan
- [x] Tampilan detail pesan
- [x] UI threading pesan
- [x] Preview attachment
- [x] Indikator status pesan
- [x] Badge unread

#### Task Breakdown
- [ ] Desain UI messaging (5 jam)
- [ ] Implementasi daftar pesan (6 jam)
- [ ] Buat tampilan detail pesan (5 jam)
- [ ] Tambahkan UI threading (5 jam)
- [ ] Implementasi preview attachment (4 jam)
- [ ] Tambahkan indikator status (3 jam)
- [ ] Tulis UI tests (4 jam)

**Total Estimasi**: 32 jam

**Implementation Notes**:
- Components: `MessageList.tsx`, `MessageThread.tsx`, `MessageDetail.tsx`
- Screen: `MessagingScreen.tsx` - Main messaging interface
- Features: Thread grouping, unread badges, message status indicators
- Attachment preview: Images, PDFs, JSON credentials inline preview
- UI patterns: WhatsApp-like messaging interface dengan swipe actions
- Animations: Smooth transitions dan loading states
- Accessibility: Screen reader support dan proper labels

---

### US-3.6: Push Notifications untuk Pesan
**Sebagai** pengguna  
**Saya ingin** push notifications  
**Sehingga** saya tahu ketika menerima pesan

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 2

#### Kriteria Penerimaan
- [x] Integrasi FCM/APNs
- [x] Notifikasi pada pesan baru
- [x] Notifikasi pada credential offer
- [x] Notifikasi pada proof request
- [x] Pengaturan notifikasi

#### Task Breakdown
- [ ] Setup FCM (Android) (4 jam)
- [ ] Setup APNs (iOS) (4 jam)
- [ ] Implementasi handler notifikasi (5 jam)
- [ ] Tambahkan pengaturan notifikasi (3 jam)
- [ ] Test notifikasi (4 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 23 jam

**Implementation Notes**:
- Service: `PushNotificationService.ts` - Complete push notification handling
- Library: `expo-notifications` untuk unified notification API
- Firebase: FCM setup untuk Android dengan `google-services.json`
- APNs: iOS push certificates dan provisioning profiles
- Notification types: New message, credential offer, proof request
- Deep linking: Tap notification untuk navigasi ke specific screen
- Settings: Granular control (enable/disable per notification type)
- Badge count: Update app icon badge untuk unread messages

---

### US-3.7: Message Queue & Retry Logic
**Sebagai** developer  
**Saya ingin** message queue  
**Sehingga** pesan terkirim dengan andal

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Implementasi message queue
- [x] Retry logic dengan exponential backoff
- [x] Penanganan pesan gagal
- [x] Persistensi queue
- [x] Opsi retry manual

#### Task Breakdown
- [ ] Implementasi message queue (5 jam)
- [ ] Tambahkan retry logic (5 jam)
- [ ] Implementasi strategi backoff (3 jam)
- [ ] Tambahkan persistensi queue (4 jam)
- [ ] Tambahkan UI retry manual (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 23 jam

**Implementation Notes**:
- Service: `MessageQueueService.ts` - Reliable message delivery
- Queue: FIFO queue dengan priority support
- Retry logic: Exponential backoff (1s, 2s, 4s, 8s, 16s)
- Max retries: 5 attempts sebelum marking sebagai failed
- Persistence: AsyncStorage untuk queue state
- Failed messages: UI untuk view dan manual retry
- Network detection: Automatic resume ketika online
- Background processing: Service untuk process queue di background

---

### US-3.8: Peningkatan DID Resolver
**Sebagai** developer  
**Saya ingin** resolusi DID yang ditingkatkan  
**Sehingga** semua metode DID berfungsi dengan baik

**Story Points**: 8  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist

#### Kriteria Penerimaan
- [x] Integrasi universal resolver
- [x] Caching lokal
- [x] Fallback resolvers
- [x] Optimasi performa
- [x] Penanganan error

#### Task Breakdown
- [ ] Integrasi universal resolver (5 jam)
- [ ] Implementasi layer caching (4 jam)
- [ ] Tambahkan fallback resolvers (4 jam)
- [ ] Optimasi performa (4 jam)
- [ ] Tambahkan penanganan error (2 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 22 jam

**Implementation Notes**:
- Service: `DIDResolverService.ts` - Enhanced DID resolution
- Universal resolver: Integration dengan https://dev.uniresolver.io/
- Supported methods: did:key, did:web, did:ion, did:ethr, did:peer
- Caching: In-memory cache + AsyncStorage untuk persistent cache
- TTL: Configurable cache expiry (default 1 hour)
- Fallback: Local resolver → Universal resolver → Backup resolvers
- Performance: Parallel resolution attempts dengan race condition
- Error handling: Graceful degradation dengan informative errors

---

## 📈 Ringkasan Sprint

**Total Story Points**: 97 SP  
**Kapasitas yang Direncanakan**: 90 SP  
**Tujuan Sprint**: ✅ DIDComm v2 dan WACI DIDComm lengkap

---

## 🎯 Deliverables Kunci

- ✅ Dukungan protokol DIDComm v2
- ✅ Integrasi mediator yang ditingkatkan
- ✅ WACI DIDComm untuk penerbitan & presentasi
- ✅ UI messaging
- ✅ Push notifications
- ✅ Pengiriman pesan yang andal

---

## 🧪 Kriteria Penerimaan Sprint

Sprint 3 dianggap berhasil ketika:

- [ ] ✅ Semua 8 user stories selesai dan diuji
- [ ] ✅ DIDComm v2 berfungsi dengan mediator
- [ ] ✅ WACI issuance dan presentation berhasil
- [ ] ✅ Push notifications berfungsi di iOS dan Android
- [ ] ✅ Message queue tidak kehilangan pesan
- [ ] ✅ Tidak ada bug kritis
- [ ] ✅ Code review selesai
- [ ] ✅ Dokumentasi lengkap
- [ ] ✅ Integration tests lulus
- [ ] ✅ Demo kepada Product Owner berhasil

---

## 📅 Timeline Sprint 3

**Minggu 9-12**: Pelaksanaan Sprint

**Sprint Planning** (4 jam)
- Review DIDComm v2 spec
- Breakdown technical tasks
- Alokasi tim

**Daily Standup** (15 menit/hari)
- Update implementasi
- Koordinasi SSI specialist
- Identifikasi blocker

**Bi-weekly SSI-SDK Sync** (1 jam)
- Sync dengan Sphereon SSI-SDK team
- Technical discussion
- Issue resolution

**Sprint Review** (2.5 jam)
- Demo messaging flows
- Demo WACI issuance/presentation
- Feedback stakeholders

**Sprint Retrospective** (1.5 jam)
- Evaluasi kompleksitas DIDComm
- Process improvements

---

## 🛠️ Teknologi & Dependencies

### DIDComm & Messaging
- **@sphereon/ssi-sdk-didcomm**: DIDComm operations
- **@sphereon/did-resolver**: DID resolution
- **didcomm-v2**: DIDComm v2 library

### Push Notifications
- **expo-notifications**: Expo notifications
- **@react-native-firebase/messaging**: FCM (Android)
- **@react-native-community/push-notification-ios**: APNs

### Queue & Persistence
- **@react-native-async-storage/async-storage**: Storage
- **redux-persist**: State persistence

### Network
- **axios**: HTTP client
- **socket.io-client**: WebSocket (untuk live delivery)

---

## 📚 Dokumentasi

### Dokumen yang Harus Dibuat
- [ ] Dokumentasi DIDComm v2 implementation
- [ ] Panduan WACI DIDComm flows
- [ ] Setup guide untuk mediator
- [ ] Push notifications configuration guide
- [ ] Message queue architecture doc
- [ ] DID resolution guide

---

## 🔗 Referensi

### Spesifikasi
- **DIDComm v2**: https://identity.foundation/didcomm-messaging/spec/
- **WACI DIDComm**: https://identity.foundation/waci-didcomm/
- **DID Resolution**: https://www.w3.org/TR/did-resolution/

### Implementation Guides
- **Sphereon SSI-SDK DIDComm**: https://github.com/Sphereon-Opensource/ssi-sdk
- **DIDComm Mediator**: https://github.com/decentralized-identity/didcomm-mediator

---

## 💬 Mendapatkan Bantuan

### Dukungan Internal
- **Isu DIDComm**: Hubungi SSI Specialist
- **Isu Mediator**: SSI Specialist + Backend Engineer
- **Push Notifications**: React Native Developer 2
- **Pertanyaan Teknis**: #technical Slack channel

### Dukungan Eksternal
- **DIDComm Community**: DIF Slack
- **Sphereon Support**: GitHub Issues

---

## ✅ Definition of Done

- [ ] Code complete dan di-merge
- [ ] Unit tests > 80% coverage
- [ ] Integration tests dengan mediator lulus
- [ ] Code review approved
- [ ] Dokumentasi lengkap
- [ ] Diuji di iOS dan Android
- [ ] Push notifications diuji pada device fisik
- [ ] Tidak ada bug kritis
- [ ] Demo dan accepted oleh PO

---

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: ✅ Siap untuk Eksekusi Sprint
