# Sprint 2: Manajemen Credential & Rendering OCA

## 📋 Ringkasan Task

**Task**: Sprint 2 - Credential Manifest & OCA Rendering  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Prioritas**: TINGGI - Fitur manajemen credential yang ditingkatkan  
**Platform**: iOS & Android (React Native + Expo)

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan dukungan Credential Manifest dan rendering credential yang indah dengan OCA."*

---

## ✅ Objektif

Setelah menyelesaikan Sprint 2:

1. ✅ Protocol Credential Manifest diimplementasikan
2. ✅ Integrasi OCA untuk rendering credential yang indah
3. ✅ UI kartu credential yang ditingkatkan
4. ✅ Registry tipe credential tersedia
5. ✅ Kategori dan organisasi credential berfungsi
6. ✅ Fitur pencarian dan filter credential
7. ✅ Tampilan detail credential lengkap
8. ✅ Ekspor dan berbagi credential
9. ✅ Riwayat aktivitas credential terlacak

---

## 📊 User Stories

### US-2.1: Protocol Credential Manifest
**Sebagai** pengguna  
**Saya ingin** memahami persyaratan credential  
**Sehingga** saya tahu credential apa yang bisa saya dapatkan

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: SSI Specialist + React Native Dev 1

#### Kriteria Penerimaan
- [x] Parsing Credential Manifest
- [x] Penanganan output descriptors
- [x] Integrasi Presentation Definition
- [x] Pembuatan Credential Application
- [x] Penanganan Credential Response

#### Task Breakdown
- [ ] Pelajari spesifikasi Credential Manifest (4 jam)
- [ ] Implementasi parser manifest (8 jam)
- [ ] Implementasi output descriptors (6 jam)
- [ ] Integrasi dengan Presentation Exchange (6 jam)
- [ ] Implementasi pembuatan application (6 jam)
- [ ] Tangani credential response (5 jam)
- [ ] Tulis integration tests (6 jam)
- [ ] Dokumentasi implementasi (3 jam)

**Total Estimasi**: 44 jam

---

### US-2.2: Integrasi OCA (Overlay Capture Architecture)
**Sebagai** pengguna  
**Saya ingin** credential yang ter-render dengan indah  
**Sehingga** terlihat profesional

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: UI/UX Designer + React Native Dev 2

#### Kriteria Penerimaan
- [x] Pengambilan OCA bundle
- [x] Branding overlay diterapkan
- [x] Label overlay diterapkan
- [x] Format overlay diterapkan
- [x] Character encoding overlay
- [x] Desain credential kustom

#### Task Breakdown
- [ ] Pelajari spesifikasi OCA (4 jam)
- [ ] Implementasi OCA bundle fetcher (6 jam)
- [ ] Terapkan branding overlays (6 jam)
- [ ] Terapkan label overlays (5 jam)
- [ ] Terapkan format overlays (5 jam)
- [ ] Buat template credential (8 jam)
- [ ] Test dengan berbagai credential (6 jam)
- [ ] Dokumentasi penggunaan OCA (3 jam)

**Total Estimasi**: 43 jam

---

### US-2.3: UI Kartu Credential yang Ditingkatkan
**Sebagai** pengguna  
**Saya ingin** kartu credential yang indah  
**Sehingga** wallet saya terlihat profesional

**Story Points**: 13  
**Prioritas**: Must Have  
**Assignee**: UI/UX Designer + React Native Dev 1

#### Kriteria Penerimaan
- [x] Tampilan kartu dengan branding
- [x] Kartu credential grafis
- [x] Tampilan logo issuer
- [x] Animasi flip kartu (depan/belakang)
- [x] Badge status credential
- [x] Multiple layout kartu

#### Task Breakdown
- [ ] Desain layout kartu credential (6 jam)
- [ ] Implementasi komponen kartu (8 jam)
- [ ] Tambahkan dukungan branding (5 jam)
- [ ] Implementasi animasi flip kartu (4 jam)
- [ ] Tambahkan status badges (3 jam)
- [ ] Buat multiple layouts (6 jam)
- [ ] Test rendering (4 jam)
- [ ] Tulis UI tests (4 jam)

**Total Estimasi**: 40 jam

---

### US-2.4: Registry Tipe Credential
**Sebagai** developer  
**Saya ingin** registry tipe credential  
**Sehingga** berbagai tipe credential didukung

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: SSI Specialist

#### Kriteria Penerimaan
- [x] Registry tipe credential yang dikenal
- [x] Integrasi schema registry
- [x] Logika deteksi tipe
- [x] Registrasi tipe kustom
- [x] Metadata tipe

#### Task Breakdown
- [ ] Desain struktur registry (3 jam)
- [ ] Implementasi credential registry (5 jam)
- [ ] Tambahkan integrasi schema (4 jam)
- [ ] Implementasi deteksi tipe (4 jam)
- [ ] Tambahkan registrasi kustom (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 22 jam

---

### US-2.5: Kategori & Organisasi Credential
**Sebagai** pengguna  
**Saya ingin** mengorganisir credential  
**Sehingga** saya dapat menemukannya dengan mudah

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 2

#### Kriteria Penerimaan
- [x] Kategorisasi otomatis
- [x] Penugasan kategori manual
- [x] Filter kategori
- [x] Kategori kustom
- [x] Tampilan berbasis kategori

#### Task Breakdown
- [ ] Desain sistem kategorisasi (3 jam)
- [ ] Implementasi auto-kategorisasi (5 jam)
- [ ] Tambahkan penugasan manual (4 jam)
- [ ] Implementasi filtering (4 jam)
- [ ] Buat tampilan kategori (4 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 23 jam

---

### US-2.6: Pencarian & Filter Credential
**Sebagai** pengguna  
**Saya ingin** mencari credential  
**Sehingga** saya dapat dengan cepat menemukan yang saya butuhkan

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Pencarian full-text
- [x] Pencarian berdasarkan issuer
- [x] Pencarian berdasarkan tipe
- [x] Filter berdasarkan status
- [x] Filter berdasarkan tanggal
- [x] Riwayat pencarian

#### Task Breakdown
- [ ] Implementasi indexing pencarian (5 jam)
- [ ] Buat UI pencarian (4 jam)
- [ ] Tambahkan opsi filter (4 jam)
- [ ] Implementasi riwayat pencarian (3 jam)
- [ ] Optimasi performa pencarian (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 22 jam

---

### US-2.7: Tampilan Detail Credential
**Sebagai** pengguna  
**Saya ingin** tampilan detail credential  
**Sehingga** saya dapat melihat semua informasi

**Story Points**: 8  
**Prioritas**: Must Have  
**Assignee**: UI/UX Designer + React Native Dev 2

#### Kriteria Penerimaan
- [x] Tampilan atribut detail
- [x] Informasi issuer
- [x] Tanggal/waktu penerbitan
- [x] Tanggal kadaluarsa (jika ada)
- [x] Status revokasi
- [x] Info schema credential
- [x] Actions (bagikan, hapus, ekspor)

#### Task Breakdown
- [ ] Desain UI detail (4 jam)
- [ ] Implementasi layar detail (6 jam)
- [ ] Tambahkan bagian info issuer (3 jam)
- [ ] Tambahkan bagian metadata (3 jam)
- [ ] Tambahkan tombol action (3 jam)
- [ ] Tulis UI tests (3 jam)

**Total Estimasi**: 22 jam

---

### US-2.8: Ekspor/Bagikan Credential
**Sebagai** pengguna  
**Saya ingin** mengekspor credential  
**Sehingga** saya dapat mem-backup atau membagikannya

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Ekspor sebagai JSON
- [x] Ekspor sebagai QR code
- [x] Ekspor sebagai PDF (presentasi)
- [x] Bagikan via DIDComm
- [x] Bagikan via email/messaging

#### Task Breakdown
- [ ] Implementasi ekspor JSON (3 jam)
- [ ] Implementasi ekspor QR (4 jam)
- [ ] Implementasi pembuatan PDF (6 jam)
- [ ] Tambahkan berbagi DIDComm (5 jam)
- [ ] Tambahkan berbagi native (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 24 jam

---

### US-2.9: Favorit Credential
**Sebagai** pengguna  
**Saya ingin** menandai favorit  
**Sehingga** saya dapat dengan cepat mengakses credential penting

**Story Points**: 5  
**Prioritas**: Could Have  
**Assignee**: React Native Developer 2

#### Kriteria Penerimaan
- [x] Tombol star/favorite
- [x] Tampilan daftar favorit
- [x] Akses cepat dari home
- [x] Urutan ulang favorit
- [x] Sinkronisasi favorit (jika backup diaktifkan)

#### Task Breakdown
- [ ] Tambahkan flag favorite ke data model (2 jam)
- [ ] Implementasi toggle favorite (3 jam)
- [ ] Buat tampilan favorit (4 jam)
- [ ] Tambahkan reordering (3 jam)
- [ ] Tulis tests (2 jam)

**Total Estimasi**: 14 jam

---

### US-2.10: Riwayat Aktivitas Credential
**Sebagai** pengguna  
**Saya ingin** melihat penggunaan credential  
**Sehingga** saya tahu kapan saya menggunakannya

**Story Points**: 8  
**Prioritas**: Should Have  
**Assignee**: React Native Developer 1

#### Kriteria Penerimaan
- [x] Log aktivitas per credential
- [x] Penerbitan dicatat
- [x] Presentasi dicatat
- [x] Update dicatat
- [x] Tampilan timeline
- [x] Ekspor log aktivitas

#### Task Breakdown
- [ ] Desain model data aktivitas (3 jam)
- [ ] Implementasi pelacakan aktivitas (5 jam)
- [ ] Buat UI timeline (5 jam)
- [ ] Tambahkan fungsionalitas ekspor (3 jam)
- [ ] Tulis tests (3 jam)

**Total Estimasi**: 19 jam

---

## 📈 Ringkasan Sprint

**Total Story Points**: 92 SP  
**Kapasitas yang Direncanakan**: 90 SP  
**Tujuan Sprint**: ✅ Manajemen credential yang ditingkatkan

---

## 🎯 Deliverables Kunci

- ✅ Dukungan Credential Manifest
- ✅ Rendering OCA untuk credential yang indah
- ✅ UI kartu credential yang ditingkatkan
- ✅ Organisasi & pencarian credential
- ✅ Kemampuan ekspor/bagikan credential
- ✅ Pelacakan riwayat aktivitas

---

## 🧪 Kriteria Penerimaan Sprint

Sprint 2 dianggap berhasil ketika:

- [ ] ✅ Semua 10 user stories selesai dan diuji
- [ ] ✅ Credential Manifest berfungsi dengan issuer
- [ ] ✅ OCA rendering menampilkan credential dengan indah
- [ ] ✅ Pencarian dan filter berfungsi lancar
- [ ] ✅ Ekspor/bagikan berfungsi di semua format
- [ ] ✅ Tidak ada bug kritis
- [ ] ✅ Code review selesai
- [ ] ✅ Dokumentasi lengkap
- [ ] ✅ UI tests lulus
- [ ] ✅ Demo kepada Product Owner berhasil

---

## 📅 Timeline Sprint 2

**Minggu 5-8**: Pelaksanaan Sprint

**Sprint Planning** (4 jam)
- Review backlog
- Estimasi story points
- Breakdown tasks
- Komitmen tim

**Daily Standup** (15 menit/hari)
- Update progress
- Identifikasi blocker
- Koordinasi tim

**Sprint Review** (2.5 jam)
- Demo fitur baru
- Feedback stakeholders
- Update backlog

**Sprint Retrospective** (1.5 jam)
- Evaluasi sprint
- Action items perbaikan

---

## 🛠️ Teknologi & Dependencies

### SSI & Credentials
- **@sphereon/ssi-sdk-credential**: Operasi credential
- **@sphereon/oid4vci-client**: OpenID4VCI client
- **@sphereon/presentation-exchange**: Presentation Exchange

### UI Components
- **React Native Paper**: Material Design components
- **React Native Reanimated**: Animasi kartu
- **React Native SVG**: Rendering grafis

### Data & Search
- **fuse.js**: Fuzzy search
- **react-native-fs**: File system
- **react-native-share**: Berbagi native

### PDF Generation
- **react-native-pdf**: PDF viewer
- **@react-pdf/renderer**: PDF generation (jika diperlukan)

---

## 📚 Dokumentasi

### Dokumen yang Harus Dibuat
- [ ] Panduan Credential Manifest
- [ ] Dokumentasi integrasi OCA
- [ ] Panduan desain kartu credential
- [ ] API dokumentasi registry credential
- [ ] Panduan pengguna pencarian dan organisasi
- [ ] Tutorial ekspor dan berbagi

---

## 🔗 Referensi

### Spesifikasi
- **Credential Manifest**: https://identity.foundation/credential-manifest/
- **OCA Specification**: https://oca.colossi.network/
- **Presentation Exchange**: https://identity.foundation/presentation-exchange/

### Design Resources
- **Credential Design Patterns**
- **Material Design Guidelines**
- **iOS Human Interface Guidelines**

---

## 💬 Mendapatkan Bantuan

### Dukungan Internal
- **Isu SSI**: Hubungi SSI Specialist
- **Isu UI/UX**: Hubungi UI/UX Designer
- **Pertanyaan Teknis**: #technical Slack channel

---

## ✅ Definition of Done

- [ ] Code complete dan di-merge
- [ ] Unit tests > 80% coverage
- [ ] Integration tests lulus
- [ ] Code review approved
- [ ] Dokumentasi lengkap
- [ ] Diuji di iOS dan Android
- [ ] Tidak ada bug kritis
- [ ] Demo dan accepted oleh PO

---

**Versi Dokumen**: 1.0  
**Terakhir Diperbarui**: 2024  
**Status**: ✅ Siap untuk Eksekusi Sprint
