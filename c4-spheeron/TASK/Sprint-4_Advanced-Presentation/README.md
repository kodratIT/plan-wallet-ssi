# Sprint 4: Presentasi Lanjutan & Selective Disclosure

## 📋 Ringkasan Task

**Task**: Sprint 4 - Advanced Presentation & Selective Disclosure  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Prioritas**: TINGGI - Kemampuan presentasi lanjutan  
**Platform**: iOS & Android (React Native + Expo)

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan SD-JWT, tanda tangan BBS+, dan kemampuan selective disclosure yang ditingkatkan."*

---

## ✅ Objektif

Setelah menyelesaikan Sprint 4:

1. ✅ Dukungan SD-JWT (Selective Disclosure JWT)
2. ✅ Tanda tangan BBS+ untuk ZKP
3. ✅ Presentation Exchange v2 yang ditingkatkan
4. ✅ UI disclosure lanjutan
5. ✅ UI predicate proofs
6. ✅ JWT VC Presentation Profile
7. ✅ Riwayat dan analytics presentasi
8. ✅ Manajemen consent
9. ✅ Template presentasi

---

## 📊 User Stories

### US-4.1: Dukungan SD-JWT (Selective Disclosure JWT)
**Sebagai** pengguna  
**Saya ingin** credential SD-JWT  
**Sehingga** saya dapat secara selektif mengungkapkan klaim

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 1

#### Kriteria Penerimaan
- [x] Parsing dan validasi SD-JWT
- [x] UI pemilihan disclosure
- [x] Pembuatan selective disclosure
- [x] Holder binding
- [x] Penyimpanan credential SD-JWT

#### Task Breakdown
- [ ] Pelajari spesifikasi SD-JWT (5 jam)
- [ ] Implementasi parser SD-JWT (8 jam)
- [ ] Implementasi logika disclosure (8 jam)
- [ ] Buat UI disclosure (6 jam)
- [ ] Tambahkan holder binding (5 jam)
- [ ] Implementasi storage (4 jam)
- [ ] Tulis integration tests (8 jam)
- [ ] Dokumentasi implementasi (4 jam)

**Total Estimasi**: 48 jam

---

### US-4.2: Dukungan Tanda Tangan BBS+
**Sebagai** pengguna  
**Saya ingin** credential BBS+  
**Sehingga** saya memiliki kemampuan zero-knowledge proof

**Story Points**: 13  
**Prioritas**: Should Have  
**Assignee**: SSI Specialist + React Native Dev 2

#### Kriteria Penerimaan
- [x] Verifikasi tanda tangan BBS+
- [x] Pembuatan derived proof
- [x] Selective disclosure dengan ZKP
- [x] Penyimpanan credential BBS+
- [x] Optimasi performa

#### Task Breakdown
- [ ] Pelajari spesifikasi BBS+ (5 jam)
- [ ] Implementasi verifikasi tanda tangan (8 jam)
- [ ] Implementasi derivasi proof (10 jam)
- [ ] Tambahkan selective disclosure (6 jam)
- [ ] Optimasi performa (5 jam)
- [ ] Tulis integration tests (8 jam)
- [ ] Dokumentasi implementasi (4 jam)

**Total Estimasi**: 46 jam

---

### US-4.3: Presentation Exchange v2 yang Ditingkatkan
**Sebagai** developer  
**Saya ingin** dukungan PEx v2 penuh  
**Sehingga** permintaan presentasi kompleks dapat ditangani

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 1

#### Kriteria Penerimaan
- [x] Parsing Presentation Definition v2
- [x] Penanganan input descriptors
- [x] Evaluasi constraint
- [x] Pemilihan format
- [x] Pembuatan submission
- [x] Validasi submission

#### Task Breakdown
- [ ] Update library PEx (3 jam)
- [ ] Implementasi parser v2 (6 jam)
- [ ] Tangani input descriptors (6 jam)
- [ ] Implementasi evaluasi constraint (8 jam)
- [ ] Tambahkan pemilihan format (5 jam)
- [ ] Generate submissions (6 jam)
- [ ] Validasi submissions (5 jam)
- [ ] Tulis tests (8 jam)

**Total Estimasi**: 47 jam

---

### US-4.4: UI Disclosure Lanjutan
**Sebagai** pengguna  
**Saya ingin** pemilihan disclosure yang intuitif  
**Sehingga** saya memahami apa yang saya bagikan

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: UI/UX Designer + React Native Dev 2

#### Kriteria Penerimaan
- [x] Interface pemilihan klaim
- [x] Indikasi visual data yang diungkapkan
- [x] Indikator dampak privasi
- [x] Klaim required vs optional
- [x] Preview disclosure
- [x] Tooltip edukatif

#### Task Breakdown
- [ ] Desain UI disclosure (6 jam)
- [ ] Implementasi selector klaim (8 jam)
- [ ] Tambahkan indikator visual (4 jam)
- [ ] Tampilkan required/optional (3 jam)
- [ ] Buat layar preview (5 jam)
- [ ] Tambahkan konten edukatif (4 jam)
- [ ] Tulis UI tests (5 jam)

**Total Estimasi**: 35 jam

---

### US-4.5: UI Predicate Proofs
**Sebagai** pengguna  
**Saya ingin** menggunakan predicate proofs  
**Sehingga** saya dapat membuktikan klaim tanpa mengungkapkan nilai tepat

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Penjelasan predicate
- [x] UI pemilihan predicate
- [x] Verifikasi usia (misalnya, >18)
- [x] Range proofs
- [x] Pemberitahuan privasi

#### Task Breakdown
- [ ] Desain UI predicate (4 jam)
- [ ] Implementasi interface pemilihan (5 jam)
- [ ] Tambahkan predicate umum (usia, dll.) (4 jam)
- [ ] Buat konten edukatif (3 jam)
- [ ] Tulis UI tests (3 jam)

**Total Estimasi**: 19 jam

**Implementation Notes**:
- Component: `PredicateSelector.tsx` - Full UI implementation
- Service: Uses `BBSService` for zero-knowledge proof generation
- Common predicates: age>18, age>21, age>65, income>50k, credit>700
- Educational UI: Step-by-step ZKP explanation
- Tests: Full component testing with various credential types

---

### US-4.6: JWT VC Presentation Profile
**Sebagai** developer  
**Saya ingin** dukungan JWT VC Presentation Profile  
**Sehingga** wallet compliant dengan spesifikasi terbaru

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: SSI Specialist

#### Kriteria Penerimaan
- [x] Kepatuhan profile
- [x] Pembuatan VP-JWT
- [x] Holder binding di VP
- [x] Penanganan nonce
- [x] Pembatasan audience

#### Task Breakdown
- [ ] Pelajari spesifikasi presentation profile (3 jam)
- [ ] Implementasi pembuatan VP-JWT (6 jam)
- [ ] Tambahkan holder binding (4 jam)
- [ ] Tangani nonce (3 jam)
- [ ] Tambahkan pembatasan audience (3 jam)
- [ ] Tulis tests (4 jam)

**Total Estimasi**: 23 jam

**Implementation Notes**:
- Service: `JWTVPService.ts` - Complete JWT VP implementation
- Standard compliance: W3C VC Data Model + JWT VC Presentation Profile
- Features: VP-JWT creation, verification, VC extraction, holder binding
- Security: Short-lived JWTs (5 min), nonce validation, audience restriction
- Screen: `VPJWTScreen.tsx` for presentation creation UI

---

### US-4.7: Riwayat & Analytics Presentasi
**Sebagai** pengguna  
**Saya ingin** riwayat presentasi  
**Sehingga** saya tahu apa yang telah saya bagikan

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 2

#### Kriteria Penerimaan
- [x] Penyimpanan log presentasi
- [x] UI tampilan riwayat
- [x] Pelacakan data yang diungkapkan
- [x] Informasi verifier
- [x] Ekspor riwayat

#### Task Breakdown
- [ ] Desain model data riwayat (3 jam)
- [ ] Implementasi logging (5 jam)
- [ ] Buat UI riwayat (5 jam)
- [ ] Tambahkan fungsionalitas ekspor (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 19 jam

**Implementation Notes**:
- Service: `PresentationHistoryService.ts` - Complete history management
- Storage: AsyncStorage with max 1000 records
- Types: Full, selective, predicate, ZKP presentations tracked
- Features: Filtering, statistics, export to JSON
- Component: `HistoryTimeline.tsx` - Beautiful timeline UI with date grouping
- Analytics: Usage stats, most used credentials, presentation trends

---

### US-4.8: Manajemen Consent
**Sebagai** pengguna  
**Saya ingin** kontrol consent yang granular  
**Sehingga** saya mengontrol pembagian data saya

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Pengaturan consent per-verifier
- [x] Opsi ingat consent
- [x] Pencabutan consent
- [x] Kadaluarsa consent
- [x] Audit trail consent

#### Task Breakdown
- [ ] Desain sistem consent (4 jam)
- [ ] Implementasi penyimpanan consent (4 jam)
- [ ] Buat UI consent (5 jam)
- [ ] Tambahkan pencabutan (3 jam)
- [ ] Implementasi kadaluarsa (3 jam)
- [ ] Tulis tests (4 jam)

**Total Estimasi**: 23 jam

**Implementation Notes**:
- Service: `ConsentService.ts` - Previously implemented in Step 6
- Components: `ConsentManager.tsx` - Grant/deny consent UI
- Screen: `ConsentListScreen.tsx` - View and manage all consents
- Features: Remember consent, configurable expiry (1/7/30/90 days), revocation
- Privacy: Audit trail, usage tracking, secure local storage
- UI: Beautiful consent prompt with scope display and privacy notices

---

### US-4.9: Template Presentasi
**Sebagai** pengguna  
**Saya ingin** template presentasi yang tersimpan  
**Sehingga** saya dapat dengan cepat membagikan set klaim umum

**Story Points**: 8  
**Prioritas**: Could Have  
**Assignee**: React Native Developer 2

#### Kriteria Penerimaan
- [x] Pembuatan template
- [x] Penyimpanan template
- [x] Pemilihan template
- [x] Pengeditan template
- [x] Berbagi template (opsional)

#### Task Breakdown
- [ ] Desain sistem template (3 jam)
- [ ] Implementasi penyimpanan template (4 jam)
- [ ] Buat UI template (5 jam)
- [ ] Tambahkan kemampuan editing (4 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 19 jam

**Implementation Notes**:
- Service: `TemplateService.ts` - Full CRUD operations for templates
- Component: `TemplateManager.tsx` - Template list and management
- Features: Create, edit, delete templates, set default per credential type
- Storage: AsyncStorage with per-type defaults
- Modal: `CreateTemplateModal` - Create new templates with validation
- Use cases: Quick presentation of common claim sets (e.g., KYC basic, Full profile)
- Analytics: Usage tracking per template

---

## 📈 Ringkasan Sprint

**Total Story Points**: 92 SP  
**Kapasitas yang Direncanakan**: 90 SP  
**Tujuan Sprint**: ✅ Kemampuan presentasi lanjutan

---

## 🎯 Deliverables Kunci

- ✅ Dukungan SD-JWT untuk selective disclosure
- ✅ Tanda tangan BBS+ untuk ZKP
- ✅ Presentation Exchange v2 yang ditingkatkan
- ✅ UI disclosure lanjutan
- ✅ Manajemen consent
- ✅ Riwayat & template presentasi

---

## 🧪 Kriteria Penerimaan Sprint

Sprint 4 dianggap berhasil ketika:

- [ ] ✅ Semua 9 user stories selesai dan diuji
- [ ] ✅ SD-JWT berfungsi dengan selective disclosure
- [ ] ✅ BBS+ credentials dapat diverifikasi
- [ ] ✅ PEx v2 menangani constraint kompleks
- [ ] ✅ UI disclosure intuitif dan informatif
- [ ] ✅ Consent management berfungsi
- [ ] ✅ Tidak ada bug kritis
- [ ] ✅ Code review selesai
- [ ] ✅ Dokumentasi lengkap
- [ ] ✅ Demo kepada Product Owner berhasil

---

## 📅 Timeline Sprint 4

**Minggu 13-16**: Pelaksanaan Sprint

**Sprint Planning** (4 jam)
- Review spesifikasi SD-JWT dan BBS+
- Technical architecture discussion
- Task breakdown dan estimasi

**Daily Standup** (15 menit/hari)
- Progress update
- Technical challenges
- Blocker resolution

**Sprint Review** (2.5 jam)
- Demo selective disclosure
- Demo predicate proofs
- Stakeholder feedback

**Sprint Retrospective** (1.5 jam)
- Technical complexity review
- Process improvements

---

## 🛠️ Teknologi & Dependencies

### SSI & Cryptography
- **@sphereon/ssi-sdk-credential**: Credential operations
- **@sphereon/sd-jwt**: SD-JWT implementation
- **@mattrglobal/bbs-signatures**: BBS+ signatures
- **@sphereon/presentation-exchange**: PEx v2

### UI Components
- **React Native Paper**: UI components
- **React Native Reanimated**: Animations
- **React Native Gesture Handler**: Gestures

### Storage
- **@react-native-async-storage/async-storage**: Local storage
- **expo-secure-store**: Secure storage

---

## 📚 Dokumentasi

### Dokumen yang Harus Dibuat
- [ ] Panduan SD-JWT implementation
- [ ] Dokumentasi BBS+ signatures
- [ ] Presentation Exchange v2 guide
- [ ] Selective disclosure user guide
- [ ] Consent management documentation
- [ ] Template system guide

---

## 🔗 Referensi

### Spesifikasi
- **SD-JWT**: https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/
- **BBS+ Signatures**: https://identity.foundation/bbs-signature/draft-irtf-cfrg-bbs-signatures.html
- **Presentation Exchange v2**: https://identity.foundation/presentation-exchange/spec/v2.0.0/

### Research Papers
- **Zero-Knowledge Proofs**
- **Selective Disclosure Techniques**
- **Privacy-Preserving Credentials**

---

## 💬 Mendapatkan Bantuan

### Dukungan Internal
- **Isu Cryptography**: Hubungi SSI Specialist
- **Isu SD-JWT/BBS+**: SSI Specialist
- **Isu UI/UX**: UI/UX Designer
- **Pertanyaan Teknis**: #technical Slack channel

---

## ✅ Definition of Done

- [ ] Code complete dan di-merge
- [ ] Unit tests > 80% coverage
- [ ] Cryptographic operations divalidasi
- [ ] Code review approved
- [ ] Dokumentasi lengkap
- [ ] Diuji di iOS dan Android
- [ ] Performance acceptable
- [ ] Tidak ada bug kritis
- [ ] Demo dan accepted oleh PO

---

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: ✅ Siap untuk Eksekusi Sprint
