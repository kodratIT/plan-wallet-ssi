# Sprint 0: Project Initialization - Sphereon SSI Wallet

## 📋 Task Overview

**Task**: Sprint 0 - Project Setup & Initialization  
**Duration**: 1 Week (40 hours)  
**Team**: 6-8 developers  
**Priority**: CRITICAL - Must complete before Sprint 1  
**Platform**: iOS & Android (React Native + Expo)

---

## 🎯 Sprint Goal

*"Setup complete development environment, initialize React Native + Expo project, configure all tools, and ensure all team members ready to develop."*

---

## ✅ Objectives

Setelah menyelesaikan Sprint 0, setiap team member harus:

1. ✅ Development environment ter-install lengkap
2. ✅ Project React Native + Expo running di emulator/device
3. ✅ Semua dependencies ter-install
4. ✅ Development tools (IDE, debugger, etc.) ter-configure
5. ✅ Memahami project structure
6. ✅ Memahami tech stack yang digunakan
7. ✅ Ready untuk mulai Sprint 1

---

## 🛠️ Tech Stack Overview

### Core Framework
- **React Native**: 0.73.x
- **Expo**: 50.x (SDK 50+)
- **TypeScript**: 5.x
- **Node.js**: 18.x LTS atau 20.x LTS

### SSI & Identity
- **@sphereon/ssi-sdk-core**: SSI operations
- **@sphereon/ssi-sdk-oid4vci**: OpenID4VCI
- **@sphereon/ssi-sdk-oid4vp**: OpenID4VP
- **@sphereon/ssi-sdk-did**: DID management
- **@sphereon/ssi-sdk-credential**: Credential operations

### State Management & Data
- **React Context API** / **Redux Toolkit** (pilih salah satu)
- **AsyncStorage**: Local persistence
- **Realm** / **WatermelonDB**: Secure database (optional)

### Navigation & UI
- **React Navigation**: Navigation library
- **React Native Paper** / **NativeBase**: UI components
- **React Native Reanimated**: Animations

### Security
- **expo-crypto**: Cryptographic operations
- **expo-secure-store**: Secure key storage
- **expo-local-authentication**: Biometric authentication

### Development Tools
- **ESLint**: Code linting
- **Prettier**: Code formatting
- **TypeScript**: Type checking
- **Jest**: Unit testing
- **Detox**: E2E testing

---

## 📁 Expected Project Structure

```
sphereon-wallet/
├── .expo/                      # Expo configuration
├── .vscode/                    # VS Code settings
├── android/                    # Android native code (if ejected)
├── ios/                        # iOS native code (if ejected)
├── src/
│   ├── app/                    # App initialization
│   ├── assets/                 # Images, fonts, etc.
│   ├── components/             # Reusable React components
│   │   ├── common/             # Common UI components
│   │   ├── credentials/        # Credential-related components
│   │   ├── connections/        # Connection-related components
│   │   └── security/           # Security components (PIN, biometric)
│   ├── config/                 # App configuration
│   │   ├── env.ts              # Environment variables
│   │   └── constants.ts        # App constants
│   ├── contexts/               # React Context providers
│   │   ├── AuthContext.tsx     # Authentication context
│   │   ├── WalletContext.tsx   # Wallet state context
│   │   └── ThemeContext.tsx    # Theme context
│   ├── hooks/                  # Custom React hooks
│   │   ├── useCredentials.ts   # Credential operations hook
│   │   ├── useConnections.ts   # Connection operations hook
│   │   └── useBiometric.ts     # Biometric authentication hook
│   ├── navigation/             # Navigation configuration
│   │   ├── AppNavigator.tsx    # Main navigator
│   │   ├── AuthNavigator.tsx   # Auth flow navigator
│   │   └── MainNavigator.tsx   # Main app navigator
│   ├── screens/                # Screen components
│   │   ├── auth/               # Authentication screens
│   │   ├── credentials/        # Credential screens
│   │   ├── connections/        # Connection screens
│   │   ├── settings/           # Settings screens
│   │   └── onboarding/         # Onboarding screens
│   ├── services/               # Business logic services
│   │   ├── ssi/                # SSI SDK wrappers
│   │   │   ├── CredentialService.ts
│   │   │   ├── DIDService.ts
│   │   │   ├── OID4VCIService.ts
│   │   │   └── OID4VPService.ts
│   │   ├── storage/            # Storage services
│   │   │   ├── SecureStorage.ts
│   │   │   └── Database.ts
│   │   └── network/            # Network services
│   │       └── ApiClient.ts
│   ├── types/                  # TypeScript type definitions
│   │   ├── credential.types.ts
│   │   ├── connection.types.ts
│   │   └── navigation.types.ts
│   └── utils/                  # Utility functions
│       ├── crypto.ts           # Cryptographic utilities
│       ├── validation.ts       # Validation utilities
│       └── logger.ts           # Logging utilities
├── __tests__/                  # Test files
├── .env.example                # Environment variables example
├── .eslintrc.js                # ESLint configuration
├── .prettierrc                 # Prettier configuration
├── app.json                    # Expo configuration
├── babel.config.js             # Babel configuration
├── package.json                # Dependencies
├── tsconfig.json               # TypeScript configuration
└── README.md                   # Project documentation
```

---

## 📋 Deliverables Sprint 0

### Documentation
- ✅ **README.md** - Setup instructions lengkap (this file)
- ✅ **SETUP-GUIDE.md** - Step-by-step setup untuk setiap platform
- ✅ **ARCHITECTURE.md** - Architecture overview dengan C4 diagrams
- ✅ **CONTRIBUTING.md** - Coding standards & contribution guidelines

### C4 Diagrams
- ✅ **01-system-context.puml** - System context diagram
- ✅ **02-container-diagram.puml** - Container architecture
- ✅ **03-component-diagram.puml** - Component structure
- ✅ **04-deployment-diagram.puml** - Deployment architecture

### Configuration Files
- ✅ **package.json** - All dependencies configured
- ✅ **app.json** - Expo configuration
- ✅ **tsconfig.json** - TypeScript configuration
- ✅ **.eslintrc.js** - ESLint rules
- ✅ **.prettierrc** - Code formatting rules
- ✅ **.env.example** - Environment variables template

### Project Scaffold
- ✅ Basic project structure created
- ✅ Navigation setup
- ✅ Sample screens (Home, Settings)
- ✅ Basic styling/theming
- ✅ Running on emulator/device

---

## 🔧 Prerequisites - Required Software

### 1. Operating System Requirements

**macOS** (for iOS development):
- macOS Ventura (13.x) atau Sonoma (14.x)
- Xcode 15.x
- Xcode Command Line Tools

**Windows** (for Android development only):
- Windows 10/11 (64-bit)
- Windows Subsystem for Linux 2 (WSL2) - recommended

**Linux** (for Android development):
- Ubuntu 20.04 LTS atau newer
- Debian-based distros recommended

### 2. Core Tools (All Platforms)

**Node.js**
```bash
# Version: 18.x LTS (recommended) atau 20.x LTS
# Download: https://nodejs.org/

# Verify installation
node --version    # Should show v18.x.x or v20.x.x
npm --version     # Should show v9.x.x or v10.x.x
```

**Git**
```bash
# Version: 2.x or newer
# Download: https://git-scm.com/

# Verify installation
git --version     # Should show git version 2.x.x
```

**Watchman** (macOS/Linux - recommended for React Native)
```bash
# macOS
brew install watchman

# Linux
# Follow: https://facebook.github.io/watchman/docs/install

# Verify installation
watchman --version
```

### 3. Package Manager (Choose One)

**npm** (comes with Node.js)
```bash
npm --version
```

**Yarn** (alternative, faster)
```bash
# Install
npm install -g yarn

# Verify
yarn --version
```

### 4. Expo CLI

```bash
# Install globally
npm install -g expo-cli

# Or use npx (no global install needed)
npx expo --version

# Install EAS CLI (for builds & updates)
npm install -g eas-cli

# Verify
expo --version
eas --version
```

### 5. Mobile Development Tools

#### Android Development

**Android Studio**
- Download: https://developer.android.com/studio
- Version: Latest stable (Hedgehog 2023.1.1 atau newer)

**Android SDK**
- API Level 33 (Android 13) - Minimum
- API Level 34 (Android 14) - Target
- Android SDK Build-Tools
- Android Emulator
- Android SDK Platform-Tools

**Java Development Kit (JDK)**
```bash
# JDK 11 atau JDK 17 (recommended for React Native)
# Download: https://adoptium.net/

# Verify
java -version
javac -version
```

**Environment Variables (Android)**
```bash
# Add to ~/.bashrc, ~/.zshrc, atau ~/.bash_profile

# macOS/Linux
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# Windows
ANDROID_HOME=C:\Users\[YourUsername]\AppData\Local\Android\Sdk
Path=%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\emulator;%ANDROID_HOME%\tools;%ANDROID_HOME%\tools\bin
```

#### iOS Development (macOS only)

**Xcode**
- Download: Mac App Store
- Version: 15.x atau newer
- Install Xcode Command Line Tools:
  ```bash
  xcode-select --install
  ```

**CocoaPods**
```bash
# Install
sudo gem install cocoapods

# Or via Homebrew
brew install cocoapods

# Verify
pod --version
```

**iOS Simulator**
- Included with Xcode
- Install additional simulators: Xcode → Settings → Platforms

### 6. Code Editor

**Visual Studio Code** (recommended)
- Download: https://code.visualstudio.com/

**Required Extensions:**
- ESLint
- Prettier - Code formatter
- React Native Tools
- TypeScript and JavaScript Language Features
- Path Intellisense
- GitLens
- Auto Rename Tag
- Bracket Pair Colorizer

**Optional Extensions:**
- React Native Snippet
- ES7+ React/Redux/React-Native snippets
- Material Icon Theme
- One Dark Pro (theme)

### 7. Testing Tools

**Expo Go App** (for testing on physical devices)
- iOS: App Store
- Android: Google Play Store

**Optional: React Native Debugger**
```bash
# macOS
brew install --cask react-native-debugger

# Or download from:
# https://github.com/jhen0409/react-native-debugger/releases
```

### 8. Version Control & Collaboration

**GitHub Account**
- Create account: https://github.com/
- Setup SSH keys: https://docs.github.com/en/authentication

**Git Configuration**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## 🚀 Quick Start Checklist

Use this checklist untuk memastikan semua prerequisites ter-install:

### macOS (iOS + Android)
- [ ] macOS Ventura/Sonoma
- [ ] Xcode 15.x installed
- [ ] Xcode Command Line Tools installed
- [ ] Node.js 18.x/20.x LTS installed
- [ ] Watchman installed
- [ ] CocoaPods installed
- [ ] Android Studio installed
- [ ] Android SDK installed (API 33, 34)
- [ ] ANDROID_HOME environment variable set
- [ ] JDK 11/17 installed
- [ ] Git installed & configured
- [ ] VS Code installed with extensions
- [ ] Expo CLI installed
- [ ] EAS CLI installed
- [ ] Expo Go app installed on device

### Windows (Android only)
- [ ] Windows 10/11 (64-bit)
- [ ] WSL2 installed (optional but recommended)
- [ ] Node.js 18.x/20.x LTS installed
- [ ] Android Studio installed
- [ ] Android SDK installed (API 33, 34)
- [ ] ANDROID_HOME environment variable set
- [ ] JDK 11/17 installed
- [ ] Git installed & configured
- [ ] VS Code installed with extensions
- [ ] Expo CLI installed
- [ ] EAS CLI installed
- [ ] Expo Go app installed on device

### Linux (Android only)
- [ ] Ubuntu 20.04+ or equivalent
- [ ] Node.js 18.x/20.x LTS installed
- [ ] Watchman installed
- [ ] Android Studio installed
- [ ] Android SDK installed (API 33, 34)
- [ ] ANDROID_HOME environment variable set
- [ ] JDK 11/17 installed
- [ ] Git installed & configured
- [ ] VS Code installed with extensions
- [ ] Expo CLI installed
- [ ] EAS CLI installed
- [ ] Expo Go app installed on device

---

## 📝 Next Steps

Setelah semua prerequisites ter-install:

1. **Read**: [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Detailed step-by-step setup
2. **Read**: [ARCHITECTURE.md](./ARCHITECTURE.md) - Understand project architecture
3. **View**: Diagrams di folder `diagrams/` - Visual architecture overview
4. **Follow**: Setup instructions untuk initialize project
5. **Verify**: Run project di emulator/device
6. **Join**: Daily standup dan team sync

---

## 🔗 Additional Resources

### Official Documentation
- **React Native**: https://reactnative.dev/docs/environment-setup
- **Expo**: https://docs.expo.dev/
- **Sphereon SSI-SDK**: https://github.com/Sphereon-Opensource/ssi-sdk
- **React Navigation**: https://reactnavigation.org/docs/getting-started
- **TypeScript**: https://www.typescriptlang.org/docs/

### Learning Resources
- **React Native Tutorial**: https://reactnative.dev/docs/tutorial
- **Expo Tutorial**: https://docs.expo.dev/tutorial/introduction/
- **SSI Concepts**: https://www.w3.org/TR/vc-data-model/
- **DID Spec**: https://www.w3.org/TR/did-core/

### Community
- **React Native Discord**: https://discord.gg/reactiflux
- **Expo Discord**: https://discord.gg/expo
- **Sphereon Community**: https://github.com/Sphereon-Opensource

---

## 💬 Getting Help

### Internal Support
- **Setup Issues**: Ask in #dev-setup Slack channel
- **Technical Questions**: Ask in #technical Slack channel
- **Scrum Questions**: Contact Scrum Master
- **Tools Issues**: Contact DevOps Engineer

### External Support
- **React Native Issues**: Stack Overflow dengan tag `react-native`
- **Expo Issues**: Expo Forums https://forums.expo.dev/
- **SSI-SDK Issues**: GitHub Issues https://github.com/Sphereon-Opensource/ssi-sdk/issues

---

## 🎯 Success Criteria Sprint 0

Sprint 0 dianggap berhasil ketika:

- [ ] ✅ All team members have development environment setup
- [ ] ✅ Project initialized dan running di emulator/device
- [ ] ✅ All dependencies installed successfully
- [ ] ✅ Code editor configured dengan required extensions
- [ ] ✅ Team familiar dengan project structure
- [ ] ✅ Basic navigation working
- [ ] ✅ Sample screen dapat di-build dan di-run
- [ ] ✅ Git repository setup dengan proper .gitignore
- [ ] ✅ CI/CD pipeline basic setup (optional untuk Sprint 0)
- [ ] ✅ All team members attended kickoff meeting
- [ ] ✅ Sprint 1 planning completed

---

## 📅 Sprint 0 Timeline

**Week 0 Breakdown:**

**Day 1: Environment Setup (8h)**
- Morning: Team kickoff meeting (2h)
- Install Node.js, Git, Watchman (1h)
- Install Android Studio / Xcode (3h)
- Install VS Code & extensions (1h)
- Install Expo CLI, EAS CLI (1h)

**Day 2: Project Initialization (8h)**
- Initialize Expo project (2h)
- Setup folder structure (2h)
- Install dependencies (2h)
- Configure TypeScript, ESLint, Prettier (2h)

**Day 3: Basic Configuration (8h)**
- Setup navigation (3h)
- Create sample screens (3h)
- Configure theming (2h)

**Day 4: Documentation & Testing (8h)**
- Create documentation (4h)
- Test on emulator/device (2h)
- Fix setup issues (2h)

**Day 5: Team Sync & Sprint 1 Planning (8h)**
- Team demo: running app (2h)
- Address team issues (2h)
- Sprint 1 planning meeting (4h)

**Total**: 40 hours (1 week)

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Ready for Team
