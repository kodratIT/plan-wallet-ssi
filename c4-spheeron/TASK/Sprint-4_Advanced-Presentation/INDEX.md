# Sprint 4: Presentasi Lanjutan & Selective Disclosure - Indeks Navigasi

## 📚 Selamat Datang!

Ini adalah dokumentasi lengkap untuk **Sprint 4: Advanced Presentation & Selective Disclosure** - Sphereon SSI Wallet.

Sprint 4 fokus pada **kemampuan presentasi lanjutan**: SD-JWT (Selective Disclosure JWT), BBS+ signatures untuk zero-knowledge proofs, Presentation Exchange v2, advanced disclosure UI, dan consent management.

---

## 🗂️ Struktur Dokumentasi

```
Sprint-4_Advanced-Presentation/
├── INDEX.md                    📍 File ini - Panduan navigasi
├── README.md                   ⭐ START HERE - Overview & user stories
├── SETUP-GUIDE.md              🔧 Setup & implementasi guide
├── SUMMARY.md                  📊 Quick summary & cheat sheet
└── diagrams/                   📐 C4 UML Diagrams (5 files)
    ├── 01-presentation-context.puml       Konteks presentation
    ├── 02-presentation-architecture.puml  Arsitektur komponen
    ├── 03-sd-jwt-flow.puml                Alur SD-JWT
    ├── 04-bbs-zkp-flow.puml               Alur BBS+ ZKP
    └── 05-consent-management-flow.puml    Alur consent management
```

---

## 🎯 Mulai Dari Mana?

### 👉 Saya Baru Join Sprint 4
**Start Here** → [README.md](./README.md)
1. Baca tujuan sprint
2. Review 9 user stories
3. Pahami selective disclosure concepts
4. Cek task breakdown

**Then** → [SUMMARY.md](./SUMMARY.md)
- Quick overview
- Key presentation features
- Timeline sprint

### 👉 Saya Mau Implementasi Fitur Presentation
**Follow This** → [SETUP-GUIDE.md](./SETUP-GUIDE.md)

**Pilih berdasarkan role:**
- **SSI Specialist**: SD-JWT, BBS+, PEx v2, cryptography
- **React Native Dev**: Disclosure UI, consent, templates
- **UI/UX Designer**: Disclosure UX, privacy indicators
- **All Developers**: Zero-knowledge proof concepts

**Step-by-step akan guide Anda:**
1. Setup SD-JWT libraries
2. Implementasi SD-JWT parsing & disclosure
3. Implementasi BBS+ signatures
4. Implementasi Presentation Exchange v2
5. Implementasi disclosure UI
6. Testing presentation flows

### 👉 Saya Mau Lihat Arsitektur Presentation
**View Diagrams** → [diagrams/](./diagrams/)

**Recommended order:**
1. **[01-presentation-context.puml](./diagrams/01-presentation-context.puml)** - Konteks presentation system
2. **[02-presentation-architecture.puml](./diagrams/02-presentation-architecture.puml)** - Arsitektur komponen
3. **[03-sd-jwt-flow.puml](./diagrams/03-sd-jwt-flow.puml)** - SD-JWT flow
4. **[04-bbs-zkp-flow.puml](./diagrams/04-bbs-zkp-flow.puml)** - BBS+ ZKP flow
5. **[05-consent-management-flow.puml](./diagrams/05-consent-management-flow.puml)** - Consent flow

**Cara view diagrams:**
- Online: https://www.plantuml.com/plantuml/uml/
- VS Code: PlantUML extension, Alt+D
- Generate PNG: `plantuml *.puml`

### 👉 Saya Mau Quick Reference
**Go To** → [SUMMARY.md](./SUMMARY.md)
- Sprint overview
- Key deliverables
- Presentation checklist
- Common commands

---

## 📖 Reading Guide by Role

### 🔐 SSI Specialist

**Your Focus**: Cryptography, SD-JWT, BBS+, zero-knowledge proofs

**Reading Order**:
1. [README.md](./README.md) - Complete read untuk semua user stories
2. All diagrams ([diagrams/](./diagrams/)) - Arsitektur presentation
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Implementation guidelines
4. [SUMMARY.md](./SUMMARY.md) - Quick reference

**Your Tasks Sprint 4**:
- **US-4.1**: SD-JWT implementation
- **US-4.2**: BBS+ signatures implementation
- **US-4.3**: Presentation Exchange v2
- **US-4.6**: JWT VC Presentation Profile

**Key Deliverables**:
- SD-JWT parser & disclosure logic
- BBS+ signature verification & derived proofs
- PEx v2 engine with constraint evaluation
- JWT VP generation with holder binding

### 👨‍💻 React Native Developer 1

**Your Focus**: Disclosure UI, predicate proofs, consent

**Reading Order**:
1. [README.md](./README.md) - Focus pada US-4.1, US-4.3, US-4.5, US-4.8
2. [diagrams/03-sd-jwt-flow.puml](./diagrams/03-sd-jwt-flow.puml)
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - UI implementation
4. [SUMMARY.md](./SUMMARY.md) - Quick reference

**Your Tasks Sprint 4**:
- **US-4.1**: SD-JWT disclosure UI (dengan SSI Specialist)
- **US-4.3**: PEx v2 UI (dengan SSI Specialist)
- **US-4.5**: Predicate proofs UI
- **US-4.8**: Consent management

**Key Deliverables**:
- Intuitive disclosure selector
- Predicate proof UI (age verification, ranges)
- Consent management UI
- Privacy indicators & warnings

### 👨‍💻 React Native Developer 2

**Your Focus**: Advanced disclosure UI, history, templates

**Reading Order**:
1. [README.md](./README.md) - Focus pada US-4.2, US-4.4, US-4.7, US-4.9
2. [diagrams/04-bbs-zkp-flow.puml](./diagrams/04-bbs-zkp-flow.puml)
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md)

**Your Tasks Sprint 4**:
- **US-4.2**: BBS+ UI (dengan SSI Specialist)
- **US-4.4**: Advanced disclosure UI (dengan UI/UX Designer)
- **US-4.7**: Presentation history
- **US-4.9**: Presentation templates

**Key Deliverables**:
- BBS+ credential rendering
- Advanced disclosure interface
- Presentation history timeline
- Template management system

### 🎨 UI/UX Designer

**Your Focus**: Disclosure UX, privacy indicators, user education

**Reading Order**:
1. [README.md](./README.md) - US-4.4 (Advanced Disclosure UI)
2. [diagrams/](./diagrams/) - All untuk understand flows
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Design guidelines

**Your Tasks Sprint 4**:
- **US-4.4**: Design advanced disclosure UI
- **US-4.5**: Design predicate proof explanations
- Review disclosure UX untuk all features
- Design privacy impact indicators

**Key Deliverables**:
- Disclosure UI mockups
- Privacy indicator designs
- Educational tooltips
- User consent flows

### 🧪 QA Engineer

**Your Focus**: Cryptographic testing, privacy testing, disclosure testing

**Reading Order**:
1. [README.md](./README.md) - All user stories
2. [diagrams/](./diagrams/) - Understand presentation flows
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Testing guidelines

**Your Tasks Sprint 4**:
- Test SD-JWT disclosure scenarios
- Test BBS+ zero-knowledge proofs
- Test PEx v2 constraint evaluation
- Test consent management
- Privacy testing (data leakage)
- Cryptographic validation

**Key Deliverables**:
- Presentation test cases
- Cryptographic test results
- Privacy test report
- Bug reports

### 📊 Product Owner

**Your Focus**: Sprint progress, acceptance, privacy compliance

**Reading Order**:
1. [SUMMARY.md](./SUMMARY.md) - Quick overview
2. [README.md](./README.md) - User stories & acceptance criteria
3. Sprint board untuk track progress

**Your Tasks Sprint 4**:
- Review completed user stories
- Accept/reject deliverables
- Prioritize bugs
- Prepare Sprint 5 backlog
- Ensure privacy compliance

---

## ✅ Sprint 4 Checklist

### Week 13: SD-JWT & BBS+ (26 SP)
- [ ] US-4.1: SD-JWT Support (13 SP)
- [ ] US-4.2: BBS+ Signatures (13 SP)
- [ ] Cryptographic testing

### Week 14: Presentation Exchange & UI (26 SP)
- [ ] US-4.3: Presentation Exchange v2 (13 SP)
- [ ] US-4.4: Advanced Disclosure UI (13 SP)
- [ ] Integration testing

### Week 15: Proofs & Management (24 SP)
- [ ] US-4.5: Predicate Proofs UI (8 SP)
- [ ] US-4.6: JWT VC Presentation Profile (8 SP)
- [ ] US-4.8: Consent Management (8 SP)
- [ ] Test disclosure scenarios

### Week 16: History & Templates (16 SP + Testing)
- [ ] US-4.7: Presentation History (8 SP)
- [ ] US-4.9: Presentation Templates (8 SP)
- [ ] All features tested
- [ ] Bug fixing
- [ ] Sprint review & demo
- [ ] Sprint retrospective

---

## 📋 Key Information At A Glance

### Sprint Goals
**Primary**: Advanced presentation dengan selective disclosure & ZKP
**Secondary**: Privacy-preserving credential sharing

### Story Points
- **Total**: 92 SP
- **Planned Capacity**: 90 SP
- **Team Size**: 6-8 developers

### Timeline
- **Duration**: 4 weeks (Week 13-16)
- **Sprint Planning**: Week 12 end (4 jam)
- **Daily Standups**: 15 menit/hari
- **Sprint Review**: Week 16 (2.5 jam)
- **Sprint Retrospective**: Week 16 (1.5 jam)

### Presentation Libraries
```json
{
  "@sphereon/sd-jwt": "^0.2.0",
  "@mattrglobal/bbs-signatures": "^1.3.0",
  "@sphereon/presentation-exchange": "^3.1.0",
  "@sphereon/ssi-types": "^0.9.0",
  "@sphereon/did-auth-siop": "^0.6.0"
}
```

### Key Components
```
src/
├── services/
│   ├── presentation/
│   │   ├── SDJWTService.ts              # SD-JWT handler
│   │   ├── BBSService.ts                # BBS+ signatures
│   │   ├── PresentationExchangeV2.ts    # PEx v2 engine
│   │   ├── DisclosureService.ts         # Disclosure logic
│   │   └── ConsentService.ts            # Consent management
│   └── templates/
│       └── PresentationTemplates.ts     # Template management
├── components/
│   └── presentation/
│       ├── DisclosureSelector.tsx       # Claim selector
│       ├── PredicateProofUI.tsx         # Predicate UI
│       ├── ConsentModal.tsx             # Consent dialog
│       └── HistoryTimeline.tsx          # History view
└── screens/
    └── presentation/
        └── PresentationScreen.tsx       # Main screen
```

---

## 🔐 Privacy & Security Concepts

### Selective Disclosure
**Concept**: Share only specific claims, hide others
**Technologies**: SD-JWT, BBS+
**Use Case**: Share only age > 18, hide exact birthdate

### Zero-Knowledge Proofs (ZKP)
**Concept**: Prove something without revealing the actual data
**Technology**: BBS+ Signatures
**Use Case**: Prove age > 21 without revealing exact age

### Predicate Proofs
**Concept**: Prove mathematical predicates
**Examples**:
- Age > 18
- Income > $50,000
- Balance > $1,000
- Score >= 750

### Holder Binding
**Concept**: Bind VP to specific holder
**Purpose**: Prevent credential replay attacks
**Method**: Cryptographic binding dengan DID

---

## 🧪 Testing Checklist

### Cryptographic Testing
- [ ] SD-JWT parsing & validation
- [ ] BBS+ signature verification
- [ ] Derived proof generation
- [ ] Holder binding verification
- [ ] Nonce handling

### Disclosure Testing
- [ ] Partial disclosure (some claims)
- [ ] Full disclosure (all claims)
- [ ] Zero disclosure (predicates only)
- [ ] Required vs optional claims
- [ ] Disclosure preview accuracy

### Privacy Testing
- [ ] Data leakage check
- [ ] Metadata privacy
- [ ] Correlation resistance
- [ ] Unlinkability testing

### Consent Testing
- [ ] Consent grant flow
- [ ] Consent revocation
- [ ] Consent expiry
- [ ] Remember consent
- [ ] Per-verifier settings

---

## 🐛 Common Issues & Solutions

### Issue: SD-JWT Disclosure Fails
```typescript
// Solution: Validate disclosure array
const validateDisclosure = (sdJwt: string, disclosures: string[]) => {
  // Check each disclosure is valid
  disclosures.forEach(d => {
    const decoded = base64UrlDecode(d);
    // Validate structure
  });
};
```

### Issue: BBS+ Performance Slow
```typescript
// Solution: Cache derived proofs
const cachedDerivedProof = await cache.get(`proof_${credentialId}_${reqId}`);
if (cachedDerivedProof) {
  return cachedDerivedProof;
}

const proof = await generateDerivedProof(credential, revealed);
await cache.set(`proof_${credentialId}_${reqId}`, proof, TTL);
```

### Issue: Presentation Exchange Constraint Evaluation
```typescript
// Solution: Implement proper constraint checker
const evaluateConstraint = (credential: any, constraint: any) => {
  const { fields, filter } = constraint;
  
  // Check fields exist
  if (!fields.every(field => hasField(credential, field.path))) {
    return false;
  }
  
  // Apply filter (JSON Schema validation)
  return validateAgainstSchema(credential, filter);
};
```

---

## 🔗 External Resources

### Standards
- **SD-JWT**: https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/
- **BBS+ Signatures**: https://identity.foundation/bbs-signature/
- **Presentation Exchange v2**: https://identity.foundation/presentation-exchange/spec/v2.0.0/

### Libraries
- **@mattrglobal/bbs-signatures**: https://github.com/mattrglobal/bbs-signatures
- **@sphereon/sd-jwt**: https://github.com/Sphereon-Opensource/sd-jwt-js
- **@sphereon/pex**: https://github.com/Sphereon-Opensource/PEX

### Research Papers
- **BBS+ Signatures Whitepaper**
- **Zero-Knowledge Proofs for Credentials**
- **Privacy-Preserving Selective Disclosure**

---

## 📞 Getting Help

### Internal Support
- **Cryptography Issues**: SSI Specialist
- **Implementation Questions**: #technical Slack channel
- **UI/UX Questions**: UI/UX Designer
- **Sprint Questions**: Scrum Master

### External Support
- **Mattr**: Discord #bbs-signatures
- **Sphereon**: Discord #mobile-wallet
- **DIF**: Slack #presentation-exchange

---

## 🎯 Success Criteria

Sprint 4 is **SUCCESSFUL** when:

- ✅ **All 9 user stories** completed dan tested
- ✅ **SD-JWT** working dengan selective disclosure
- ✅ **BBS+** credentials dapat diverifikasi
- ✅ **PEx v2** handling complex constraints
- ✅ **Disclosure UI** intuitive dan informative
- ✅ **Consent management** working
- ✅ **Cryptographic validation** passed
- ✅ **No critical bugs**
- ✅ **Code review** completed
- ✅ **Demo** successful kepada Product Owner

---

## 📈 Next Steps After Sprint 4

1. ✅ Advanced presentation ready → Start Sprint 5
2. 📖 Read Sprint 5: Enterprise Integrations
3. 🏃 Continue daily standups
4. 💻 Implement enterprise features
5. 🔄 Sprint 5 review & retrospective

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

**Good luck dengan implementasi presentation features! 🔐**
