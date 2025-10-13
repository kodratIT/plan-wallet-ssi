# BC Wallet Mobile - C4 Model Diagrams

This folder contains comprehensive C4 Model diagrams for the BC Wallet Mobile project using PlantUML.

## 📐 About C4 Model

The C4 Model is a lean graphical notation technique for modeling the architecture of software systems. Created by Simon Brown, it consists of a hierarchical set of software architecture diagrams for different audiences.

### C4 Levels:
1. **Level 1: System Context** - The big picture
2. **Level 2: Container** - High-level technology choices
3. **Level 3: Component** - Components within containers
4. **Level 4: Code** - Class diagrams (optional)

Plus: **Dynamic Diagrams** showing runtime behavior and **Deployment Diagrams** showing infrastructure.

## 📊 Diagram Inventory

### System Context Diagrams

**01-system-context.puml**
- **Level**: 1 (Context)
- **Audience**: Everyone (technical and non-technical)
- **Purpose**: Shows BC Wallet in context with users and external systems
- **Key Elements**:
  - BC Resident (user)
  - BC Wallet Mobile (system)
  - External systems (BCSC, IAS, Mediator, Indy Ledger, etc.)
  - High-level relationships

### Container Diagrams

**02-container-diagram.puml**
- **Level**: 2 (Container)
- **Audience**: Technical stakeholders, architects
- **Purpose**: Shows major technology containers within BC Wallet
- **Key Elements**:
  - Mobile Application (React Native)
  - Bifold Framework
  - Credo Agent (AFJ)
  - Indy SDK (Native)
  - Aries Askar
  - Secure Storage
  - Local Database

### Component Diagrams

**03-component-mobile-app.puml**
- **Level**: 3 (Component)
- **Container**: Mobile Application Layer
- **Audience**: Developers, architects
- **Purpose**: Components within React Native mobile app
- **Key Components**:
  - App Entry Point
  - Navigation System
  - State Store
  - Screens & UI Components
  - Custom Hooks
  - Service Layer (BCSC, IAS, Notification, etc.)

**04-component-ssi-core.puml**
- **Level**: 3 (Component)
- **Container**: SSI Core (Credo Framework)
- **Audience**: SSI developers, blockchain specialists
- **Purpose**: Core SSI functionality components
- **Key Components**:
  - Agent Core
  - Wallet Module
  - Connections Module
  - Credentials Module
  - Proofs Module
  - DIDComm Module
  - Native SDK wrappers (Indy, Askar, AnonCreds)

**05-component-android-native.puml**
- **Level**: 3 (Component)
- **Container**: Native Android Implementation (Kotlin)
- **Audience**: Android developers
- **Purpose**: Architecture for native Android version
- **Key Components**:
  - Presentation (Jetpack Compose)
  - ViewModel (MVVM)
  - Domain (Use Cases)
  - Data (Repository)
  - SSI Core (Manual Aries implementation)
  - Native services

**06-component-ios-native.puml**
- **Level**: 3 (Component)
- **Container**: Native iOS Implementation (Swift)
- **Audience**: iOS developers
- **Purpose**: Architecture for native iOS version
- **Key Components**:
  - Presentation (SwiftUI)
  - ViewModel (MVVM + Combine)
  - Domain (Use Cases)
  - Data (Repository)
  - SSI Core (Manual Aries implementation)
  - Native services

### Deployment Diagram

**07-deployment-diagram.puml**
- **Level**: Deployment
- **Audience**: DevOps, infrastructure engineers
- **Purpose**: Production deployment topology
- **Key Elements**:
  - Android/iOS devices
  - Mediator infrastructure (K8s)
  - Indy Network (validator nodes)
  - BC Gov infrastructure (BCSC, IAS)
  - Push notification services
  - App stores

### Dynamic Diagrams (Runtime Flows)

**08-dynamic-credential-issuance.puml**
- **Type**: Dynamic (Sequence)
- **Flow**: Credential Issuance
- **Purpose**: Shows step-by-step credential issuance flow
- **Phases**:
  1. Connection establishment
  2. Credential offer
  3. Credential request
  4. Credential issuance

**09-dynamic-proof-presentation.puml**
- **Type**: Dynamic (Sequence)
- **Flow**: Zero-Knowledge Proof Presentation
- **Purpose**: Shows proof presentation with ZKP
- **Phases**:
  1. Proof request
  2. Credential selection
  3. ZK proof generation
  4. Proof verification

**10-dynamic-bcsc-authentication.puml**
- **Type**: Dynamic (Sequence)
- **Flow**: BCSC Authentication & Credential Issuance
- **Purpose**: OAuth2/OIDC flow with Person Credential
- **Phases**:
  1. OAuth2 authentication (PKCE)
  2. Token exchange
  3. User profile retrieval
  4. Identity verification
  5. Credential issuance

### Landscape Diagram

**11-landscape-diagram.puml**
- **Type**: Landscape (Enterprise Context)
- **Audience**: Enterprise architects, executives
- **Purpose**: BC Wallet in broader BC Gov digital identity ecosystem
- **Scope**:
  - BC Wallet ecosystem
  - BC Government services
  - SSI infrastructure
  - External verification services
  - App distribution

## 🎨 Diagram Styling

All C4 diagrams use the official C4-PlantUML library with consistent styling:

```plantuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Context.puml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Component.puml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Deployment.puml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Dynamic.puml
```

**Color Coding**:
- Blue: Internal systems/containers
- Gray: External systems
- Green: People/actors
- Different shades for different component types

## 🔧 How to Use

### 1. Online Viewer (Quick Preview)
```
Visit: http://www.plantuml.com/plantuml/uml/
Copy content from any .puml file
Paste and view instantly
```

### 2. VS Code (Best for Editing)
```
Install: "PlantUML" extension by jebbs
Open any .puml file
Press Alt+D to preview
```

### 3. Generate Images (Command Line)
```bash
# Install PlantUML
brew install plantuml  # macOS
apt install plantuml   # Linux

# Navigate to c4 folder
cd /Users/kodrat/Public/Penelitian/uml/c4

# Generate all as PNG
plantuml *.puml

# Generate all as SVG
plantuml -tsvg *.puml

# Generate specific diagram
plantuml 01-system-context.puml
```

### 4. Docker (Cross-platform)
```bash
cd /Users/kodrat/Public/Penelitian/uml/c4

# Generate all diagrams
docker run --rm -v $(pwd):/data plantuml/plantuml *.puml

# Generate as SVG
docker run --rm -v $(pwd):/data plantuml/plantuml -tsvg *.puml
```

## 📚 Diagram Usage Guide

### For Stakeholder Presentations
**Start with**: `01-system-context.puml` → `11-landscape-diagram.puml`
- Big picture view
- Non-technical friendly
- Shows business value

### For Technical Discussions
**Use**: `02-container-diagram.puml` → Component diagrams
- Technology decisions
- Integration points
- Architecture patterns

### For Development Teams
**Focus on**:
- React Native: `03-component-mobile-app.puml`
- Android: `05-component-android-native.puml`
- iOS: `06-component-ios-native.puml`
- SSI Core: `04-component-ssi-core.puml`

### For DevOps/Infrastructure
**Use**: `07-deployment-diagram.puml`
- Deployment topology
- Network architecture
- Infrastructure requirements

### For Understanding Flows
**Use Dynamic Diagrams**:
- Credential flow: `08-dynamic-credential-issuance.puml`
- Proof flow: `09-dynamic-proof-presentation.puml`
- BCSC flow: `10-dynamic-bcsc-authentication.puml`

## 🎯 Diagram Comparison

| Diagram | Level | Complexity | Best For |
|---------|-------|------------|----------|
| 01-system-context | 1 | Low | Executives, stakeholders |
| 02-container | 2 | Medium | Architects, tech leads |
| 03-component-mobile-app | 3 | High | Mobile developers |
| 04-component-ssi-core | 3 | High | SSI/blockchain devs |
| 05-component-android | 3 | High | Android team |
| 06-component-ios | 3 | High | iOS team |
| 07-deployment | Infra | Medium | DevOps, infra team |
| 08-dynamic-credential | Flow | Medium | Everyone technical |
| 09-dynamic-proof | Flow | High | SSI developers |
| 10-dynamic-bcsc | Flow | Medium | Integration team |
| 11-landscape | Enterprise | Low | Enterprise architects |

## 📖 C4 Model Resources

- **Official Site**: https://c4model.com/
- **C4-PlantUML**: https://github.com/plantuml-stdlib/C4-PlantUML
- **Simon Brown's Book**: "Software Architecture for Developers"
- **Examples**: https://c4model.com/#examples

## 🔄 Maintaining Diagrams

### When to Update

**System Context** - When:
- New external system added
- Major system boundary changes
- New user types added

**Container Diagram** - When:
- New major component/container added
- Technology changes (e.g., React Native → Native)
- Storage/database changes

**Component Diagrams** - When:
- New modules/packages added
- Architecture refactoring
- Service boundaries change

**Dynamic Diagrams** - When:
- Protocol changes
- Flow modifications
- New integration points

**Deployment Diagram** - When:
- Infrastructure changes
- New environments added
- Scaling architecture

### Update Process
1. Edit `.puml` file
2. Regenerate image
3. Update README if needed
4. Commit changes with clear message

## 🎨 Customization

### Change Colors
Edit C4 includes or add custom styling:
```plantuml
!define CUSTOM_PRIMARY_COLOR #0078D4
!define CUSTOM_SECONDARY_COLOR #50E6FF
```

### Add Custom Elements
```plantuml
AddElementTag("microservice", $bgColor="lightgreen")
AddRelTag("async", $lineStyle="dashed")
```

### Adjust Layout
```plantuml
LAYOUT_LEFT_RIGHT()    ' Horizontal layout
LAYOUT_TOP_DOWN()      ' Vertical layout (default)
LAYOUT_LANDSCAPE()     ' Wide landscape
```

## 💡 Tips & Best Practices

1. **Start Simple**: Begin with System Context, then drill down
2. **One Audience**: Each diagram for specific audience
3. **Consistent Naming**: Use same names across diagrams
4. **Update Together**: Keep related diagrams in sync
5. **Version Control**: Commit diagrams with code
6. **Generate Early**: Create diagrams early in design phase
7. **Review Regularly**: Update during architecture reviews

## 🚀 Advanced Usage

### Combine Diagrams
```plantuml
' Include multiple diagrams in presentation
!include 01-system-context.puml
!include 02-container-diagram.puml
```

### Custom Macros
```plantuml
!function $MyCustomComponent($alias, $label)
  Component($alias, $label, "Custom Type", "Description")
!endfunction
```

### Dynamic Properties
```plantuml
!$SHOW_LEGEND = %true()
LAYOUT_WITH_LEGEND()
```

## 📝 Notes

- All diagrams use official C4-PlantUML library
- Requires internet for includes (or download locally)
- SVG format recommended for presentations
- PNG works better for documentation
- Keep source `.puml` files in version control

## 🤝 Contributing

When adding new C4 diagrams:
1. Follow C4 Model principles
2. Use official C4-PlantUML includes
3. Add entry to this README
4. Test rendering before committing
5. Update main UML README

---

**Last Updated**: October 2025  
**Total C4 Diagrams**: 11  
**Format**: C4-PlantUML (.puml)  
**C4 Model Version**: Latest  

**Created by**: AI Assistant (Claude)  
**For**: BC Wallet Mobile SSI Project
