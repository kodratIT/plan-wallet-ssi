# Sprint 2: Manajemen Credential & Rendering OCA - Indeks Navigasi

## 📚 Selamat Datang!

Ini adalah dokumentasi lengkap untuk **Sprint 2: Credential Manifest & OCA Rendering** - Sphereon SSI Wallet.

Sprint 2 fokus pada **manajemen credential yang ditingkatkan**: implementasi Credential Manifest, rendering OCA yang indah, organisasi credential, pencarian, dan fitur berbagi credential.

---

## 🗂️ Struktur Dokumentasi

```
Sprint-2_Credential-Management/
├── INDEX.md                    📍 File ini - Panduan navigasi
├── README.md                   ⭐ START HERE - Overview & user stories
├── SETUP-GUIDE.md              🔧 Setup & implementasi guide
├── SUMMARY.md                  📊 Quick summary & cheat sheet
└── diagrams/                   📐 C4 UML Diagrams (5 files)
    ├── 01-credential-context.puml         Konteks manajemen credential
    ├── 02-credential-architecture.puml    Arsitektur komponen credential
    ├── 03-credential-manifest-flow.puml   Alur Credential Manifest
    ├── 04-oca-rendering-flow.puml         Alur OCA rendering
    └── 05-credential-lifecycle.puml       Lifecycle credential lengkap
```

---

## 🎯 Mulai Dari Mana?

### 👉 Saya Baru Join Sprint 2
**Start Here** → [README.md](./README.md)
1. Baca tujuan sprint
2. Review 10 user stories
3. Pahami kriteria penerimaan
4. Cek task breakdown

**Then** → [SUMMARY.md](./SUMMARY.md)
- Quick overview
- Key credential features
- Timeline sprint

### 👉 Saya Mau Implementasi Fitur Credential
**Follow This** → [SETUP-GUIDE.md](./SETUP-GUIDE.md)

**Pilih berdasarkan role:**
- **SSI Specialist**: Credential Manifest, OCA, registry
- **React Native Dev**: UI kartu, pencarian, organisasi
- **UI/UX Designer**: Desain kartu, layout, user experience
- **All Developers**: Credential best practices

**Step-by-step akan guide Anda:**
1. Setup credential libraries
2. Implementasi Credential Manifest
3. Implementasi OCA rendering
4. Implementasi UI kartu credential
5. Implementasi pencarian & filter
6. Testing credential flows

### 👉 Saya Mau Lihat Arsitektur Credential
**View Diagrams** → [diagrams/](./diagrams/)

**Recommended order:**
1. **[01-credential-context.puml](./diagrams/01-credential-context.puml)** - Konteks credential management
2. **[02-credential-architecture.puml](./diagrams/02-credential-architecture.puml)** - Arsitektur komponen
3. **[03-credential-manifest-flow.puml](./diagrams/03-credential-manifest-flow.puml)** - Credential Manifest flow
4. **[04-oca-rendering-flow.puml](./diagrams/04-oca-rendering-flow.puml)** - OCA rendering flow
5. **[05-credential-lifecycle.puml](./diagrams/05-credential-lifecycle.puml)** - Complete lifecycle

**Cara view diagrams:**
- Online: https://www.plantuml.com/plantuml/uml/
- VS Code: PlantUML extension, Alt+D
- Generate PNG: `plantuml *.puml`

### 👉 Saya Mau Quick Reference
**Go To** → [SUMMARY.md](./SUMMARY.md)
- Sprint overview
- Key deliverables
- Credential checklist
- Common commands

---

## 📖 Reading Guide by Role

### 🔐 SSI Specialist

**Your Focus**: Credential Manifest, OCA, presentation exchange, standards

**Reading Order**:
1. [README.md](./README.md) - Complete read untuk semua user stories
2. All diagrams ([diagrams/](./diagrams/)) - Arsitektur credential
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Implementation guidelines
4. [SUMMARY.md](./SUMMARY.md) - Quick reference

**Your Tasks Sprint 2**:
- **US-2.1**: Credential Manifest Protocol implementation
- **US-2.2**: OCA integration (dengan UI/UX Designer)
- **US-2.4**: Credential type registry
- **US-2.8**: Export/share via DIDComm

**Key Deliverables**:
- Credential Manifest parser & handler
- OCA bundle fetcher & renderer
- Credential type registry
- DIDComm sharing implementation

### 👨‍💻 React Native Developer 1

**Your Focus**: UI kartu, pencarian, detail views

**Reading Order**:
1. [README.md](./README.md) - Focus pada US-2.3, US-2.6, US-2.8
2. [diagrams/04-oca-rendering-flow.puml](./diagrams/04-oca-rendering-flow.puml)
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - UI implementation
4. [SUMMARY.md](./SUMMARY.md) - Quick reference

**Your Tasks Sprint 2**:
- **US-2.3**: Enhanced credential card UI (dengan UI/UX Designer)
- **US-2.6**: Search & filter implementation
- **US-2.8**: Export/share functionality
- **US-2.10**: Activity history

**Key Deliverables**:
- Beautiful credential cards dengan animations
- Full-text search & filtering
- Export ke JSON/QR/PDF
- Activity timeline UI

### 👨‍💻 React Native Developer 2

**Your Focus**: Kategorisasi, detail view, favorites

**Reading Order**:
1. [README.md](./README.md) - Focus pada US-2.5, US-2.7, US-2.9
2. [diagrams/05-credential-lifecycle.puml](./diagrams/05-credential-lifecycle.puml)
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md)

**Your Tasks Sprint 2**:
- **US-2.2**: OCA rendering UI (dengan UI/UX Designer & SSI Specialist)
- **US-2.5**: Categories & organization
- **US-2.7**: Credential details view (dengan UI/UX Designer)
- **US-2.9**: Favorites functionality

**Key Deliverables**:
- OCA-based credential rendering
- Category management UI
- Detailed credential view
- Favorites system

### 🎨 UI/UX Designer

**Your Focus**: Credential card design, layouts, user experience

**Reading Order**:
1. [README.md](./README.md) - US-2.2, US-2.3, US-2.7
2. [diagrams/](./diagrams/) - All untuk understand flows
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Design guidelines

**Your Tasks Sprint 2**:
- **US-2.2**: OCA overlay design
- **US-2.3**: Design beautiful credential cards
- **US-2.7**: Design detail view
- Review credential UX untuk all features

**Key Deliverables**:
- Credential card mockups (multiple layouts)
- OCA template designs
- Detail view designs
- Credential list/grid layouts

### 🧪 QA Engineer

**Your Focus**: Credential testing, interoperability

**Reading Order**:
1. [README.md](./README.md) - All user stories
2. [diagrams/](./diagrams/) - Understand credential flows
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Testing guidelines

**Your Tasks Sprint 2**:
- Test Credential Manifest dengan multiple issuers
- Test OCA rendering dengan various credentials
- Test search & filter performance
- Test export/share functionality
- Interoperability testing

**Key Deliverables**:
- Credential test cases
- Interoperability test report
- Performance test results
- Bug reports

### 📊 Product Owner

**Your Focus**: Sprint progress, acceptance, demo preparation

**Reading Order**:
1. [SUMMARY.md](./SUMMARY.md) - Quick overview
2. [README.md](./README.md) - User stories & acceptance criteria
3. Sprint board untuk track progress

**Your Tasks Sprint 2**:
- Review completed user stories
- Accept/reject deliverables
- Prioritize bugs
- Prepare Sprint 3 backlog
- Coordinate dengan issuers untuk testing

---

## ✅ Sprint 2 Checklist

### Week 5: Credential Manifest & OCA (39 SP)
- [ ] US-2.1: Credential Manifest implemented (13 SP)
- [ ] US-2.2: OCA integration implemented (13 SP)
- [ ] US-2.3: Enhanced card UI implemented (13 SP)
- [ ] Test dengan demo issuers

### Week 6: Organization & Search (24 SP)
- [ ] US-2.4: Credential registry implemented (8 SP)
- [ ] US-2.5: Categories & organization implemented (8 SP)
- [ ] US-2.6: Search & filter implemented (8 SP)
- [ ] Performance testing

### Week 7: Details & Export (24 SP)
- [ ] US-2.7: Detail view implemented (8 SP)
- [ ] US-2.8: Export/share implemented (8 SP)
- [ ] US-2.10: Activity history implemented (8 SP)
- [ ] Integration testing

### Week 8: Polish & Testing (5 SP + Testing)
- [ ] US-2.9: Favorites implemented (5 SP)
- [ ] All features tested
- [ ] Bug fixing
- [ ] Sprint review & demo
- [ ] Sprint retrospective

---

## 📋 Key Information At A Glance

### Sprint Goals
**Primary**: Enhanced credential management dengan Credential Manifest & OCA
**Secondary**: Beautiful UI dan user-friendly credential organization

### Story Points
- **Total**: 92 SP
- **Planned Capacity**: 90 SP
- **Team Size**: 6-8 developers

### Timeline
- **Duration**: 4 weeks (Week 5-8)
- **Sprint Planning**: Week 4 end (4 jam)
- **Daily Standups**: 15 menit/hari
- **Sprint Review**: Week 8 (2.5 jam)
- **Sprint Retrospective**: Week 8 (1.5 jam)

### Credential Libraries
```json
{
  "@sphereon/ssi-sdk-credential": "^0.9.0",
  "@sphereon/oid4vci-client": "^0.6.0",
  "@sphereon/presentation-exchange": "^3.0.0",
  "@sphereon/oca": "^1.0.0",
  "fuse.js": "^6.6.2",
  "react-native-fs": "^2.20.0",
  "react-native-share": "^9.0.0",
  "react-native-pdf": "^6.7.0"
}
```

### Key Components
```
src/
├── services/
│   ├── credential/
│   │   ├── CredentialManifest.ts     # Manifest handler
│   │   ├── OCARenderer.ts            # OCA rendering
│   │   ├── CredentialRegistry.ts     # Type registry
│   │   └── CredentialSearch.ts       # Search & filter
│   └── export/
│       └── CredentialExport.ts       # Export functionality
├── components/
│   └── credential/
│       ├── CredentialCard.tsx        # Card component
│       ├── CredentialList.tsx        # List view
│       ├── CredentialDetail.tsx      # Detail view
│       └── CredentialSearch.tsx      # Search UI
└── screens/
    └── credentials/
        └── CredentialsScreen.tsx     # Main screen
```

---

## 📦 Credential Manifest Overview

### Credential Manifest Protocol
- **Purpose**: Describe credential requirements
- **Components**:
  - Presentation Definition
  - Output Descriptors
  - Credential Application
  - Credential Response

### Example Manifest
```json
{
  "credential_manifest": {
    "id": "university-degree-manifest",
    "issuer": {
      "id": "did:web:university.edu",
      "name": "University of Example"
    },
    "output_descriptors": [
      {
        "id": "degree-output",
        "schema": "UniversityDegreeCredential",
        "display": {
          "title": {
            "text": "University Degree"
          },
          "subtitle": {
            "text": "Bachelor of Science"
          }
        }
      }
    ]
  }
}
```

---

## 🎨 OCA (Overlay Capture Architecture) Overview

### OCA Layers
1. **Capture Base**: Core schema
2. **Character Encoding**: Text encoding
3. **Format**: Data formatting
4. **Label**: Display labels
5. **Information**: Help text
6. **Entry Code**: Coded entries
7. **Branding**: Visual branding

### Example OCA Bundle
```json
{
  "bundle": {
    "capture_base": {
      "type": "spec/capture_base/1.0",
      "classification": "UniversityDegree",
      "attributes": {
        "name": "Text",
        "degree": "Text",
        "year": "Numeric"
      }
    },
    "overlays": {
      "label": {
        "attribute_labels": {
          "name": "Full Name",
          "degree": "Degree Type",
          "year": "Graduation Year"
        }
      },
      "branding": {
        "logo": "https://university.edu/logo.png",
        "background_color": "#003366",
        "primary_color": "#FFFFFF"
      }
    }
  }
}
```

---

## 🐛 Common Credential Issues & Solutions

### Issue: Credential Manifest Parsing Error
```typescript
// Solution: Validate manifest structure
const validateManifest = (manifest: any): boolean => {
  return (
    manifest.credential_manifest &&
    manifest.credential_manifest.id &&
    manifest.credential_manifest.output_descriptors &&
    Array.isArray(manifest.credential_manifest.output_descriptors)
  );
};
```

### Issue: OCA Bundle Not Available
```typescript
// Solution: Fallback to default rendering
const renderCredential = async (credential: any) => {
  try {
    const oca = await fetchOCABundle(credential.type);
    return renderWithOCA(credential, oca);
  } catch (error) {
    console.warn('OCA not available, using default rendering');
    return renderDefault(credential);
  }
};
```

### Issue: Search Performance Slow
```typescript
// Solution: Use indexing and debouncing
import Fuse from 'fuse.js';

const fuse = new Fuse(credentials, {
  keys: ['credentialSubject.name', 'type', 'issuer'],
  threshold: 0.3
});

// Debounce search
const debouncedSearch = debounce((query) => {
  const results = fuse.search(query);
  setSearchResults(results);
}, 300);
```

---

## 🔗 External Resources

### Standards
- **Credential Manifest**: https://identity.foundation/credential-manifest/
- **OCA Specification**: https://oca.colossi.network/
- **Presentation Exchange**: https://identity.foundation/presentation-exchange/

### Sphereon Libraries
- **@sphereon/ssi-sdk**: https://github.com/Sphereon-Opensource/ssi-sdk
- **@sphereon/oca**: https://github.com/Sphereon-Opensource/oca-ts

### Design Resources
- **Material Design**: https://m3.material.io/
- **iOS HIG**: https://developer.apple.com/design/human-interface-guidelines/

---

## 📞 Getting Help

### Internal Support
- **SSI Issues**: SSI Specialist
- **Implementation Questions**: #technical Slack channel
- **UI/UX Questions**: UI/UX Designer
- **Sprint Questions**: Scrum Master

### External Support
- **Sphereon**: Discord #mobile-wallet
- **Stack Overflow**: tag `verifiable-credentials`

---

## 🎯 Success Criteria

Sprint 2 is **SUCCESSFUL** when:

- ✅ **All 10 user stories** completed dan tested
- ✅ **Credential Manifest** working dengan issuers
- ✅ **OCA rendering** displaying beautiful credentials
- ✅ **Search & filter** working smoothly
- ✅ **Export/share** working di semua format
- ✅ **No critical bugs**
- ✅ **Code review** completed
- ✅ **Demo** successful kepada Product Owner

---

## 📈 Next Steps After Sprint 2

1. ✅ Credential management ready → Start Sprint 3
2. 📖 Read Sprint 3: DIDComm v2 & Messaging
3. 🏃 Continue daily standups
4. 💻 Implement messaging features
5. 🔄 Sprint 3 review & retrospective

---

**Status**: ✅ Ready for Implementation  
**Version**: 1.0  
**Last Updated**: 2024

---

## 🚀 Ready to Start?

1. Read [README.md](./README.md) untuk full overview
2. Follow [SETUP-GUIDE.md](./SETUP-GUIDE.md) untuk implementation
3. Check [SUMMARY.md](./SUMMARY.md) untuk quick reference
4. View [diagrams/](./diagrams/) untuk architecture understanding

**Good luck dengan implementasi credential features! 🎨**
