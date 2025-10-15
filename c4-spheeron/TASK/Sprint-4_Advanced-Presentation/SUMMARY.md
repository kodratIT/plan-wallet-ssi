# Sprint 4: Presentasi Lanjutan & Selective Disclosure - Ringkasan Cepat

## 📊 Overview

**Sprint**: Sprint 4 (Advanced Presentation)  
**Durasi**: 4 Minggu (160 jam)  
**Tim**: 6-8 developer  
**Story Points**: 92 SP  
**Prioritas**: TINGGI - Advanced presentation capabilities

---

## 🎯 Tujuan Sprint

*"Mengimplementasikan SD-JWT, tanda tangan BBS+, dan kemampuan selective disclosure yang ditingkatkan."*

### Objectives
1. ✅ SD-JWT (Selective Disclosure JWT) support
2. ✅ BBS+ signatures untuk zero-knowledge proofs
3. ✅ Presentation Exchange v2 enhanced
4. ✅ Advanced disclosure UI
5. ✅ Predicate proofs (age > 18, income > X)
6. ✅ JWT VC Presentation Profile
7. ✅ Presentation history & analytics
8. ✅ Consent management system
9. ✅ Presentation templates

---

## 📋 User Stories Summary

| ID | User Story | Story Points | Prioritas | Assignee |
|----|-----------|--------------|-----------|----------|
| US-4.1 | SD-JWT Support | 13 | Must Have | SSI Specialist + RN Dev 1 |
| US-4.2 | BBS+ Signatures | 13 | Should Have | SSI Specialist + RN Dev 2 |
| US-4.3 | Presentation Exchange v2 | 13 | Must Have | SSI Specialist + RN Dev 1 |
| US-4.4 | Advanced Disclosure UI | 13 | Must Have | UI/UX Designer + RN Dev 2 |
| US-4.5 | Predicate Proofs UI | 8 | Should Have | React Native Dev 1 |
| US-4.6 | JWT VC Presentation Profile | 8 | Should Have | SSI Specialist |
| US-4.7 | Presentation History | 8 | Should Have | React Native Dev 2 |
| US-4.8 | Consent Management | 8 | Should Have | React Native Dev 1 |
| US-4.9 | Presentation Templates | 8 | Could Have | React Native Dev 2 |

**Total**: 92 Story Points

---

## 🔑 Key Deliverables

### 1. SD-JWT Support (US-4.1)
- SD-JWT parser & validator
- Disclosure selection logic
- Selective disclosure generation
- Holder binding implementation
- Secure storage for SD-JWT credentials

### 2. BBS+ Signatures (US-4.2)
- BBS+ signature verification
- Derived proof generation
- Zero-knowledge proof capabilities
- Selective disclosure dengan ZKP
- Performance optimizations

### 3. Presentation Exchange v2 (US-4.3)
- PEx v2 engine implementation
- Input descriptor handling
- Constraint evaluation (JSON Schema)
- Format selection logic
- Submission generation & validation

### 4. Advanced Disclosure UI (US-4.4)
- Intuitive claim selector
- Visual disclosure indicators
- Privacy impact warnings
- Required vs optional claims
- Disclosure preview screen
- Educational tooltips

### 5. Predicate Proofs (US-4.5, US-4.6)
- Age verification UI (>18, >21)
- Range proof UI
- Predicate explanation
- JWT VP generation dengan holder binding
- Nonce & audience handling

### 6. Management Features (US-4.7, US-4.8, US-4.9)
- Presentation history timeline
- Per-verifier consent settings
- Consent revocation & expiry
- Presentation templates
- Template management UI

---

## 🛠️ Tech Stack & Dependencies

### Cryptography Libraries
```json
{
  "@sphereon/sd-jwt": "^0.2.0",
  "@mattrglobal/bbs-signatures": "^1.3.0",
  "@mattrglobal/bls12381-key-pair": "^1.2.0",
  "@sphereon/ssi-sdk-credential": "^0.9.0"
}
```

### Presentation Libraries
```json
{
  "@sphereon/presentation-exchange": "^3.1.0",
  "@sphereon/pex": "^2.2.0",
  "@sphereon/pex-models": "^2.2.0",
  "@sphereon/did-auth-siop": "^0.6.0"
}
```

### UI & Utilities
```json
{
  "react-native-paper": "^5.10.0",
  "react-native-reanimated": "^3.5.0",
  "@react-native-async-storage/async-storage": "^1.19.0"
}
```

### Installation
```bash
# Cryptography libraries
npm install @sphereon/sd-jwt
npm install @mattrglobal/bbs-signatures
npm install @mattrglobal/bls12381-key-pair

# Presentation libraries
npm install @sphereon/presentation-exchange
npm install @sphereon/pex @sphereon/pex-models

# UI libraries (if not installed)
npm install react-native-paper react-native-reanimated
```

---

## 📅 Sprint Timeline

### Week 13: Cryptography Foundation (26 SP)
**Days 1-2**: Setup & Architecture
- [ ] Install crypto libraries
- [ ] Study SD-JWT & BBS+ specs
- [ ] Design architecture

**Days 3-5**: Implementation
- [ ] US-4.1: SD-JWT Support (13 SP)
- [ ] US-4.2: BBS+ Signatures (13 SP)
- [ ] Cryptographic testing

### Week 14: Presentation Engine & UI (26 SP)
**Days 1-3**: PEx v2 Engine
- [ ] US-4.3: Presentation Exchange v2 (13 SP)
- [ ] Constraint evaluation testing

**Days 4-5**: Disclosure UI
- [ ] US-4.4: Advanced Disclosure UI (13 SP)
- [ ] UI/UX review

### Week 15: Proofs & Management (24 SP)
**Days 1-2**: Predicate Proofs
- [ ] US-4.5: Predicate Proofs UI (8 SP)
- [ ] US-4.6: JWT VC Presentation Profile (8 SP)

**Days 3-5**: Consent Management
- [ ] US-4.8: Consent Management (8 SP)
- [ ] Integration testing

### Week 16: History & Polish (16 SP + Testing)
**Days 1-2**: History & Templates
- [ ] US-4.7: Presentation History (8 SP)
- [ ] US-4.9: Presentation Templates (8 SP)

**Days 3-4**: Testing & Bug Fixing
- [ ] End-to-end testing
- [ ] Privacy testing
- [ ] Bug fixes

**Day 5**: Review & Retrospective
- [ ] Sprint review demo
- [ ] Retrospective
- [ ] Sprint 5 planning prep

---

## 🔐 Key Concepts Explained

### Selective Disclosure
**Apa itu?** Kemampuan untuk membagikan hanya sebagian klaim dari credential, menyembunyikan yang lain.

**Teknologi**: SD-JWT, BBS+

**Contoh**:
```
Credential: {name: "John", age: 30, address: "123 Main St"}
Disclosed: {name: "John", age: 30}
Hidden: {address}
```

### Zero-Knowledge Proofs (ZKP)
**Apa itu?** Membuktikan suatu pernyataan tanpa mengungkapkan data aktual.

**Teknologi**: BBS+ Signatures

**Contoh**:
```
Prove: age > 21
Without revealing: actual age (e.g., 30)
```

### Predicate Proofs
**Apa itu?** Pembuktian matematis tentang nilai.

**Tipe**:
- Greater than: age > 18
- Less than: score < 100
- Range: 18 < age < 65
- Equal: status == "active"

### Holder Binding
**Apa itu?** Mengikat VP ke holder tertentu untuk mencegah replay attacks.

**Method**:
- Cryptographic signature dengan DID holder
- Nonce untuk freshness
- Audience restriction

---

## 📚 Code Snippets & Quick Reference

### SD-JWT Disclosure Selection
```typescript
import { SDJWTService } from '@/services/presentation/SDJWTService';

// Parse SD-JWT
const parsed = await SDJWTService.parse(sdJwtString);

// Select claims to disclose
const toDisclose = ['name', 'age']; // Hide 'address'

// Generate presentation
const presentation = await SDJWTService.createPresentation(
  parsed,
  toDisclose,
  holderDID,
  verifierDID,
  nonce
);
```

### BBS+ Derived Proof
```typescript
import { BBSService } from '@/services/presentation/BBSService';

// Verify BBS+ credential
const verified = await BBSService.verify(credential);

// Create derived proof (reveal only some attributes)
const derivedProof = await BBSService.deriveProof(
  credential,
  ['name', 'age'], // Reveal these
  nonce
);
```

### Presentation Exchange v2
```typescript
import { PresentationExchangeV2 } from '@/services/presentation/PresentationExchangeV2';

// Evaluate presentation definition
const result = await PresentationExchangeV2.evaluate(
  presentationDefinition,
  credentials
);

// Get matching credentials
const matches = result.matches;

// Create submission
const submission = await PresentationExchangeV2.createSubmission(
  presentationDefinition,
  selectedCredentials
);
```

### Consent Management
```typescript
import { ConsentService } from '@/services/presentation/ConsentService';

// Check if consent exists
const hasConsent = await ConsentService.hasConsent(verifierDID);

// Grant consent
await ConsentService.grantConsent({
  verifier: verifierDID,
  scope: ['name', 'age'],
  remember: true,
  expiresIn: 3600 // 1 hour
});

// Revoke consent
await ConsentService.revokeConsent(verifierDID);
```

---

## ✅ Acceptance Criteria Checklist

### US-4.1: SD-JWT
- [ ] SD-JWT parsing working
- [ ] Disclosure selection UI
- [ ] Selective disclosure generation
- [ ] Holder binding implemented
- [ ] Storage working
- [ ] Tested dengan demo verifiers

### US-4.2: BBS+
- [ ] BBS+ verification working
- [ ] Derived proof generation
- [ ] Selective disclosure dengan ZKP
- [ ] Performance acceptable
- [ ] Tested on iOS & Android

### US-4.3: PEx v2
- [ ] Presentation Definition v2 parsing
- [ ] Input descriptors handled
- [ ] Constraints evaluated correctly
- [ ] Format selection working
- [ ] Submission generation & validation

### US-4.4: Disclosure UI
- [ ] Claim selector intuitive
- [ ] Visual indicators clear
- [ ] Privacy warnings shown
- [ ] Required/optional distinguished
- [ ] Preview accurate
- [ ] Educational tooltips helpful

### US-4.5: Predicate Proofs
- [ ] Predicate explanation clear
- [ ] Age verification UI working
- [ ] Range proofs supported
- [ ] Privacy notices shown

### US-4.6: JWT VP Profile
- [ ] VP-JWT generation compliant
- [ ] Holder binding correct
- [ ] Nonce handling
- [ ] Audience restriction

### US-4.7: History
- [ ] All presentations logged
- [ ] Timeline display working
- [ ] Disclosed data tracked
- [ ] Export functionality
- [ ] Privacy compliant (no PII)

### US-4.8: Consent
- [ ] Per-verifier settings
- [ ] Remember consent working
- [ ] Revocation working
- [ ] Expiry working
- [ ] Audit trail maintained

### US-4.9: Templates
- [ ] Template creation working
- [ ] Template storage
- [ ] Template selection
- [ ] Template editing
- [ ] Templates tested

---

## 🧪 Testing Checklist

### Cryptographic Testing
- [ ] SD-JWT signature verification
- [ ] SD-JWT disclosure validation
- [ ] BBS+ signature verification
- [ ] BBS+ derived proof verification
- [ ] Holder binding verification

### Disclosure Testing
- [ ] Full disclosure (all claims)
- [ ] Partial disclosure (some claims)
- [ ] Zero disclosure (predicates only)
- [ ] Required claims enforced
- [ ] Optional claims work

### Privacy Testing
- [ ] No data leakage in metadata
- [ ] Unlinkability testing
- [ ] Correlation resistance
- [ ] Predicate proof privacy

### Constraint Testing
- [ ] Simple constraints (field exists)
- [ ] Complex constraints (JSON Schema)
- [ ] Format constraints
- [ ] Pattern constraints
- [ ] Enum constraints

---

## 🐛 Common Issues & Solutions

### Issue: SD-JWT Verification Fails
```typescript
// Solution: Check issuer signature and disclosures
const verifySdJwt = async (sdJwt: string) => {
  try {
    // Parse SD-JWT
    const parts = sdJwt.split('~');
    const jwt = parts[0];
    const disclosures = parts.slice(1, -1);
    
    // Verify JWT signature
    const jwtVerified = await verifyJWT(jwt);
    if (!jwtVerified) throw new Error('Invalid JWT signature');
    
    // Verify each disclosure
    for (const disclosure of disclosures) {
      const valid = await verifyDisclosure(jwt, disclosure);
      if (!valid) throw new Error('Invalid disclosure');
    }
    
    return true;
  } catch (error) {
    console.error('SD-JWT verification failed:', error);
    return false;
  }
};
```

### Issue: BBS+ Performance Too Slow
```typescript
// Solution: Use WebAssembly version and cache
import { BbsBlsSignature2020 } from '@mattrglobal/bbs-signatures';

// Enable WASM
BbsBlsSignature2020.enableWasm();

// Cache key pairs
const keyPairCache = new Map();

const getDerivedProof = async (credential, revealed) => {
  const cacheKey = `${credential.id}_${revealed.join(',')}`;
  
  if (keyPairCache.has(cacheKey)) {
    return keyPairCache.get(cacheKey);
  }
  
  const proof = await generateDerivedProof(credential, revealed);
  keyPairCache.set(cacheKey, proof);
  
  return proof;
};
```

### Issue: PEx Constraint Evaluation Incorrect
```typescript
// Solution: Proper JSON Schema validation
import Ajv from 'ajv';

const evaluateConstraint = (credential: any, constraint: any) => {
  const ajv = new Ajv();
  
  // Build schema from constraint
  const schema = {
    type: 'object',
    properties: {},
    required: constraint.required || []
  };
  
  // Add fields from constraint
  constraint.fields?.forEach(field => {
    const path = field.path[0]; // e.g., "$.credentialSubject.age"
    const key = path.split('.').pop();
    
    if (field.filter) {
      schema.properties[key] = field.filter;
    }
  });
  
  // Validate
  const validate = ajv.compile(schema);
  return validate(credential.credentialSubject);
};
```

---

## 📊 Sprint Metrics

### Velocity
- **Planned**: 92 SP
- **Team Capacity**: 90 SP
- **Utilization**: 102%

### Team Allocation
- SSI Specialist: 4 user stories (47 SP)
- React Native Dev 1: 4 user stories (42 SP)
- React Native Dev 2: 4 user stories (42 SP)
- UI/UX Designer: 2 user stories (26 SP)

### Time Estimates
- Development: 130 jam (81%)
- Testing: 20 jam (13%)
- Documentation: 10 jam (6%)

---

## 🔗 Resources

### Internal Docs
- [README.md](./README.md) - Full documentation
- [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Implementation guide
- [diagrams/](./diagrams/) - Architecture diagrams

### External Resources
- SD-JWT Spec: https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/
- BBS+ Signatures: https://identity.foundation/bbs-signature/
- Presentation Exchange v2: https://identity.foundation/presentation-exchange/spec/v2.0.0/

### Libraries
- @mattrglobal/bbs-signatures: https://github.com/mattrglobal/bbs-signatures
- @sphereon/sd-jwt: https://github.com/Sphereon-Opensource/sd-jwt-js
- @sphereon/pex: https://github.com/Sphereon-Opensource/PEX

---

## 📞 Contact

### Internal Support
- **Cryptography**: SSI Specialist
- **Technical**: #technical Slack
- **Sprint**: Scrum Master

### External Support
- **Mattr**: Discord #bbs-signatures
- **Sphereon**: Discord #mobile-wallet

---

## 🎯 Definition of Done

Sprint 4 selesai ketika:

- ✅ 9 user stories completed
- ✅ All acceptance criteria met
- ✅ SD-JWT working with disclosure
- ✅ BBS+ ZKP verified
- ✅ PEx v2 handling constraints
- ✅ Disclosure UI intuitive
- ✅ Consent management working
- ✅ Cryptographic validation passed
- ✅ Code review approved
- ✅ Tests passing (> 80% coverage)
- ✅ Documentation complete
- ✅ Demo successful
- ✅ No critical bugs
- ✅ Ready for Sprint 5

---

**Status**: ✅ Ready  
**Version**: 1.0  
**Updated**: 2024

**Let's build privacy-preserving presentations! 🔐**
