# Step-by-Step Setup Guide - Sphereon SSI Wallet

## 📖 Panduan Lengkap Setup Development Environment

Dokumen ini berisi langkah-langkah detail untuk setup development environment dari awal sampai project berjalan.

---

## 🎯 Table of Contents

1. [Platform-Specific Setup](#platform-specific-setup)
   - [macOS Setup](#macos-setup)
   - [Windows Setup](#windows-setup)
   - [Linux Setup](#linux-setup)
2. [Project Initialization](#project-initialization)
3. [Dependencies Installation](#dependencies-installation)
4. [Configuration](#configuration)
5. [Running the App](#running-the-app)
6. [Troubleshooting](#troubleshooting)

---

## Platform-Specific Setup

### macOS Setup

#### Step 1: Install Homebrew (Package Manager)

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Verify installation
brew --version
```

#### Step 2: Install Node.js

```bash
# Install Node.js 20 LTS via Homebrew
brew install node@20

# Link Node.js 20
brew link node@20

# Verify installation
node --version    # Should show v20.x.x
npm --version     # Should show v10.x.x
```

**Alternative: Use nvm (Node Version Manager)**
```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Reload shell configuration
source ~/.zshrc  # or ~/.bashrc

# Install Node.js 20 LTS
nvm install 20
nvm use 20
nvm alias default 20

# Verify
node --version
```

#### Step 3: Install Watchman

```bash
# Install Watchman (React Native file watcher)
brew install watchman

# Verify
watchman --version
```

#### Step 4: Install Git

```bash
# Install Git
brew install git

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git --version
git config --list
```

#### Step 5: Install Xcode (for iOS Development)

```bash
# Install from Mac App Store
# 1. Open App Store
# 2. Search "Xcode"
# 3. Click Install (16+ GB download)
# 4. Wait for installation (bisa 1-2 jam)

# After Xcode installed, install Command Line Tools
sudo xcode-select --install

# Accept Xcode license
sudo xcodebuild -license accept

# Verify Xcode installation
xcodebuild -version
xcode-select --print-path

# Open Xcode once untuk complete setup
open -a Xcode
```

**Install iOS Simulators:**
1. Open Xcode
2. Go to Settings (Cmd + ,)
3. Click "Platforms" tab
4. Click "+" button
5. Download simulators yang diperlukan:
   - iOS 17.x (Latest)
   - iOS 16.x (Optional for compatibility testing)

#### Step 6: Install CocoaPods

```bash
# Install CocoaPods via Homebrew (recommended)
brew install cocoapods

# Or install via RubyGems
sudo gem install cocoapods

# Verify
pod --version

# Setup CocoaPods
pod setup
```

#### Step 7: Install Android Studio (for Android Development)

**Download & Install:**
1. Download dari: https://developer.android.com/studio
2. Download file: `android-studio-[version]-mac_arm.dmg` (Apple Silicon) atau `android-studio-[version]-mac.dmg` (Intel)
3. Open DMG file
4. Drag Android Studio ke Applications folder
5. Launch Android Studio

**First Launch Setup:**
1. Click "Standard" installation
2. Select Theme (Darcula atau Light)
3. Click "Finish" - akan download SDK components (~3 GB)

**Install Android SDK:**
1. Open Android Studio
2. Click "More Actions" → "SDK Manager"
3. Di "SDK Platforms" tab, check:
   - ☑️ Android 14.0 (UpsideDownCake) - API Level 34
   - ☑️ Android 13.0 (Tiramisu) - API Level 33
4. Di "SDK Tools" tab, check:
   - ☑️ Android SDK Build-Tools
   - ☑️ Android Emulator
   - ☑️ Android SDK Platform-Tools
   - ☑️ Intel x86 Emulator Accelerator (HAXM) - untuk Intel Mac
5. Click "Apply" → "OK"

**Setup Environment Variables:**
```bash
# Edit ~/.zshrc (or ~/.bashrc for Bash)
nano ~/.zshrc

# Add these lines:
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# Save and exit (Ctrl + X, Y, Enter)

# Reload configuration
source ~/.zshrc

# Verify
echo $ANDROID_HOME
adb --version
```

**Create Android Virtual Device (AVD):**
1. Open Android Studio
2. Click "More Actions" → "Virtual Device Manager"
3. Click "Create device"
4. Select "Pixel 7" (recommended)
5. Click "Next"
6. Select System Image: "UpsideDownCake" (API 34, Android 14)
7. Click "Download" jika belum ter-download
8. After download, click "Next"
9. Name: "Pixel_7_API_34"
10. Click "Finish"

**Test AVD:**
```bash
# List available AVDs
emulator -list-avds

# Start AVD
emulator -avd Pixel_7_API_34

# Or start from Android Studio
# Tools → Device Manager → Click Play button
```

#### Step 8: Install Java Development Kit (JDK)

```bash
# Install JDK 17 via Homebrew
brew install openjdk@17

# Link JDK
sudo ln -sfn $(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk

# Add to PATH
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
java -version
javac -version
```

#### Step 9: Install VS Code

```bash
# Install via Homebrew
brew install --cask visual-studio-code

# Or download from https://code.visualstudio.com/

# Verify
code --version

# Install code command in PATH (if not auto-installed)
# Open VS Code → Cmd+Shift+P → type "shell command" → Install 'code' command in PATH
```

**Install VS Code Extensions:**
```bash
# Essential extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension msjsdiag.vscode-react-native
code --install-extension christian-kohler.path-intellisense
code --install-extension eamodio.gitlens

# Optional but useful
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension PKief.material-icon-theme
code --install-extension zhuangtongfa.Material-theme
```

#### Step 10: Install Expo CLI & EAS CLI

```bash
# Install Expo CLI globally
npm install -g expo-cli

# Install EAS CLI (Expo Application Services)
npm install -g eas-cli

# Verify
expo --version
eas --version

# Login to Expo (jika sudah punya account)
expo login

# Or register new account
expo register
```

#### Step 11: Install Expo Go App

**On iPhone/iPad:**
1. Open App Store
2. Search "Expo Go"
3. Install app
4. Open app dan login dengan Expo account

**Verify macOS Setup:**
```bash
# Check all installations
echo "Node: $(node --version)"
echo "npm: $(npm --version)"
echo "Watchman: $(watchman --version)"
echo "Git: $(git --version)"
echo "Xcode: $(xcodebuild -version | head -1)"
echo "CocoaPods: $(pod --version)"
echo "Android Home: $ANDROID_HOME"
echo "Java: $(java -version 2>&1 | head -1)"
echo "Expo: $(expo --version)"
echo "EAS: $(eas --version)"
```

✅ **macOS Setup Complete!**

---

### Windows Setup

#### Step 1: Install Chocolatey (Package Manager) - Optional

```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Verify
choco --version
```

#### Step 2: Install Node.js

**Option A: Direct Download**
1. Go to https://nodejs.org/
2. Download "20.x LTS" Windows Installer (.msi)
3. Run installer
4. Check "Automatically install necessary tools" (akan install Python, VS Build Tools)
5. Click "Next" → "Finish"
6. Restart computer

**Option B: Via Chocolatey**
```powershell
# Run as Administrator
choco install nodejs-lts -y

# Verify
node --version
npm --version
```

#### Step 3: Install Git

```powershell
# Via Chocolatey
choco install git -y

# Or download dari https://git-scm.com/download/win
# Run installer dengan default options

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git --version
```

#### Step 4: Install Android Studio

**Download & Install:**
1. Download dari: https://developer.android.com/studio
2. Download file: `android-studio-[version]-windows.exe`
3. Run installer
4. Pilih "Standard" installation
5. Select "Android Virtual Device"
6. Click "Finish"

**Setup Android SDK:**
1. Open Android Studio
2. Click "More Actions" → "SDK Manager"
3. Di "SDK Platforms" tab, check:
   - ☑️ Android 14.0 (UpsideDownCake) - API Level 34
   - ☑️ Android 13.0 (Tiramisu) - API Level 33
4. Di "SDK Tools" tab, check:
   - ☑️ Android SDK Build-Tools
   - ☑️ Android Emulator
   - ☑️ Android SDK Platform-Tools
5. Click "Apply" → "OK"

**Setup Environment Variables:**
1. Search "Environment Variables" di Windows search
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", click "New"
   - Variable name: `ANDROID_HOME`
   - Variable value: `C:\Users\[YourUsername]\AppData\Local\Android\Sdk`
5. Select "Path" variable → Click "Edit" → Add these entries:
   ```
   %ANDROID_HOME%\platform-tools
   %ANDROID_HOME%\emulator
   %ANDROID_HOME%\tools
   %ANDROID_HOME%\tools\bin
   ```
6. Click "OK" untuk save semua
7. **Restart computer** untuk apply changes

**Verify Android Setup:**
```powershell
# Open new PowerShell window
echo $env:ANDROID_HOME
adb --version
```

**Create Android Virtual Device (AVD):**
- Follow same steps as macOS (Step 7 - Create Android Virtual Device)

#### Step 5: Install Java Development Kit (JDK)

```powershell
# Via Chocolatey
choco install openjdk17 -y

# Or download dari https://adoptium.net/
# Select: OpenJDK 17 (LTS) → Windows → x64 → .msi

# Verify
java -version
javac -version
```

#### Step 6: Install VS Code

```powershell
# Via Chocolatey
choco install vscode -y

# Or download dari https://code.visualstudio.com/

# Verify
code --version
```

**Install VS Code Extensions:**
```powershell
# Essential extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension msjsdiag.vscode-react-native
code --install-extension christian-kohler.path-intellisense

# Optional
code --install-extension dsznajder.es7-react-js-snippets
```

#### Step 7: Install Expo CLI & EAS CLI

```powershell
# Install Expo CLI
npm install -g expo-cli

# Install EAS CLI
npm install -g eas-cli

# Verify
expo --version
eas --version

# Login
expo login
```

#### Step 8: Install Expo Go App

**On Android Phone:**
1. Open Google Play Store
2. Search "Expo Go"
3. Install app
4. Open app dan login dengan Expo account

**Verify Windows Setup:**
```powershell
Write-Host "Node: $(node --version)"
Write-Host "npm: $(npm --version)"
Write-Host "Git: $(git --version)"
Write-Host "Android Home: $env:ANDROID_HOME"
Write-Host "Java: $(java -version 2>&1 | Select-Object -First 1)"
Write-Host "Expo: $(expo --version)"
Write-Host "EAS: $(eas --version)"
```

✅ **Windows Setup Complete!**

---

### Linux Setup (Ubuntu/Debian)

#### Step 1: Update System

```bash
# Update package list
sudo apt update
sudo apt upgrade -y
```

#### Step 2: Install Node.js

```bash
# Install Node.js 20 LTS via NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Verify
node --version
npm --version

# Or use nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm install 20
nvm use 20
nvm alias default 20
```

#### Step 3: Install Watchman

```bash
# Install dependencies
sudo apt install -y build-essential python3 python3-pip

# Clone Watchman
cd /tmp
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v2023.11.20.00  # Latest stable version

# Build and install
./autogen.sh
./configure
make
sudo make install

# Verify
watchman --version
```

#### Step 4: Install Git

```bash
# Install Git
sudo apt install -y git

# Configure
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git --version
```

#### Step 5: Install Android Studio

```bash
# Install required dependencies
sudo apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

# Download Android Studio
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.28/android-studio-2023.1.1.28-linux.tar.gz

# Extract
sudo tar -xzf android-studio-*-linux.tar.gz -C /opt/

# Create desktop entry
cat > ~/.local/share/applications/android-studio.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Icon=/opt/android-studio/bin/studio.png
Exec="/opt/android-studio/bin/studio.sh" %f
Comment=Android Studio IDE
Categories=Development;IDE;
Terminal=false
EOF

# Launch Android Studio
/opt/android-studio/bin/studio.sh
```

**Setup Environment Variables:**
```bash
# Edit ~/.bashrc
nano ~/.bashrc

# Add these lines at the end:
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# Save and exit (Ctrl + X, Y, Enter)

# Reload
source ~/.bashrc

# Verify
echo $ANDROID_HOME
adb --version
```

#### Step 6: Install JDK

```bash
# Install OpenJDK 17
sudo apt install -y openjdk-17-jdk

# Verify
java -version
javac -version
```

#### Step 7: Install VS Code

```bash
# Download and install
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Verify
code --version
```

**Install VS Code Extensions:**
```bash
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension msjsdiag.vscode-react-native
```

#### Step 8: Install Expo CLI & EAS CLI

```bash
# Install
sudo npm install -g expo-cli eas-cli

# Verify
expo --version
eas --version

# Login
expo login
```

✅ **Linux Setup Complete!**

---

## Project Initialization

Setelah development environment ready, sekarang kita initialize project React Native dengan Expo.

### Step 1: Create New Expo Project

```bash
# Navigate to workspace folder
cd ~/Documents/projects  # atau folder workspace Anda

# Create new Expo project dengan TypeScript template
npx create-expo-app sphereon-wallet --template expo-template-blank-typescript

# Navigate to project
cd sphereon-wallet

# Open in VS Code
code .
```

**Project akan ter-create dengan struktur:**
```
sphereon-wallet/
├── .expo/
├── assets/
├── node_modules/
├── .gitignore
├── App.tsx
├── app.json
├── babel.config.js
├── package.json
└── tsconfig.json
```

### Step 2: Verify Initial Setup

```bash
# Install dependencies (if not auto-installed)
npm install

# Start Expo dev server
npx expo start

# Or
npm start
```

**Expected output:**
```
Starting Metro Bundler
› Metro waiting on exp://192.168.x.x:8081
› Scan the QR code above with Expo Go (Android) or the Camera app (iOS)

› Press a │ open Android
› Press i │ open iOS simulator
› Press w │ open web

› Press j │ open debugger
› Press r │ reload app
› Press m │ toggle menu
› Press o │ open project code in your editor

› Press ? │ show all commands
```

### Step 3: Test on Emulator/Device

**Test on Android Emulator:**
```bash
# Make sure AVD is running
emulator -avd Pixel_7_API_34

# In another terminal, from project folder
npx expo start
# Press 'a' to open Android

# Or directly
npx expo run:android
```

**Test on iOS Simulator (macOS only):**
```bash
# From project folder
npx expo start
# Press 'i' to open iOS simulator

# Or directly
npx expo run:ios
```

**Test on Physical Device:**
1. Install Expo Go app on your phone
2. Make sure phone dan computer di network yang sama
3. Run `npx expo start`
4. Scan QR code dengan:
   - iOS: Camera app
   - Android: Expo Go app

✅ **If you see "Open up App.tsx to start working on your app!" pada device, setup successful!**

---

## Dependencies Installation

Sekarang kita install semua dependencies yang diperlukan untuk SSI Wallet.

### Step 1: Install Core Dependencies

```bash
# React Navigation
npm install @react-navigation/native @react-navigation/stack @react-navigation/bottom-tabs
npm install react-native-screens react-native-safe-area-context

# Sphereon SSI-SDK (Core packages)
npm install @sphereon/ssi-sdk-core
npm install @sphereon/ssi-sdk-oid4vci
npm install @sphereon/ssi-sdk-oid4vp
npm install @sphereon/ssi-sdk-did
npm install @sphereon/ssi-sdk-credential-store

# Expo packages
expo install expo-secure-store
expo install expo-local-authentication
expo install expo-crypto
expo install expo-camera
expo install expo-barcode-scanner

# Storage
npm install @react-native-async-storage/async-storage

# UI Components
npm install react-native-paper
npm install react-native-vector-icons

# Forms & Validation
npm install react-hook-form
npm install yup

# Utilities
npm install date-fns
npm install uuid
npm install @types/uuid -D
```

### Step 2: Install Development Dependencies

```bash
# TypeScript types
npm install -D @types/react @types/react-native

# Linting & Formatting
npm install -D eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser
npm install -D prettier eslint-config-prettier eslint-plugin-prettier

# Testing
npm install -D jest @testing-library/react-native @testing-library/jest-native
npm install -D @types/jest

# Detox (E2E testing) - Optional untuk Sprint 0
# npm install -D detox @config-plugins/detox
```

### Step 3: Verify Dependencies

```bash
# Check package.json
cat package.json

# List installed packages
npm list --depth=0
```

**Expected dependencies di package.json:**
```json
{
  "dependencies": {
    "@react-navigation/bottom-tabs": "^6.x.x",
    "@react-navigation/native": "^6.x.x",
    "@react-navigation/stack": "^6.x.x",
    "@react-native-async-storage/async-storage": "^1.x.x",
    "@sphereon/ssi-sdk-core": "^0.x.x",
    "@sphereon/ssi-sdk-oid4vci": "^0.x.x",
    "@sphereon/ssi-sdk-oid4vp": "^0.x.x",
    "@sphereon/ssi-sdk-did": "^0.x.x",
    "expo": "~50.x.x",
    "expo-camera": "~14.x.x",
    "expo-barcode-scanner": "~12.x.x",
    "expo-crypto": "~12.x.x",
    "expo-local-authentication": "~13.x.x",
    "expo-secure-store": "~12.x.x",
    "react": "18.2.0",
    "react-native": "0.73.x",
    "react-native-paper": "^5.x.x",
    "react-hook-form": "^7.x.x"
  },
  "devDependencies": {
    "@babel/core": "^7.x.x",
    "@types/react": "~18.2.x",
    "@typescript-eslint/eslint-plugin": "^6.x.x",
    "@typescript-eslint/parser": "^6.x.x",
    "eslint": "^8.x.x",
    "prettier": "^3.x.x",
    "typescript": "^5.x.x"
  }
}
```

---

## Configuration

### Step 1: Configure TypeScript

**Edit `tsconfig.json`:**
```json
{
  "extends": "expo/tsconfig.base",
  "compilerOptions": {
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@screens/*": ["src/screens/*"],
      "@services/*": ["src/services/*"],
      "@utils/*": ["src/utils/*"],
      "@types/*": ["src/types/*"],
      "@hooks/*": ["src/hooks/*"],
      "@contexts/*": ["src/contexts/*"],
      "@navigation/*": ["src/navigation/*"],
      "@config/*": ["src/config/*"]
    }
  },
  "include": ["**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
```

### Step 2: Configure ESLint

**Create `.eslintrc.js`:**
```javascript
module.exports = {
  root: true,
  extends: [
    'expo',
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['react', 'react-hooks', '@typescript-eslint'],
  rules: {
    'react/react-in-jsx-scope': 'off',
    'react/prop-types': 'off',
    '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    'no-console': ['warn', { allow: ['warn', 'error'] }],
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
};
```

### Step 3: Configure Prettier

**Create `.prettierrc`:**
```json
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "tabWidth": 2,
  "printWidth": 100,
  "arrowParens": "avoid",
  "bracketSpacing": true,
  "endOfLine": "lf"
}
```

### Step 4: Configure Expo App

**Edit `app.json`:**
```json
{
  "expo": {
    "name": "Sphereon Wallet",
    "slug": "sphereon-wallet",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "automatic",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#ffffff"
    },
    "assetBundlePatterns": ["**/*"],
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.sphereon.wallet",
      "infoPlist": {
        "NSCameraUsageDescription": "This app uses the camera to scan QR codes for credential exchange",
        "NSFaceIDUsageDescription": "This app uses Face ID for authentication"
      }
    },
    "android": {
      "package": "com.sphereon.wallet",
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#ffffff"
      },
      "permissions": [
        "CAMERA",
        "USE_BIOMETRIC",
        "USE_FINGERPRINT",
        "INTERNET"
      ]
    },
    "web": {
      "favicon": "./assets/favicon.png"
    },
    "plugins": [
      "expo-camera",
      "expo-barcode-scanner",
      [
        "expo-local-authentication",
        {
          "faceIDPermission": "Allow $(PRODUCT_NAME) to use Face ID."
        }
      ]
    ]
  }
}
```

### Step 5: Setup Project Structure

```bash
# Create src directory dan subdirectories
mkdir -p src/{components,screens,services,utils,types,hooks,contexts,navigation,config,assets}

# Create subdirectories for components
mkdir -p src/components/{common,credentials,connections,security}

# Create subdirectories for screens
mkdir -p src/screens/{auth,credentials,connections,settings,onboarding}

# Create subdirectories for services
mkdir -p src/services/{ssi,storage,network}
```

### Step 6: Create Basic Files

**Create `src/config/constants.ts`:**
```typescript
export const APP_NAME = 'Sphereon Wallet';
export const APP_VERSION = '1.0.0';

export const COLORS = {
  primary: '#6200EE',
  secondary: '#03DAC6',
  error: '#B00020',
  background: '#FFFFFF',
  surface: '#FFFFFF',
  onPrimary: '#FFFFFF',
  onSecondary: '#000000',
  onBackground: '#000000',
  onSurface: '#000000',
  onError: '#FFFFFF',
};

export const STORAGE_KEYS = {
  HAS_ONBOARDED: '@hasOnboarded',
  USER_PIN: '@userPin',
  WALLET_ID: '@walletId',
  BIOMETRIC_ENABLED: '@biometricEnabled',
};
```

**Create `src/types/navigation.types.ts`:**
```typescript
export type RootStackParamList = {
  Onboarding: undefined;
  Auth: undefined;
  Main: undefined;
};

export type AuthStackParamList = {
  Login: undefined;
  SetupPIN: undefined;
};

export type MainTabParamList = {
  Home: undefined;
  Credentials: undefined;
  Connections: undefined;
  Settings: undefined;
};
```

---

## Running the App

### Final Verification

```bash
# From project root directory

# 1. Clean install (jika ada issues)
rm -rf node_modules
npm install

# 2. Start Expo dev server
npx expo start

# 3. Test on Android emulator
# Press 'a' in terminal or
npx expo run:android

# 4. Test on iOS simulator (macOS only)
# Press 'i' in terminal or
npx expo run:ios

# 5. Test on physical device
# Scan QR code dengan Expo Go app
```

### Common Commands

```bash
# Start development server
npm start

# Start with cache clear
npm start -- --clear

# Run on Android
npm run android

# Run on iOS
npm run ios

# Run linting
npm run lint

# Format code
npm run format

# Run tests
npm test
```

---

## Troubleshooting

### Issue 1: Metro Bundler Port Already in Use

**Problem:**
```
Error: listen EADDRINUSE: address already in use :::8081
```

**Solution:**
```bash
# Kill process on port 8081
lsof -ti:8081 | xargs kill -9

# Or use different port
npx expo start --port 8082
```

### Issue 2: Android Emulator Won't Start

**Problem:**
Emulator tidak bisa start atau sangat lambat.

**Solution:**
```bash
# Check if HAXM/KVM installed (for virtualization)
# macOS: Check System Settings → Security

# Increase emulator RAM
# Android Studio → AVD Manager → Edit device → Advanced Settings → RAM: 4096 MB

# Use ARM64 image instead of x86 (for Apple Silicon Mac)
```

### Issue 3: iOS Build Fails

**Problem:**
```
error: Unable to locate CocoaPods
```

**Solution:**
```bash
# Install CocoaPods
sudo gem install cocoapods

# Install pods
cd ios
pod install
cd ..

# Clean build
rm -rf ios/build
npx expo run:ios
```

### Issue 4: Module Not Found

**Problem:**
```
Error: Unable to resolve module @react-navigation/native
```

**Solution:**
```bash
# Clear cache dan reinstall
rm -rf node_modules
rm package-lock.json
npm install

# Clear Expo cache
npx expo start --clear
```

### Issue 5: TypeScript Errors

**Problem:**
Type errors everywhere setelah install dependencies.

**Solution:**
```bash
# Install missing type definitions
npm install -D @types/react @types/react-native

# Restart TypeScript server in VS Code
# Cmd/Ctrl + Shift + P → "TypeScript: Restart TS Server"
```

### Issue 6: Expo Go App Tidak Connect

**Problem:**
Expo Go tidak bisa connect ke dev server.

**Solution:**
1. Check device dan computer di network yang sama
2. Disable firewall temporarily
3. Try tunnel mode:
   ```bash
   npx expo start --tunnel
   ```
4. Use LAN URL instead of localhost:
   ```bash
   npx expo start --lan
   ```

---

## ✅ Setup Complete Checklist

Sebelum proceed ke Sprint 1, pastikan semua ini sudah working:

- [ ] ✅ Development environment ter-install lengkap
- [ ] ✅ Android/iOS emulator bisa start
- [ ] ✅ `npx expo start` running tanpa error
- [ ] ✅ App bisa running di emulator (test press 'a' atau 'i')
- [ ] ✅ App bisa running di physical device via Expo Go
- [ ] ✅ Hot reload working (edit App.tsx dan see changes)
- [ ] ✅ TypeScript compilation working (no type errors)
- [ ] ✅ ESLint running (npm run lint)
- [ ] ✅ Project structure created
- [ ] ✅ VS Code extensions installed
- [ ] ✅ Git repository initialized
- [ ] ✅ Team members dapat run project successfully

---

**Congratulations! 🎉 Development environment ready untuk mulai Sprint 1!**

**Next Steps:**
1. Attend Sprint 1 Planning meeting
2. Read Sprint 1 user stories
3. Start implementing onboarding & security features

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Complete & Tested
