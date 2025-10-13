# Sprint 0: Project Initialization - Navigation Index

## 📚 Selamat Datang!

Ini adalah dokumentasi lengkap untuk **Sprint 0: Project Initialization** - Sphereon SSI Wallet (React Native + Expo).

Sprint 0 adalah tahap persiapan SEBELUM mulai implementasi. Goal-nya adalah memastikan semua team members punya development environment yang ready dan bisa run project.

---

## 🗂️ Struktur Dokumentasi

```
Sprint-0_Project-Initialization/
├── INDEX.md                    📍 File ini - Panduan navigasi
├── README.md                   ⭐ START HERE - Overview & prerequisites
├── SETUP-GUIDE.md              🔧 Step-by-step setup instructions
├── SUMMARY.md                  📊 Quick summary & cheat sheet
└── diagrams/                   📐 C4 UML Diagrams (4 files)
    ├── 01-system-context.puml         Big picture view
    ├── 02-container-diagram.puml      Architecture layers
    ├── 03-component-diagram.puml      Internal structure
    └── 04-deployment-diagram.puml     Dev & production setup
```

---

## 🎯 Mulai Dari Mana?

### 👉 Saya Baru Join Project
**Start Here** → [README.md](./README.md)
1. Baca overview project
2. Check prerequisites (tools yang harus di-install)
3. Lihat tech stack yang digunakan
4. Understand project structure

**Then** → [SUMMARY.md](./SUMMARY.md)
- Quick overview
- Key commands
- Success criteria

### 👉 Saya Mau Setup Development Environment
**Follow This** → [SETUP-GUIDE.md](./SETUP-GUIDE.md)

**Pilih sesuai platform:**
- **macOS User** (iOS + Android): Follow "macOS Setup" section
- **Windows User** (Android only): Follow "Windows Setup" section
- **Linux User** (Android only): Follow "Linux Setup" section

**Step-by-step akan guide Anda:**
1. Install Node.js, Git, Watchman
2. Install Android Studio / Xcode
3. Install Expo CLI
4. Create project
5. Run project di emulator/device

### 👉 Saya Mau Lihat Architecture
**View Diagrams** → [diagrams/](./diagrams/)

**Recommended order:**
1. **[01-system-context.puml](./diagrams/01-system-context.puml)** - Lihat big picture dulu
2. **[02-container-diagram.puml](./diagrams/02-container-diagram.puml)** - Architecture layers
3. **[03-component-diagram.puml](./diagrams/03-component-diagram.puml)** - Internal components
4. **[04-deployment-diagram.puml](./diagrams/04-deployment-diagram.puml)** - How it deploys

**Cara view diagrams:**
- Online: Copy paste ke https://www.plantuml.com/plantuml/uml/
- VS Code: Install "PlantUML" extension, lalu Alt+D
- Generate PNG: `brew install plantuml` lalu `plantuml *.puml`

### 👉 Saya Sudah Setup, Mau Quick Reference
**Go To** → [SUMMARY.md](./SUMMARY.md)
- Quick start commands
- Common issues & solutions
- Key information at a glance

### 👉 Saya Punya Issues/Errors
**Check** → [SETUP-GUIDE.md](./SETUP-GUIDE.md#troubleshooting)
- Common issues & solutions
- Metro bundler errors
- Emulator problems
- Build failures

---

## 📖 Reading Guide by Role

### 🏗️ Lead React Native Developer

**Your Focus**: Project initialization, architecture, standards

**Reading Order**:
1. [README.md](./README.md) - Complete read
2. All diagrams ([diagrams/](./diagrams/)) - Understand architecture
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Know team setup process
4. [SUMMARY.md](./SUMMARY.md) - Quick reference

**Your Tasks Sprint 0**:
- Create project structure
- Setup navigation boilerplate
- Configure build tools (TypeScript, ESLint, Prettier)
- Create coding standards document
- Help team members with setup issues

### 👨‍💻 React Native Developers

**Your Focus**: Environment setup, understand structure

**Reading Order**:
1. [README.md](./README.md) - Understand prerequisites
2. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Follow setup for your platform
3. [SUMMARY.md](./SUMMARY.md) - Quick commands
4. [diagrams/02-container-diagram.puml](./diagrams/02-container-diagram.puml) - Architecture

**Your Tasks Sprint 0**:
- Setup development environment
- Install all required tools
- Run project successfully
- Test hot reload
- Familiarize dengan project structure

### 🔐 SSI Specialist

**Your Focus**: SSI-SDK integration understanding

**Reading Order**:
1. [README.md](./README.md) - Tech stack, especially SSI section
2. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Setup environment
3. [diagrams/03-component-diagram.puml](./diagrams/03-component-diagram.puml) - Service layer
4. Sphereon SSI-SDK docs (external)

**Your Tasks Sprint 0**:
- Setup environment
- Study Sphereon SSI-SDK documentation
- Verify SSI-SDK dependencies install correctly
- Plan service interfaces
- Test basic SSI operations

### 🎨 UI/UX Designer

**Your Focus**: Design system, components

**Reading Order**:
1. [README.md](./README.md) - Project overview
2. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Setup environment (untuk preview designs)
3. [SUMMARY.md](./SUMMARY.md) - UI libraries used

**Your Tasks Sprint 0**:
- Setup environment (untuk run app)
- Study React Native Paper / Material Design
- Create design system
- Prepare mockups untuk Sprint 1 screens
- Define color palette, typography, spacing

### 🧪 QA Engineer

**Your Focus**: Testing strategy, tools

**Reading Order**:
1. [README.md](./README.md) - Testing tools section
2. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Setup both iOS & Android
3. [diagrams/04-deployment-diagram.puml](./diagrams/04-deployment-diagram.puml)

**Your Tasks Sprint 0**:
- Setup development environment
- Setup multiple emulators (different API levels)
- Setup physical devices for testing
- Plan testing strategy
- Study Jest, Detox documentation

### 🔧 DevOps Engineer

**Your Focus**: Build, deployment, CI/CD

**Reading Order**:
1. [README.md](./README.md) - Build tools
2. [diagrams/04-deployment-diagram.puml](./diagrams/04-deployment-diagram.puml)
3. EAS Build documentation (external)

**Your Tasks Sprint 0**:
- Setup Git repository
- Plan CI/CD pipeline (GitHub Actions)
- Setup EAS Build account (optional untuk Sprint 0)
- Create deployment documentation
- Plan monitoring strategy

### 📊 Product Owner / Scrum Master

**Your Focus**: Progress tracking, team readiness

**Reading Order**:
1. [SUMMARY.md](./SUMMARY.md) - Quick overview
2. [README.md](./README.md) - Success criteria
3. [SETUP-GUIDE.md](./SETUP-GUIDE.md) - Understand what team doing

**Your Tasks Sprint 0**:
- Track team setup progress
- Ensure all team members ready by end of week
- Prepare Sprint 1 planning
- Review Sprint 1 backlog
- Schedule Sprint 1 kickoff

---

## ✅ Sprint 0 Checklist

Use this untuk track progress:

### Day 1: Environment Setup
- [ ] Team kickoff meeting attended
- [ ] Node.js installed
- [ ] Git installed & configured
- [ ] Android Studio installed (if needed)
- [ ] Xcode installed (if macOS, for iOS)
- [ ] VS Code installed with extensions
- [ ] Expo CLI installed

### Day 2: Project Initialization
- [ ] Project created (`npx create-expo-app`)
- [ ] Dependencies installed (`npm install`)
- [ ] Project runs (`npx expo start`)
- [ ] Folder structure created
- [ ] TypeScript configured
- [ ] ESLint & Prettier configured

### Day 3: Testing & Verification
- [ ] App runs on Android emulator
- [ ] App runs on iOS simulator (if macOS)
- [ ] App runs on physical device (Expo Go)
- [ ] Hot reload working
- [ ] No TypeScript errors
- [ ] Lint passing

### Day 4: Team Sync
- [ ] All team members setup complete
- [ ] Architecture diagrams reviewed
- [ ] Coding standards defined
- [ ] Git repository setup
- [ ] Team demo successful

### Day 5: Sprint 1 Planning
- [ ] Sprint 1 backlog reviewed
- [ ] User stories estimated
- [ ] Sprint 1 goal defined
- [ ] Tasks assigned
- [ ] Ready to start Sprint 1

---

## 📋 Key Information At A Glance

### Required Software

| Tool | Version | Purpose |
|------|---------|---------|
| Node.js | 18.x atau 20.x LTS | JavaScript runtime |
| npm | 9.x atau 10.x | Package manager |
| Expo CLI | Latest | Development tool |
| Git | 2.x+ | Version control |
| Android Studio | Latest | Android development |
| Xcode | 15.x+ | iOS development (macOS) |
| VS Code | Latest | Code editor |

### Tech Stack

| Category | Technology |
|----------|-----------|
| **Platform** | React Native 0.73+ |
| **Framework** | Expo SDK 50+ |
| **Language** | TypeScript 5+ |
| **Navigation** | React Navigation 6+ |
| **UI Library** | React Native Paper |
| **State** | React Context / Redux |
| **Storage** | AsyncStorage, Secure Store |
| **SSI** | Sphereon SSI-SDK |

### Project Structure

```
src/
├── components/     # Reusable UI components
├── screens/        # Screen components
├── services/       # Business logic (SSI operations)
├── navigation/     # Navigation config
├── contexts/       # React Context providers
├── hooks/          # Custom hooks
├── types/          # TypeScript types
├── utils/          # Utility functions
└── config/         # App configuration
```

### Common Commands

```bash
# Create project
npx create-expo-app sphereon-wallet --template expo-template-blank-typescript

# Install dependencies
npm install

# Start dev server
npx expo start

# Run on Android
npx expo start → press 'a'

# Run on iOS
npx expo start → press 'i'

# Clear cache
npx expo start --clear

# Lint
npm run lint

# Format
npm run format
```

---

## 🐛 Quick Troubleshooting

### Port already in use?
```bash
lsof -ti:8081 | xargs kill -9
```

### Module not found?
```bash
rm -rf node_modules
npm install
npx expo start --clear
```

### Android emulator slow?
- Allocate more RAM (4GB+)
- Use ARM64 image (Apple Silicon)
- Enable hardware acceleration

### iOS build fails?
```bash
cd ios && pod install && cd ..
```

**For more**: See [SETUP-GUIDE.md](./SETUP-GUIDE.md#troubleshooting)

---

## 🔗 External Resources

### Official Documentation
- **React Native**: https://reactnative.dev/
- **Expo**: https://docs.expo.dev/
- **Sphereon SSI-SDK**: https://github.com/Sphereon-Opensource/ssi-sdk
- **React Navigation**: https://reactnavigation.org/
- **TypeScript**: https://www.typescriptlang.org/

### Learning Resources
- **React Native Tutorial**: https://reactnative.dev/docs/tutorial
- **Expo Tutorial**: https://docs.expo.dev/tutorial/introduction/
- **TypeScript Handbook**: https://www.typescriptlang.org/docs/handbook/

### Community
- **React Native Discord**: https://discord.gg/reactiflux
- **Expo Discord**: https://discord.gg/expo
- **Sphereon**: https://github.com/Sphereon-Opensource

---

## 📞 Getting Help

### Internal
- **Setup Issues**: #dev-setup Slack channel
- **Technical**: #technical Slack channel
- **Scrum**: Scrum Master

### External
- **React Native**: Stack Overflow tag `react-native`
- **Expo**: https://forums.expo.dev/
- **SSI-SDK**: GitHub Issues

---

## 🎯 Success Criteria

Sprint 0 is **SUCCESSFUL** when:

- ✅ **100% team members** setup complete
- ✅ **Project running** on all platforms (Android/iOS emulators, physical devices)
- ✅ **No blocking issues** for Sprint 1
- ✅ **Architecture understood** by all team
- ✅ **Coding standards** defined
- ✅ **Sprint 1 planned** and ready to start

---

## 📈 Next Steps

After Sprint 0 complete:

1. **Sprint 1 Kickoff** - Monday Week 1
2. **Implement**: Onboarding & Security features
3. **Daily Standups**: 9 AM, 15 minutes
4. **Sprint 1 Goal**: "Implement critical security features"

---

## 📊 Documentation Metrics

**Created**:
- 3 markdown documents (README, SETUP-GUIDE, SUMMARY)
- 4 C4 architecture diagrams
- 1 navigation guide (this file)

**Total**: ~15,000 words of documentation
**Diagrams**: 4 detailed PlantUML diagrams
**Estimated reading time**: 2-3 hours untuk complete understanding

---

**Status**: ✅ Complete & Ready  
**Version**: 1.0  
**Last Updated**: 2024

---

## 🚀 Ready to Start?

1. Read [README.md](./README.md) untuk overview
2. Follow [SETUP-GUIDE.md](./SETUP-GUIDE.md) untuk setup
3. Check [SUMMARY.md](./SUMMARY.md) untuk quick reference
4. View [diagrams/](./diagrams/) untuk architecture understanding

**Good luck dengan setup! 🎉**
