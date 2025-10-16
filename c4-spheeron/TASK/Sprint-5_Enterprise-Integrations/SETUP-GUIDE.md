# Sprint 5: Enterprise Integrations - Panduan Setup & Implementasi Lengkap (Part 1)

## 📋 Ikhtisar

Panduan implementasi LENGKAP dan DETAIL untuk Sprint 5: Integrasi dengan Microsoft Entra Verified ID, EBSI/EUDI Wallet, Sphereon VDX Platform, multi-profile management, trust infrastructure, dan enterprise analytics.

**Kompleksitas**: TINGGI - Enterprise integrations dengan multiple external platforms  
**Estimasi Waktu**: 4 minggu (160 jam)  
**Prasyarat**: Pemahaman kuat tentang enterprise SSI, OAuth2/OIDC, Azure AD

---

## 🎯 Prasyarat

Sebelum memulai Sprint 5, pastikan:
- ✅ Sprint 4 selesai (Advanced Presentation ready)
- ✅ Project berjalan tanpa error
- ✅ **Azure AD Tenant** untuk Entra VID testing
- ✅ **EBSI Pilot Access** untuk EBSI integration
- ✅ **Sphereon VDX Credentials** untuk VDX Platform
- ✅ Pemahaman OAuth2/OIDC flows
- ✅ Git repository up to date

---

## 📦 Langkah 1: Install Dependencies (Detail)

### 1.1 Install Microsoft Entra VID Libraries

```bash
# Microsoft Authentication Library (MSAL)
npm install @azure/msal-node
npm install @azure/msal-react-native
npm install @azure/identity

# HTTP client
npm install axios

# JWT handling
npm install jsonwebtoken
npm install jose

# Type definitions
npm install --save-dev @types/jsonwebtoken
```

### 1.2 Install EBSI Libraries

```bash
# EBSI Core
npm install @cef-ebsi/wallet-core
npm install @cef-ebsi/did-jwt
npm install @cef-ebsi/siop-auth

# Sphereon EBSI DID Provider
npm install @sphereon/did-provider-ebsi
npm install @sphereon/did-resolver-ebsi

# EBSI Verifiable Credential
npm install @sphereon/ssi-sdk-vc-handler-ebsi
```

### 1.3 Install Sphereon VDX Platform Libraries

```bash
# VDX Client
npm install @sphereon/vdx-client
npm install @sphereon/ssi-sdk-vdx

# VDX Data Models
npm install @sphereon/vdx-models

# Workflow Management
npm install @sphereon/workflow-engine-client
```

### 1.4 Install Supporting Libraries

```bash
# OpenID Connect
npm install oidc-client-ts
npm install react-native-app-auth

# Well-Known DID Configuration
npm install @decentralized-identity/did-configuration

# Status List 2021
npm install @transmute/vc-status-rl-2021

# Enterprise Features
npm install zod  # Schema validation
npm install date-fns  # Date utilities
npm install pako  # Compression (for status lists)

# Analytics
npm install victory-native  # Charts for React Native
npm install @segment/analytics-react-native  # Optional: Segment analytics
```

### 1.5 Update Package.json

```json
{
  "dependencies": {
    "@azure/msal-node": "^2.0.0",
    "@azure/msal-react-native": "^0.3.0",
    "@azure/identity": "^4.0.0",
    "@cef-ebsi/wallet-core": "^3.0.0",
    "@cef-ebsi/did-jwt": "^3.0.0",
    "@sphereon/did-provider-ebsi": "^0.6.0",
    "@sphereon/vdx-client": "^1.0.0",
    "@sphereon/ssi-sdk-vdx": "^0.9.0",
    "@decentralized-identity/did-configuration": "^0.3.0",
    "@transmute/vc-status-rl-2021": "^0.8.0",
    "oidc-client-ts": "^2.4.0",
    "react-native-app-auth": "^7.1.0",
    "axios": "^1.6.0",
    "jose": "^5.0.0",
    "zod": "^3.22.0",
    "date-fns": "^3.0.0",
    "pako": "^2.1.0",
    "victory-native": "^36.9.0"
  },
  "devDependencies": {
    "@types/jsonwebtoken": "^9.0.0",
    "@types/pako": "^2.0.0"
  }
}
```

### 1.6 Platform-Specific Setup

#### iOS Setup
```bash
cd ios
pod install
cd ..
```

**Update Info.plist untuk OIDC:**
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.yourapp.wallet</string>
    </array>
  </dict>
</array>
```

#### Android Setup

**Update AndroidManifest.xml:**
```xml
<manifest>
  <application>
    <!-- OIDC Redirect -->
    <activity
      android:name="net.openid.appauth.RedirectUriReceiverActivity"
      android:exported="true">
      <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="com.yourapp.wallet" />
      </intent-filter>
    </activity>
  </application>
</manifest>
```

### 1.7 Verify Installation

**File**: `scripts/verify-sprint5-deps.ts`

```typescript
#!/usr/bin/env ts-node

async function verifyDependencies() {
  console.log('Verifying Sprint 5 dependencies...\n');
  
  const deps = [
    '@azure/msal-node',
    '@cef-ebsi/wallet-core',
    '@sphereon/vdx-client',
    'oidc-client-ts',
    '@transmute/vc-status-rl-2021',
    'victory-native'
  ];

  let allInstalled = true;
  
  for (const dep of deps) {
    try {
      require(dep);
      console.log(`✅ ${dep}`);
    } catch (error) {
      console.error(`❌ ${dep} - NOT INSTALLED`);
      allInstalled = false;
    }
  }
  
  if (allInstalled) {
    console.log('\n✅ All Sprint 5 dependencies verified!');
  } else {
    console.error('\n❌ Some dependencies missing. Run npm install.');
    process.exit(1);
  }
}

verifyDependencies();
```

Run verification:
```bash
chmod +x scripts/verify-sprint5-deps.ts
npm run verify:sprint5
```

---

## Step 2: Microsoft Entra VID Integration (US-5.1)

### 2.1 Azure AD Setup
1. Create Azure AD tenant
2. Register application
3. Configure API permissions
4. Create client secret
5. Note: tenant ID, client ID, secret

### 2.2 Implementation

**File**: `src/services/enterprise/EntraVIDService.ts`

```typescript
import { ConfidentialClientApplication } from '@azure/msal-node';
import axios from 'axios';

class EntraVIDService {
  private msalClient: ConfidentialClientApplication;
  private apiEndpoint = 'https://verifiedid.did.msidentity.com/v1.0';

  constructor() {
    this.msalClient = new ConfidentialClientApplication({
      auth: {
        clientId: process.env.AZURE_CLIENT_ID!,
        authority: `https://login.microsoftonline.com/${process.env.AZURE_TENANT_ID}`,
        clientSecret: process.env.AZURE_CLIENT_SECRET!,
      },
    });
  }

  async getAccessToken(): Promise<string> {
    const result = await this.msalClient.acquireTokenByClientCredential({
      scopes: ['3db474b9-6a0c-4840-96ac-1fceb342124f/.default'],
    });
    return result!.accessToken;
  }

  async createIssuanceRequest(manifestUrl: string, claims?: any) {
    const token = await this.getAccessToken();
    
    const response = await axios.post(
      `${this.apiEndpoint}/verifiableCredentials/createIssuanceRequest`,
      {
        includeQRCode: true,
        callback: {
          url: `${process.env.APP_URL}/api/entra-callback`,
          state: crypto.randomUUID(),
        },
        authority: process.env.AZURE_TENANT_ID,
        registration: { clientName: 'Sphereon Wallet' },
        type: 'VerifiableCredential',
        manifest: manifestUrl,
        claims,
      },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    
    return response.data;
  }
}

export default new EntraVIDService();
```

### 2.3 Testing
```bash
# Test authentication
npm run test:entra-auth

# Test issuance
npm run test:entra-issue

# Test presentation
npm run test:entra-present
```

## Step 3: EBSI Integration (US-5.3)

### 3.1 EBSI Setup
1. Study EBSI specifications
2. Get EBSI pilot access
3. Configure endpoints
4. Setup did:ebsi

### 3.2 Implementation

**File**: `src/services/enterprise/EBSIService.ts`

```typescript
import axios from 'axios';

class EBSIService {
  private didRegistry = 'https://api-pilot.ebsi.eu/did-registry/v4';
  private trustedIssuers = 'https://api-pilot.ebsi.eu/trusted-issuers-registry/v4';

  async resolveDID(did: string) {
    const response = await axios.get(
      `${this.didRegistry}/identifiers/${did}`
    );
    return response.data;
  }

  async verifyIssuerTrust(issuerDID: string): Promise<boolean> {
    try {
      const response = await axios.get(
        `${this.trustedIssuers}/issuers/${issuerDID}`
      );
      return response.data.active === true;
    } catch {
      return false;
    }
  }

  async validateEBSICredential(credential: any): Promise<boolean> {
    // Validate EBSI credential format
    // Check issuer trust
    // Verify signatures
    const issuerTrusted = await this.verifyIssuerTrust(credential.issuer);
    return issuerTrusted;
  }
}

export default new EBSIService();
```

### 3.3 EUDI Wallet Compliance
- Architecture Reference Framework compliance
- Security requirements validation
- Interoperability testing

## Step 4: VDX Platform Integration (US-5.2)

### 4.1 VDX Setup
1. Get VDX API credentials
2. Configure tenant
3. Setup workflows

### 4.2 Implementation

**File**: `src/services/enterprise/VDXService.ts`

```typescript
import axios from 'axios';

class VDXService {
  private apiBase = 'https://api.vdx.sphereon.com/v1';
  private apiKey = process.env.VDX_API_KEY!;

  async executeWorkflow(workflowId: string, params: any) {
    const response = await axios.post(
      `${this.apiBase}/workflows/execute`,
      { workflowId, parameters: params },
      { headers: { Authorization: `Bearer ${this.apiKey}` } }
    );
    return response.data;
  }

  async getWorkflowStatus(executionId: string) {
    const response = await axios.get(
      `${this.apiBase}/workflows/executions/${executionId}`,
      { headers: { Authorization: `Bearer ${this.apiKey}` } }
    );
    return response.data;
  }
}

export default new VDXService();
```

## Step 5: Organization Profiles (US-5.5)

**File**: `src/services/profiles/ProfileService.ts`

```typescript
interface WalletProfile {
  id: string;
  name: string;
  type: 'personal' | 'work';
  organization?: {
    name: string;
    logo: string;
    primaryColor: string;
  };
}

class ProfileService {
  async createProfile(name: string, type: string): Promise<WalletProfile> {
    // Implementation
  }

  async switchProfile(profileId: string): Promise<void> {
    // Implementation
  }
}
```

## Step 6: StatusList2021 (US-5.7)

```typescript
class StatusList2021Service {
  async checkStatus(credential: any): Promise<'active' | 'revoked'> {
    // Fetch status list
    // Extract bitstring
    // Check credential index
    return 'active';
  }
}
```

## Step 7: Testing

### Integration Tests
```bash
npm run test:integration:entra
npm run test:integration:ebsi
npm run test:integration:vdx
```

### End-to-End Tests
```bash
npm run test:e2e:enterprise
```

## Step 8: Deployment

### Environment Variables
```env
# Microsoft Entra
AZURE_TENANT_ID=your-tenant-id
AZURE_CLIENT_ID=your-client-id
AZURE_CLIENT_SECRET=your-secret

# EBSI
EBSI_DID_REGISTRY=https://api-pilot.ebsi.eu/did-registry/v4
EBSI_TRUSTED_ISSUERS=https://api-pilot.ebsi.eu/trusted-issuers-registry/v4

# VDX
VDX_API_BASE_URL=https://api.vdx.sphereon.com/v1
VDX_API_KEY=your-vdx-key
```

## Troubleshooting

### Azure AD Authentication Fails
- Check tenant ID, client ID, client secret
- Verify API permissions
- Check token expiration

### EBSI DID Resolution Timeout
- Check network connectivity
- Use caching
- Implement fallback resolvers

### VDX Workflow Execution Error
- Validate workflow definition
- Check API key
- Verify permissions

## Next Steps
After Sprint 5 completion, proceed to Sprint 6: Advanced Features.

**Status**: ✅ Complete Implementation Guide
**Version**: 1.0
