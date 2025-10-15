# Sprint 2: Credential Management - Diagrams

Dokumentasi visual untuk Sprint 2 menggunakan PlantUML (C4 Model).

---

## 📐 Diagram List

### 1. [01-credential-context.puml](./01-credential-context.puml)
**System Context Diagram** - Credential Management Ecosystem

Menampilkan:
- Wallet user dan interaksinya dengan credential management
- External issuers (University, Government, Corporate)
- External verifiers (Employer, Financial)
- Registries (OCA, Credential Manifest, Schema)
- Credential issuance dan presentation flows

**Gunakan untuk:**
- Memahami big picture Sprint 2
- Melihat interaksi dengan external systems
- Memahami credential ecosystem

---

### 2. [02-credential-architecture.puml](./02-credential-architecture.puml)
**Component Diagram** - Internal Architecture

Menampilkan:
- UI Layer (Credential screens, cards, search)
- State Management (Redux stores)
- Business Logic (Services untuk Manifest, OCA, Search, Export)
- Data Layer (Databases dan cache)

**Gunakan untuk:**
- Memahami internal components
- Melihat dependencies antar components
- Planning implementasi services

---

### 3. [03-credential-manifest-flow.puml](./03-credential-manifest-flow.puml)
**Sequence Diagram** - Credential Manifest Protocol (US-2.1)

Menampilkan:
- Complete credential issuance flow dengan Credential Manifest
- Fetching dan parsing manifests
- Output descriptors handling
- Presentation requirements
- Credential application generation
- Response handling

**Gunakan untuk:**
- Implementasi US-2.1
- Debugging manifest issues
- Understanding manifest protocol

---

### 4. [04-oca-rendering-flow.puml](./04-oca-rendering-flow.puml)
**Sequence Diagram** - OCA Rendering Flow (US-2.2)

Menampilkan:
- OCA bundle fetching
- Character encoding overlay
- Format overlay application
- Label overlay (multilingual)
- Branding overlay (colors, logos)
- Beautiful card rendering
- Fallback handling

**Gunakan untuk:**
- Implementasi US-2.2
- Understanding OCA overlays
- Debugging rendering issues

---

### 5. [05-credential-lifecycle.puml](./05-credential-lifecycle.puml)
**Sequence Diagram** - Complete Credential Lifecycle

Menampilkan:
- Phase 1: Issuance
- Phase 2: Organization (categories, search, favorites)
- Phase 3: Viewing details
- Phase 4: Presentation
- Phase 5: Export & share
- Phase 6: Activity history
- Phase 7: Status changes (revocation, expiration)
- Phase 8: Deletion

**Gunakan untuk:**
- Understanding complete credential journey
- Implementasi all user stories
- End-to-end testing scenarios

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
# atau download dari: https://plantuml.com/download

# Generate semua diagrams
cd diagrams/
plantuml *.puml

# Generate single diagram
plantuml 01-credential-context.puml

# Output: PNG files di folder yang sama
```

### Generate SVG
```bash
plantuml -tsvg *.puml
```

---

## 📚 C4 Model References

Diagrams menggunakan C4 Model:
- **Level 1 (Context)**: System context - big picture
- **Level 2 (Container)**: High-level technology choices
- **Level 3 (Component)**: Component details
- **Sequence**: Dynamic behavior

Learn more: https://c4model.com/

---

## 🔄 Updating Diagrams

Saat ada perubahan dalam Sprint 2:
1. Update relevant .puml file
2. Regenerate PNG/SVG
3. Commit both .puml dan generated images
4. Update documentation jika ada architectural changes

---

## 📋 Diagram Checklist

- [x] 01-credential-context.puml - System context
- [x] 02-credential-architecture.puml - Component architecture
- [x] 03-credential-manifest-flow.puml - Manifest flow
- [x] 04-oca-rendering-flow.puml - OCA rendering
- [x] 05-credential-lifecycle.puml - Complete lifecycle

---

## 🎯 Key Concepts Explained

### Credential Manifest
Protocol yang mendefinisikan:
- Struktur credential yang akan diterbitkan
- Display metadata (title, subtitle, description)
- Presentation requirements
- Application format

### OCA (Overlay Capture Architecture)
Sistem untuk memisahkan:
- **Capture Base**: Core schema
- **Overlays**: Visual styling, labels, formats
  - Branding: Colors, logos
  - Labels: Multilingual labels
  - Format: Data formatting patterns

### Credential Lifecycle States
- **PENDING**: Being issued
- **ACTIVE**: Normal active state
- **EXPIRED**: Past expiration date
- **REVOKED**: Revoked by issuer
- **ARCHIVED**: Soft deleted (recoverable)
- **DELETED**: Permanently removed

---

**Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Complete
