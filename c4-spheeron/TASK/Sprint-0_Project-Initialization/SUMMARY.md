# Sprint 0: Project Initialization - Quick Summary

## 📊 Overview

**Sprint**: Sprint 0 (Preparation)  
**Duration**: 1 Week (40 hours)  
**Goal**: Setup complete development environment untuk Sphereon SSI Wallet  
**Status**: ✅ Ready for Implementation

---

## 🎯 Objectives

Sprint 0 bertujuan untuk mempersiapkan development environment SEBELUM mulai implementasi fitur di Sprint 1. Setiap team member harus bisa:

1. ✅ Run React Native + Expo project
2. ✅ Build dan test di emulator/device
3. ✅ Understand project structure
4. ✅ Ready untuk develop Sprint 1 features

---

## 🛠️ Tech Stack

### Platform & Framework
- **React Native**: 0.73.x
- **Expo**: SDK 50+
- **TypeScript**: 5.x
- **Node.js**: 18.x atau 20.x LTS

### SSI Libraries
- **@sphereon/ssi-sdk-core**: Core SSI operations
- **@sphereon/ssi-sdk-oid4vci**: OpenID4VCI (credential issuance)
- **@sphereon/ssi-sdk-oid4vp**: OpenID4VP (credential presentation)
- **@sphereon/ssi-sdk-did**: DID management

### UI & Navigation
- **React Navigation**: Navigation library
- **React Native Paper**: Material Design components
- **React Native Reanimated**: Smooth animations

### Security
- **expo-secure-store**: Secure key storage
- **expo-local-authentication**: Biometric authentication
- **expo-crypto**: Cryptographic operations

---

## 📋 Deliverables

### ✅ Documentation (4 files)
1. **README.md** - Overview & prerequisites
2. **SETUP-GUIDE.md** - Step-by-step setup (macOS, Windows, Linux)
3. **SUMMARY.md** - Quick summary (this file)
4. **diagrams/** - Architecture visualization

### ✅ C4 Diagrams (4 diagrams)
1. **01-system-context.puml** - Big picture view
2. **02-container-diagram.puml** - High-level architecture
3. **03-component-diagram.puml** - Internal structure
4. **04-deployment-diagram.puml** - Development & production setup

### 🔜 Project Structure (Sprint 0 will create)
```
sphereon-wallet/
├── src/
│   ├── components/     # Reusable UI components
│   ├── screens/        # Screen components
│   ├── services/       # Business logic (SSI operations)
│   ├── navigation/     # Navigation configuration
│   ├── contexts/       # React Context providers
│   ├── hooks/          # Custom React hooks
│   ├── types/          # TypeScript definitions
│   ├── utils/          # Utility functions
│   └── config/         # App configuration
├── assets/             # Images, fonts
├── __tests__/          # Test files
└── [config files]      # package.json, tsconfig.json, etc.
```

---

## 🚀 Quick Start

### For macOS (iOS + Android Development)

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Node.js, Watchman, Git
brew install node@20 watchman git

# 3. Install Xcode dari App Store (untuk iOS)
# Download dari App Store (16+ GB, 1-2 jam)
xcode-select --install  # Command Line Tools

# 4. Install Android Studio (untuk Android)
# Download dari https://developer.android.com/studio
# Install Android SDK (API 33, 34)

# 5. Install CocoaPods
sudo gem install cocoapods

# 6. Install Expo CLI
npm install -g expo-cli eas-cli

# 7. Create project
npx create-expo-app sphereon-wallet --template expo-template-blank-typescript
cd sphereon-wallet

# 8. Start development server
npx expo start

# 9. Test
# Press 'a' untuk Android emulator
# Press 'i' untuk iOS simulator
```

### For Windows (Android Only)

```powershell
# 1. Install Node.js
# Download dari https://nodejs.org/ (20.x LTS)

# 2. Install Android Studio
# Download dari https://developer.android.com/studio

# 3. Setup Android SDK & environment variables
# ANDROID_HOME = C:\Users\[YourUsername]\AppData\Local\Android\Sdk

# 4. Install Git
# Download dari https://git-scm.com/

# 5. Install Expo CLI
npm install -g expo-cli eas-cli

# 6. Create & run project (same as macOS steps 7-9)
```

### For Linux (Android Only)

```bash
# 1. Install Node.js via NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# 2. Install Watchman (from source - see SETUP-GUIDE.md)

# 3. Install Android Studio
# Download dari https://developer.android.com/studio

# 4. Install JDK
sudo apt install -y openjdk-17-jdk

# 5. Install Expo CLI
sudo npm install -g expo-cli eas-cli

# 6. Create & run project (same as macOS steps 7-9)
```

---

## 📦 Required Software Summary

| Software | macOS | Windows | Linux |
|----------|-------|---------|-------|
| **Node.js** (18/20 LTS) | ✅ Required | ✅ Required | ✅ Required |
| **Expo CLI** | ✅ Required | ✅ Required | ✅ Required |
| **Git** | ✅ Required | ✅ Required | ✅ Required |
| **VS Code** | ✅ Recommended | ✅ Recommended | ✅ Recommended |
| **Watchman** | ✅ Recommended | ❌ N/A | ✅ Recommended |
| **Xcode** (iOS) | ✅ Required | ❌ N/A | ❌ N/A |
| **CocoaPods** (iOS) | ✅ Required | ❌ N/A | ❌ N/A |
| **Android Studio** | ✅ Required | ✅ Required | ✅ Required |
| **JDK** (11/17) | ✅ Required | ✅ Required | ✅ Required |

---

## 📅 Sprint 0 Timeline

### Day 1: Environment Setup (8h)
- [ ] Team kickoff meeting (2h)
- [ ] Install Node.js, Git, Watchman (1h)
- [ ] Install Android Studio / Xcode (3h)
- [ ] Install VS Code & extensions (1h)
- [ ] Install Expo CLI (1h)

### Day 2: Project Initialization (8h)
- [ ] Create Expo project (2h)
- [ ] Setup folder structure (2h)
- [ ] Install dependencies (2h)
- [ ] Configure TypeScript, ESLint, Prettier (2h)

### Day 3: Basic Configuration (8h)
- [ ] Setup navigation (3h)
- [ ] Create sample screens (3h)
- [ ] Configure theming (2h)

### Day 4: Documentation & Testing (8h)
- [ ] Create documentation (4h)
- [ ] Test on emulator/device (2h)
- [ ] Fix setup issues (2h)

### Day 5: Team Sync & Sprint 1 Planning (8h)
- [ ] Team demo: running app (2h)
- [ ] Address team issues (2h)
- [ ] Sprint 1 planning meeting (4h)

---

## ✅ Success Criteria

Sprint 0 berhasil jika:

- [ ] ✅ All team members development environment ready
- [ ] ✅ Project initialized dan running
- [ ] ✅ `npx expo start` works tanpa error
- [ ] ✅ App runs di Android emulator (press 'a')
- [ ] ✅ App runs di iOS simulator (press 'i') - macOS only
- [ ] ✅ App runs di physical device via Expo Go
- [ ] ✅ Hot reload working (edit App.tsx → see changes)
- [ ] ✅ TypeScript compilation working
- [ ] ✅ ESLint working (npm run lint)
- [ ] ✅ Project structure created
- [ ] ✅ Team ready untuk Sprint 1

---

## 🎨 Architecture Overview

### System Context
```
User → [Sphereon Wallet App] ↔ Credential Issuers
                             ↔ Credential Verifiers
                             ↔ DID Registries
                             ↔ DIDComm Mediator
```

### Container Architecture
```
UI Layer (React Components)
    ↓
State Management (Context/Redux)
    ↓
Business Logic (TypeScript Services)
    ↓
Sphereon SSI-SDK
    ↓
Native Modules (Secure Storage, Biometric, Camera)
    ↓
Local Storage (AsyncStorage)
```

### Development Flow
```
Developer → VS Code → Metro Bundler → Expo Go App → Mobile Device
                                   → Android Emulator
                                   → iOS Simulator
```

---

## 📚 Key Commands

```bash
# Create project
npx create-expo-app sphereon-wallet --template expo-template-blank-typescript

# Install dependencies
npm install

# Start development server
npx expo start

# Run on Android
npx expo start
# Then press 'a' atau:
npx expo run:android

# Run on iOS (macOS only)
npx expo start
# Then press 'i' atau:
npx expo run:ios

# Lint code
npm run lint

# Format code
npm run format

# Run tests
npm test

# Clear cache
npx expo start --clear
```

---

## 🔗 Documentation Links

### Internal Documentation
- **[README.md](./README.md)** - Complete overview & prerequisites
- **[SETUP-GUIDE.md](./SETUP-GUIDE.md)** - Detailed setup instructions
- **[diagrams/](./diagrams/)** - C4 architecture diagrams

### Official Documentation
- **React Native**: https://reactnative.dev/
- **Expo**: https://docs.expo.dev/
- **Sphereon SSI-SDK**: https://github.com/Sphereon-Opensource/ssi-sdk
- **React Navigation**: https://reactnavigation.org/
- **TypeScript**: https://www.typescriptlang.org/

---

## 🐛 Common Issues

### Issue: Metro Bundler Port Busy
```bash
# Solution: Kill process on port 8081
lsof -ti:8081 | xargs kill -9
# Or use different port
npx expo start --port 8082
```

### Issue: Module Not Found
```bash
# Solution: Clear cache and reinstall
rm -rf node_modules
npm install
npx expo start --clear
```

### Issue: Android Emulator Won't Start
```
# Solution: Check virtualization enabled
# Allocate more RAM in AVD settings (4GB+)
```

### Issue: iOS Build Fails
```bash
# Solution: Install CocoaPods dependencies
cd ios
pod install
cd ..
npx expo run:ios
```

---

## 👥 Team Responsibilities

### All Team Members
- Setup development environment
- Install required tools
- Test project on emulator/device
- Attend Sprint 1 planning

### Lead React Native Developer
- Create project structure
- Setup navigation
- Configure build tools
- Create coding standards

### SSI Specialist
- Verify SSI-SDK installation
- Test SSI operations
- Create service interfaces

### DevOps Engineer (Part-time)
- Setup Git repository
- Configure CI/CD basics (optional Sprint 0)
- Create deployment documentation

---

## 🎯 Next Steps After Sprint 0

1. ✅ Environment ready → Start Sprint 1
2. 📖 Read Sprint 1 user stories
3. 🏃 Daily standups (15 min)
4. 💻 Implement onboarding & security features
5. 🧪 Write tests
6. 🔄 Sprint review & retrospective

---

## 📞 Getting Help

### Internal Support
- **Setup Issues**: #dev-setup Slack channel
- **Technical Questions**: #technical Slack channel
- **Scrum Questions**: Scrum Master

### External Support
- **React Native**: Stack Overflow `react-native` tag
- **Expo**: https://forums.expo.dev/
- **SSI-SDK**: GitHub Issues

---

## 📈 Sprint Metrics

**Planned**:
- Duration: 5 days (40 hours)
- Team Size: 6-8 developers
- Deliverables: 4 docs + 4 diagrams + working project

**Success Rate**: Target 100% team ready

---

**Document Status**: ✅ Complete  
**Last Updated**: 2024  
**Version**: 1.0

**Ready to Start? Follow [SETUP-GUIDE.md](./SETUP-GUIDE.md) untuk detailed instructions!**
