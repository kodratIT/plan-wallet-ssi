# Sprint 4: Advanced Presentation - Diagrams

Dokumentasi visual untuk Sprint 4 menggunakan PlantUML (C4 Model).

---

## 📐 Diagram List

### 1. [01-presentation-context.puml](./01-presentation-context.puml)
**System Context Diagram** - Advanced Presentation Ecosystem

Menampilkan:
- Wallet user dan interactions dengan presentation system
- Privacy-aware verifiers (full disclosure, predicate proofs)
- SD-JWT dan BBS+ issuers
- Presentation Exchange Registry
- Consent management flows

**Gunakan untuk:**
- Memahami big picture Sprint 4
- Melihat selective disclosure ecosystem
- Memahami predicate proof concept

---

### 2. [03-sd-jwt-flow.puml](./03-sd-jwt-flow.puml)
**Sequence Diagram** - SD-JWT Selective Disclosure Flow (US-4.1)

Menampilkan 6-phase flow:
1. **Receive SD-JWT Credential** - Parse dan validate structure
2. **Presentation Request** - Process verifier request
3. **Selective Disclosure** - User selects claims to share
4. **Generate Presentation** - Create SD-JWT with selected disclosures
5. **Submit Presentation** - Send to verifier
6. **Log Activity** - Track disclosed data

**Gunakan untuk:**
- Implementasi US-4.1 (SD-JWT Support)
- Understanding selective disclosure flow
- Debugging SD-JWT issues

**Key Concepts:**
- SD-JWT structure: `<JWT>~<Disclosure1>~<Disclosure2>~...~<KB-JWT>`
- Holder selectively includes disclosures
- Key binding for holder authentication
- Privacy-preserving presentation

---

### 3. [04-bbs-zkp-flow.puml](./04-bbs-zkp-flow.puml)
**Sequence Diagram** - BBS+ Zero-Knowledge Proof Flow (US-4.2)

Menampilkan predicate proof example: "Prove age > 18"

6-phase flow:
1. **Receive BBS+ Credential** - Verify BBS+ signature
2. **Predicate Proof Request** - Verifier asks for age > 18
3. **User Consent** - Explain ZKP and get approval
4. **Generate Derived Proof** - Create cryptographic proof
5. **Submit ZKP** - Send to verifier
6. **Log Activity** - Track predicate proofs

**Gunakan untuk:**
- Implementasi US-4.2 (BBS+ Signatures)
- Understanding zero-knowledge proofs
- Understanding predicate proofs
- Privacy-preserving verification

**Key Concepts:**
- Zero-Knowledge Proof: Prove without revealing
- Predicate: Mathematical statement (age > 18)
- Derived Proof: New signature with selective attributes
- Unlinkability: Different proofs each time

---

## 🔧 How to Use

### Online Viewer
1. Copy diagram content
2. Paste ke: https://www.plantuml.com/plantuml/uml/
3. View rendered diagram

### VS Code
1. Install extension: "PlantUML"
2. Open .puml file
3. Press `Alt+D` untuk preview

### Generate PNG
```bash
# Install PlantUML
brew install plantuml  # macOS

# Generate all diagrams
cd diagrams/
plantuml *.puml

# Generate single diagram
plantuml 01-presentation-context.puml

# Output: PNG files
```

### Generate SVG
```bash
plantuml -tsvg *.puml
```

---

## 📚 Diagram Concepts Explained

### SD-JWT (Selective Disclosure JWT)

**Structure**:
```
<Issuer-JWT>~<Disclosure1>~<Disclosure2>~...~<KB-JWT>
```

**Components**:
- **Issuer-JWT**: Credential signed by issuer
- **Disclosures**: Salted claim values (base64url encoded)
- **KB-JWT**: Key Binding JWT signed by holder

**Selective Disclosure**:
- Holder chooses which disclosures to include
- Verifier only sees included disclosures
- Cryptographically bound to holder

**Example**:
```json
// Full credential
{
  "name": "John Doe",
  "age": 30,
  "address": "123 Main St",
  "email": "john@example.com"
}

// Selective disclosure: Share only name and age
Disclosed: {name, age}
Hidden: {address, email}
```

---

### BBS+ Signatures & Zero-Knowledge Proofs

**Concept**: Prove statements without revealing underlying data

**Technologies**:
- BBS+ Signatures (Boneh-Boyen-Shacham)
- Pairing-based cryptography
- Derived proofs

**Process**:
1. Issuer signs credential with BBS+
2. Holder creates derived proof (selective disclosure)
3. Holder adds predicate proofs (age > 18)
4. Verifier validates without seeing hidden data

**Predicate Types**:
- **Greater than**: age > 18, score > 750
- **Less than**: balance < 1000
- **Range**: 18 < age < 65
- **Equal**: status == "active"

**Benefits**:
- ✓ Privacy: Hide exact values
- ✓ Selective: Choose what to prove
- ✓ Unlinkable: Different proofs each time
- ✓ Minimal disclosure: Only necessary info

---

### Presentation Exchange v2

**Purpose**: Standard format untuk presentation requests

**Components**:
- **Presentation Definition**: What verifier needs
- **Input Descriptors**: Required credentials
- **Constraints**: Field requirements
- **Submission**: Holder's response

**Example Constraint**:
```json
{
  "fields": [{
    "path": ["$.credentialSubject.age"],
    "filter": {
      "type": "number",
      "minimum": 18
    }
  }]
}
```

---

## 🔐 Privacy Concepts

### Selective Disclosure
**Level**: Claim-level privacy
**Technology**: SD-JWT, BBS+
**Use Case**: Share name and age, hide address

### Zero-Knowledge Proofs
**Level**: Value-level privacy
**Technology**: BBS+ with predicates
**Use Case**: Prove age > 18, hide exact age

### Unlinkability
**Level**: Presentation-level privacy
**Technology**: BBS+ derived proofs
**Use Case**: Prevent tracking across verifiers

### Holder Binding
**Level**: Security
**Technology**: Key Binding JWT
**Use Case**: Prevent presentation replay

---

## 📋 Diagram Checklist

- [x] 01-presentation-context.puml - System context
- [x] 03-sd-jwt-flow.puml - SD-JWT flow
- [x] 04-bbs-zkp-flow.puml - BBS+ ZKP flow
- [ ] 02-presentation-architecture.puml - Component architecture (optional)
- [ ] 05-consent-management-flow.puml - Consent flow (optional)

**Note**: Diagram 02 dan 05 bisa ditambahkan jika diperlukan detail lebih lanjut.

---

## 🔗 External Resources

### Standards
- **SD-JWT**: https://datatracker.ietf.org/doc/draft-ietf-oauth-selective-disclosure-jwt/
- **BBS+ Signatures**: https://identity.foundation/bbs-signature/
- **Presentation Exchange**: https://identity.foundation/presentation-exchange/

### Research Papers
- **BBS+ Signatures Whitepaper**: https://eprint.iacr.org/2016/663.pdf
- **Selective Disclosure for JWTs**: https://www.ietf.org/archive/id/draft-ietf-oauth-selective-disclosure-jwt-05.html

---

**Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Complete (Core Diagrams)
