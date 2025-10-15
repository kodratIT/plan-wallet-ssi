# Sprint 5: Enterprise Integrations - Diagrams

Dokumentasi visual untuk Sprint 5 menggunakan PlantUML (C4 Model).

---

## 📐 Diagram List

### 1. [01-enterprise-context.puml](./01-enterprise-context.puml)
**System Context Diagram** - Enterprise Integration Ecosystem

Menampilkan:
- Wallet dan enterprise integration layer
- Microsoft Entra VID ecosystem
- EBSI ecosystem (DID Registry, Trusted Issuers, Timestamp)
- Sphereon VDX Platform
- Enterprise issuers dan verifiers
- Trust registries

**Gunakan untuk:**
- Memahami big picture enterprise integrations
- Melihat Microsoft, EBSI, dan Sphereon positioning
- Understanding trust framework

---

### 2. [03-entra-integration-flow.puml](./03-entra-integration-flow.puml)
**Sequence Diagram** - Microsoft Entra Verified ID Flow (US-5.1)

Menampilkan 6-phase flow:
1. **Authentication** - Azure AD OAuth 2.0
2. **Request Credential Issuance** - Request API
3. **Present QR to User** - QR code display
4. **Credential Issuance** - Verifiable credential generation
5. **Store Credential** - Wallet storage
6. **Presentation Flow** - Credential verification

**Gunakan untuk:**
- Implementasi US-5.1 (Microsoft Entra VID)
- Understanding Request API
- Azure AD authentication flow
- Debugging Entra issues

**Key Concepts:**
- OAuth 2.0 client credentials flow
- Request API for issuance dan presentation
- Callback mechanism
- Multi-tenant support

---

### 3. [04-ebsi-eudi-flow.puml](./04-ebsi-eudi-flow.puml)
**Sequence Diagram** - EBSI/EUDI Wallet Flow (US-5.3)

Menampilkan 6-phase flow:
1. **DID Resolution** - did:ebsi resolution
2. **Issuer Trust Verification** - Trusted Issuers Registry
3. **Receive EBSI Credential** - VerifiableAttestation
4. **Timestamp Credential** - Blockchain timestamping
5. **EUDI Compliance Checks** - ARF validation
6. **Cross-Border Presentation** - EU interoperability

**Gunakan untuk:**
- Implementasi US-5.3 (EBSI Integration)
- Understanding EUDI Wallet compliance
- Trusted Issuers Registry usage
- Cross-border credential exchange

**Key Concepts:**
- did:ebsi DID method
- EBSI Trusted Issuers Registry
- EUDI Wallet Architecture Reference Framework (ARF)
- Cross-border EU recognition
- Blockchain timestamping

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
plantuml 01-enterprise-context.puml
```

### Generate SVG
```bash
plantuml -tsvg *.puml
```

---

## 📚 Key Concepts Explained

### Microsoft Entra Verified ID

**Components:**
- **Azure AD**: Identity provider
- **Request API**: Issuance dan presentation requests
- **Manifests**: Credential definitions
- **Verifiable Credentials**: Enterprise credentials

**Authentication Flow:**
1. Client credentials OAuth 2.0
2. Get access token
3. Use token untuk Request API calls

**Issuance Flow:**
1. Create issuance request
2. Generate QR code
3. User scans QR
4. Credential issued
5. Callback untuk confirmation

---

### EBSI (European Blockchain Services Infrastructure)

**Components:**
- **DID Registry**: European DID anchoring
- **Trusted Issuers Registry**: EU-approved issuers
- **Timestamp Service**: Blockchain timestamps
- **Revocation Registry**: Credential revocation

**Trust Model:**
- Issuers must be registered in TIR
- Cross-border recognition
- Government-backed trust
- GDPR compliant

**EUDI Wallet Compliance:**
- Architecture Reference Framework (ARF)
- Security requirements (biometric, encryption)
- Privacy requirements (GDPR)
- Interoperability standards

---

### Sphereon VDX Platform

**Components:**
- **VDX API**: Credential exchange
- **Workflow Engine**: Business process automation
- **Policy Engine**: Access control
- **Analytics**: Usage metrics

**Workflows:**
- Define multi-step processes
- Automate credential lifecycle
- Enterprise integration
- Compliance enforcement

---

## 🔐 Trust Framework

### Well-Known DID Configuration
- Domain linkage verification
- Issuer domain validation
- Trust indicators in UI

### StatusList2021
- Efficient revocation checking
- Bitstring compression
- Privacy-preserving
- Scalable for millions of credentials

---

## 📋 Diagram Checklist

- [x] 01-enterprise-context.puml - System context
- [x] 03-entra-integration-flow.puml - Microsoft Entra flow
- [x] 04-ebsi-eudi-flow.puml - EBSI/EUDI flow
- [ ] 02-enterprise-architecture.puml - Component architecture (optional)
- [ ] 05-vdx-workflow-flow.puml - VDX workflow (optional)

**Note**: Diagram 02 dan 05 bisa ditambahkan jika diperlukan detail lebih lanjut.

---

## 🔗 External Resources

### Microsoft Entra
- **Docs**: https://learn.microsoft.com/en-us/azure/active-directory/verifiable-credentials/
- **Request API**: https://learn.microsoft.com/en-us/azure/active-directory/verifiable-credentials/request-api

### EBSI
- **Main Site**: https://ec.europa.eu/digital-building-blocks/wikis/display/EBSI
- **API Docs**: https://api-pilot.ebsi.eu/docs/
- **EUDI Wallet**: https://github.com/eu-digital-identity-wallet

### Sphereon VDX
- **Contact**: Sphereon for VDX documentation
- **Support**: Discord #vdx-platform

---

**Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Complete (Core Diagrams)
