# Sprint 2: Manajemen Credential & Rendering OCA - Ringkasan Cepat

## 📊 Overview

**Sprint**: Sprint 2 (Credential Management)  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Story Points**: 92 SP  
**Prioritas**: TINGGI - Enhanced credential management

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan dukungan Credential Manifest dan rendering credential yang indah dengan OCA."*

### Objectives
1. ✅ Credential Manifest protocol
2. ✅ OCA (Overlay Capture Architecture) rendering
3. ✅ Enhanced credential card UI
4. ✅ Credential type registry
5. ✅ Categories & organization
6. ✅ Search & filter functionality
7. ✅ Detailed credential views
8. ✅ Export & share capabilities
9. ✅ Activity history tracking
10. ✅ Favorites system

---

## 📋 User Stories Summary

| ID | User Story | Story Points | Prioritas | Assignee |
|----|-----------|--------------|-----------|----------|
| US-2.1 | Credential Manifest Protocol | 13 | Must Have | SSI Specialist + RN Dev 1 |
| US-2.2 | OCA Integration | 13 | Must Have | UI/UX Designer + RN Dev 2 |
| US-2.3 | Enhanced Credential Card UI | 13 | Must Have | UI/UX Designer + RN Dev 1 |
| US-2.4 | Credential Type Registry | 8 | Should Have | SSI Specialist |
| US-2.5 | Categories & Organization | 8 | Should Have | React Native Dev 2 |
| US-2.6 | Search & Filter | 8 | Should Have | React Native Dev 1 |
| US-2.7 | Credential Details View | 8 | Must Have | UI/UX Designer + RN Dev 2 |
| US-2.8 | Export/Share Credential | 8 | Should Have | React Native Dev 1 |
| US-2.9 | Credential Favorites | 5 | Could Have | React Native Dev 2 |
| US-2.10 | Activity History | 8 | Should Have | React Native Dev 1 |

**Total**: 92 Story Points

---

## 🔑 Key Deliverables

### 1. Credential Manifest (US-2.1)
- Credential Manifest parser
- Output descriptors handler
- Presentation Definition integration
- Credential Application generation
- Credential Response handling

### 2. OCA Rendering (US-2.2)
- OCA bundle fetcher
- Branding overlay renderer
- Label overlay renderer
- Format overlay renderer
- Custom credential templates

### 3. Enhanced Card UI (US-2.3)
- Beautiful credential cards
- Multiple card layouts
- Animated card flip (front/back)
- Issuer logo display
- Status badges
- Graphical elements

### 4. Credential Registry (US-2.4)
- Registry of known credential types
- Schema registry integration
- Type detection logic
- Custom type registration
- Type metadata management

### 5. Organization System (US-2.5, US-2.6, US-2.9)
- Auto-categorization
- Manual category assignment
- Full-text search
- Advanced filtering
- Favorites system
- Search history

### 6. Details & Export (US-2.7, US-2.8)
- Comprehensive detail view
- Issuer information display
- Metadata display
- Export to JSON
- Export to QR code
- Export to PDF
- Share via DIDComm
- Native sharing

### 7. Activity Tracking (US-2.10)
- Per-credential activity log
- Timeline view
- Issuance logging
- Presentation logging
- Export activity log

---

## 🛠️ Tech Stack & Dependencies

### Credential Libraries
```json
{
  "@sphereon/ssi-sdk-credential": "^0.9.0",
  "@sphereon/oid4vci-client": "^0.6.0",
  "@sphereon/presentation-exchange": "^3.0.0",
  "@sphereon/oca": "^1.0.0",
  "@sphereon/ssi-types": "^0.9.0"
}
```

### UI & Search Libraries
```json
{
  "react-native-paper": "^5.10.0",
  "react-native-reanimated": "^3.5.0",
  "react-native-svg": "^13.14.0",
  "fuse.js": "^6.6.2"
}
```

### Export & Share Libraries
```json
{
  "react-native-fs": "^2.20.0",
  "react-native-share": "^9.0.0",
  "react-native-pdf": "^6.7.0",
  "react-native-qrcode-svg": "^6.2.0"
}
```

### Installation
```bash
# Sphereon SSI libraries
npm install @sphereon/ssi-sdk-credential @sphereon/oid4vci-client
npm install @sphereon/presentation-exchange @sphereon/oca

# UI libraries
npm install react-native-paper react-native-reanimated
npm install react-native-svg

# Search & utility
npm install fuse.js

# Export & share
npm install react-native-fs react-native-share
npm install react-native-pdf react-native-qrcode-svg
```

---

## 📅 Sprint Timeline

### Week 5: Credential Manifest & OCA (39 SP)
**Days 1-2**: Setup & Architecture
- [ ] Credential libraries installation
- [ ] Credential architecture design
- [ ] Documentation start

**Days 3-5**: Core Implementation
- [ ] US-2.1: Credential Manifest (13 SP)
- [ ] US-2.2: OCA Integration (13 SP)
- [ ] US-2.3: Enhanced Card UI (13 SP)
- [ ] Test dengan demo issuers

### Week 6: Organization & Search (24 SP)
**Days 1-2**: Registry & Categories
- [ ] US-2.4: Credential Registry (8 SP)
- [ ] US-2.5: Categories & Organization (8 SP)

**Days 3-5**: Search & Filter
- [ ] US-2.6: Search & Filter (8 SP)
- [ ] Performance optimization
- [ ] Integration testing

### Week 7: Details & Export (24 SP)
**Days 1-2**: Detail Views
- [ ] US-2.7: Detail View (8 SP)
- [ ] Metadata display
- [ ] Actions implementation

**Days 3-5**: Export & History
- [ ] US-2.8: Export/Share (8 SP)
- [ ] US-2.10: Activity History (8 SP)
- [ ] Export testing (JSON, QR, PDF)

### Week 8: Polish & Testing (5 SP + Testing)
**Days 1-2**: Favorites & Polish
- [ ] US-2.9: Favorites (5 SP)
- [ ] UI polish
- [ ] Animation refinement

**Days 3-4**: Testing & Bug Fixing
- [ ] Integration testing
- [ ] Interoperability testing
- [ ] Bug fixes

**Day 5**: Review & Retrospective
- [ ] Sprint review demo
- [ ] Retrospective
- [ ] Sprint 3 planning prep

---

## 📦 Credential Manifest Quick Reference

### Structure
```json
{
  "credential_manifest": {
    "id": "credential-manifest-id",
    "version": "0.1.0",
    "issuer": {
      "id": "did:example:issuer",
      "name": "Example Issuer"
    },
    "output_descriptors": [
      {
        "id": "output-descriptor-id",
        "schema": "CredentialType",
        "display": {
          "title": { "text": "Credential Title" },
          "subtitle": { "text": "Credential Subtitle" },
          "description": { "text": "Description" }
        }
      }
    ],
    "presentation_definition": {
      "id": "presentation-definition-id",
      "input_descriptors": [...]
    }
  }
}
```

### Key Operations
```typescript
// Parse manifest
const manifest = CredentialManifestService.parse(manifestJson);

// Get output descriptors
const outputs = manifest.output_descriptors;

// Generate application
const application = CredentialManifestService.createApplication(
  manifest,
  presentationSubmission
);

// Handle credential response
const credential = CredentialManifestService.handleResponse(response);
```

---

## 🎨 OCA Quick Reference

### OCA Bundle Structure
```json
{
  "bundle": {
    "capture_base": {
      "type": "spec/capture_base/1.0",
      "classification": "CredentialType",
      "attributes": { ... }
    },
    "overlays": {
      "character_encoding": { ... },
      "format": { ... },
      "label": { ... },
      "information": { ... },
      "branding": {
        "logo": "url",
        "background_color": "#hex",
        "primary_color": "#hex",
        "secondary_color": "#hex"
      }
    }
  }
}
```

### OCA Rendering
```typescript
// Fetch OCA bundle
const bundle = await OCAService.fetchBundle(credentialType);

// Apply overlays
const rendered = OCAService.render(credential, bundle);

// Get branding
const branding = OCAService.getBranding(bundle);

// Get labels
const labels = OCAService.getLabels(bundle, language);
```

---

## 📚 Key Commands & Code Snippets

### Credential Card Component
```typescript
import { CredentialCard } from '@/components/credential/CredentialCard';

<CredentialCard
  credential={credential}
  onPress={() => navigateToDetail(credential)}
  onLongPress={() => showActions(credential)}
  style="card"  // or "compact", "list"
/>
```

### Search Implementation
```typescript
import Fuse from 'fuse.js';

const fuse = new Fuse(credentials, {
  keys: [
    'credentialSubject.name',
    'type',
    'issuer.name',
    'credentialSubject.description'
  ],
  threshold: 0.3,
  includeScore: true
});

const results = fuse.search(query);
```

### Export to QR
```typescript
import QRCode from 'react-native-qrcode-svg';

<QRCode
  value={JSON.stringify(credential)}
  size={300}
  backgroundColor="white"
  color="black"
/>
```

### Export to PDF
```typescript
import { exportCredentialToPDF } from '@/services/export/CredentialExport';

const pdfPath = await exportCredentialToPDF(credential, {
  includeQR: true,
  includeIssuerInfo: true,
  template: 'professional'
});
```

---

## ✅ Acceptance Criteria Checklist

### US-2.1: Credential Manifest
- [ ] Manifest parsing working
- [ ] Output descriptors handled
- [ ] Presentation Definition integrated
- [ ] Application generation working
- [ ] Response handling implemented
- [ ] Tested dengan multiple issuers

### US-2.2: OCA Integration
- [ ] OCA bundle fetching
- [ ] All overlays applied correctly
- [ ] Branding displayed
- [ ] Labels displayed
- [ ] Format overlay working
- [ ] Custom templates created

### US-2.3: Enhanced Card UI
- [ ] Beautiful card design
- [ ] Multiple layouts available
- [ ] Card flip animation smooth
- [ ] Issuer logo displayed
- [ ] Status badges shown
- [ ] Tested di iOS & Android

### US-2.4: Credential Registry
- [ ] Registry implemented
- [ ] Type detection working
- [ ] Schema integration
- [ ] Custom registration
- [ ] Metadata management

### US-2.5: Categories
- [ ] Auto-categorization working
- [ ] Manual assignment
- [ ] Category filtering
- [ ] Custom categories
- [ ] Category views

### US-2.6: Search & Filter
- [ ] Full-text search fast
- [ ] Search by issuer
- [ ] Search by type
- [ ] Filter by status
- [ ] Filter by date
- [ ] Search history

### US-2.7: Detail View
- [ ] All attributes displayed
- [ ] Issuer info shown
- [ ] Issuance date shown
- [ ] Expiry date shown (if any)
- [ ] Revocation status checked
- [ ] Actions available

### US-2.8: Export/Share
- [ ] Export to JSON
- [ ] Export to QR
- [ ] Export to PDF
- [ ] Share via DIDComm
- [ ] Native sharing
- [ ] All formats tested

### US-2.9: Favorites
- [ ] Star/favorite button
- [ ] Favorites list view
- [ ] Quick access from home
- [ ] Reordering works
- [ ] Sync with backup

### US-2.10: Activity History
- [ ] Activity logging working
- [ ] All events logged
- [ ] Timeline display
- [ ] Export functionality
- [ ] Privacy compliant

---

## 🧪 Testing Checklist

### Unit Tests
- [ ] Credential Manifest parser tests
- [ ] OCA renderer tests
- [ ] Search algorithm tests
- [ ] Export functionality tests
- [ ] Category logic tests

### Integration Tests
- [ ] End-to-end credential issuance
- [ ] OCA rendering flow
- [ ] Search and filter flow
- [ ] Export flow (all formats)

### Interoperability Tests
- [ ] Test dengan Sphereon demo issuer
- [ ] Test dengan Walt.id issuer
- [ ] Test dengan Mattr issuer
- [ ] Test dengan Microsoft Entra
- [ ] Test various credential types

### UI Tests
- [ ] Card rendering tests
- [ ] Animation tests
- [ ] Search UI tests
- [ ] Detail view tests
- [ ] Export UI tests

---

## 🐛 Common Issues & Solutions

### Issue: Credential Manifest Not Found
```typescript
// Solution: Fallback ke basic credential display
const renderCredential = async (credential) => {
  try {
    const manifest = await fetchManifest(credential.issuer);
    return renderWithManifest(credential, manifest);
  } catch (error) {
    console.warn('Manifest not found, using basic rendering');
    return renderBasic(credential);
  }
};
```

### Issue: OCA Bundle 404
```typescript
// Solution: Graceful degradation
const getOCA = async (type: string) => {
  try {
    return await OCAService.fetchBundle(type);
  } catch (error) {
    // Use default styling
    return createDefaultOCA(type);
  }
};
```

### Issue: Large Credential List Performance
```typescript
// Solution: Virtualized list + pagination
import { FlashList } from '@shopify/flash-list';

<FlashList
  data={credentials}
  renderItem={({ item }) => <CredentialCard credential={item} />}
  estimatedItemSize={200}
  onEndReached={loadMore}
/>
```

### Issue: PDF Export Fails
```typescript
// Solution: Check permissions and fallback
const exportPDF = async (credential) => {
  try {
    // Check storage permission
    const hasPermission = await checkPermission();
    if (!hasPermission) {
      const granted = await requestPermission();
      if (!granted) throw new Error('Permission denied');
    }
    
    return await generatePDF(credential);
  } catch (error) {
    // Fallback ke JSON export
    console.error('PDF export failed, using JSON');
    return exportJSON(credential);
  }
};
```

---

## 📊 Sprint Metrics

### Velocity
- **Planned**: 92 SP
- **Team Capacity**: 90 SP
- **Utilization**: 102% (slightly over)

### Team Allocation
- SSI Specialist: 3 user stories (34 SP)
- React Native Dev 1: 4 user stories (37 SP)
- React Native Dev 2: 4 user stories (34 SP)
- UI/UX Designer: 3 user stories (34 SP)

### Time Estimates
- Development: 125 jam (78%)
- Testing: 20 jam (12%)
- Documentation: 15 jam (10%)

---

## 🔗 Resources

### Internal Docs
- [README.md](./README.md) - Full documentation
- [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Implementation guide
- [diagrams/](./diagrams/) - Architecture diagrams

### External Resources
- Credential Manifest: https://identity.foundation/credential-manifest/
- OCA Specification: https://oca.colossi.network/
- Presentation Exchange: https://identity.foundation/presentation-exchange/
- Sphereon SDK: https://github.com/Sphereon-Opensource/ssi-sdk

### Demo Issuers
- Sphereon Demo: https://ssi.sphereon.com/demo/issuer/
- Walt.id: https://walt.id/
- Mattr: https://launchpad.mattrlabs.com/

---

## 📞 Contact

### Internal Support
- **SSI**: SSI Specialist
- **Technical**: #technical Slack
- **Sprint**: Scrum Master

### External Support
- **Sphereon**: Discord #mobile-wallet
- **Credential Manifest**: DIF Slack

---

## 🎯 Definition of Done

Sprint 2 selesai ketika:

- ✅ 10 user stories completed
- ✅ All acceptance criteria met
- ✅ Credential Manifest working
- ✅ OCA rendering beautiful
- ✅ Search & filter smooth
- ✅ Export working (all formats)
- ✅ Code review approved
- ✅ Tests passing (> 80% coverage)
- ✅ Documentation complete
- ✅ Demo successful
- ✅ No critical bugs
- ✅ Ready for Sprint 3

---

**Status**: ✅ Ready  
**Version**: 1.0  
**Updated**: 2024

**Let's build beautiful credential management! 🎨**
