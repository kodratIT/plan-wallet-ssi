# Sprint 5: Enterprise Integrations - Complete Setup Guide

## 📋 Overview
Comprehensive implementation guide untuk Microsoft Entra VID, EBSI, dan Sphereon VDX Platform integration.

## Prerequisites
- Sprint 4 completed
- Azure AD tenant access
- EBSI pilot environment access
- VDX Platform credentials

## Step 1: Install Dependencies

### Core Libraries
```bash
# Microsoft Entra
npm install @azure/msal-node @azure/identity axios

# EBSI
npm install @sphereon/did-provider-ebsi
npm install @cef-ebsi/wallet-core @cef-ebsi/did-jwt

# Sphereon VDX
npm install @sphereon/vdx-client @sphereon/ssi-sdk-vdx

# Supporting
npm install oidc-client-ts jose zod date-fns
```

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
