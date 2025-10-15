# Sprint 2: Credential Management - Setup & Implementation Guide

## 📋 Overview

Panduan ini memberikan step-by-step instructions untuk mengimplementasikan enhanced credential management di Sprint 2: Credential Manifest, OCA rendering, search, organization, dan export/share features.

---

## 🎯 Prerequisites

Sebelum mulai Sprint 2, pastikan:
- ✅ Sprint 1 selesai (security features ready)
- ✅ Project running tanpa error
- ✅ Git repository up to date
- ✅ Team members assigned ke user stories
- ✅ Demo issuers available untuk testing

---

## 📦 Step 1: Install Credential Dependencies

### 1.1 Install Sphereon SSI Libraries

```bash
# Core SSI SDK
npm install @sphereon/ssi-sdk-core
npm install @sphereon/ssi-sdk-credential
npm install @sphereon/ssi-types

# OpenID for Verifiable Credentials
npm install @sphereon/oid4vci-client
npm install @sphereon/oid4vci-common

# Presentation Exchange
npm install @sphereon/presentation-exchange
npm install @sphereon/pex
npm install @sphereon/pex-models

# OCA Support
npm install @sphereon/oca  # If available
# Or implement custom OCA renderer
```

### 1.2 Install UI & Search Libraries

```bash
# UI Components
npm install react-native-paper
npm install react-native-reanimated
npm install react-native-svg
npm install react-native-svg-charts

# Search & Filter
npm install fuse.js
npm install lodash

# Date handling
npm install date-fns
```

### 1.3 Install Export & Share Libraries

```bash
# File system
npm install react-native-fs

# QR Code generation
npm install react-native-qrcode-svg

# PDF generation
npm install react-native-pdf
npm install @react-pdf/renderer  # Alternative for PDF generation

# Share functionality
npm install react-native-share

# Clipboard
npm install @react-native-clipboard/clipboard
```

### 1.4 Verify Installation

```bash
# Start the app
npx expo start

# Test imports in a test file
```

```typescript
// test-credential-imports.ts
import { CredentialMapper } from '@sphereon/ssi-sdk-credential';
import { OID4VCIClient } from '@sphereon/oid4vci-client';
import { PresentationExchange } from '@sphereon/pex';
import Fuse from 'fuse.js';
import Share from 'react-native-share';
import QRCode from 'react-native-qrcode-svg';

console.log('All credential libraries imported successfully!');
```

---

## 🔐 Step 2: Implement Credential Manifest Service (US-2.1)

### 2.1 Create Credential Service Structure

```bash
mkdir -p src/services/credential
mkdir -p src/types/credential
mkdir -p src/utils/credential
```

### 2.2 Create Credential Manifest Service

**File**: `src/services/credential/CredentialManifestService.ts`

```typescript
import { 
  CredentialManifest, 
  OutputDescriptor,
  PresentationDefinition 
} from '@sphereon/ssi-types';

interface ManifestResponse {
  manifest: CredentialManifest;
  outputDescriptors: OutputDescriptor[];
  presentationDefinition?: PresentationDefinition;
}

class CredentialManifestService {
  private manifestCache: Map<string, CredentialManifest> = new Map();

  /**
   * Fetch credential manifest dari issuer
   */
  async fetchManifest(issuerURL: string, manifestId?: string): Promise<CredentialManifest> {
    try {
      // Check cache first
      const cacheKey = `${issuerURL}:${manifestId || 'default'}`;
      if (this.manifestCache.has(cacheKey)) {
        return this.manifestCache.get(cacheKey)!;
      }

      // Fetch from issuer
      const manifestEndpoint = manifestId 
        ? `${issuerURL}/credential-manifest/${manifestId}`
        : `${issuerURL}/.well-known/credential-manifest`;

      const response = await fetch(manifestEndpoint);
      
      if (!response.ok) {
        throw new Error(`Failed to fetch manifest: ${response.statusText}`);
      }

      const manifest: CredentialManifest = await response.json();

      // Validate manifest
      this.validateManifest(manifest);

      // Cache manifest
      this.manifestCache.set(cacheKey, manifest);

      return manifest;
    } catch (error) {
      console.error('Error fetching credential manifest:', error);
      throw error;
    }
  }

  /**
   * Validate credential manifest structure
   */
  private validateManifest(manifest: any): void {
    if (!manifest.credential_manifest) {
      throw new Error('Invalid manifest: missing credential_manifest');
    }

    if (!manifest.credential_manifest.id) {
      throw new Error('Invalid manifest: missing id');
    }

    if (!manifest.credential_manifest.output_descriptors || 
        !Array.isArray(manifest.credential_manifest.output_descriptors)) {
      throw new Error('Invalid manifest: missing or invalid output_descriptors');
    }
  }

  /**
   * Parse output descriptors
   */
  parseOutputDescriptors(manifest: CredentialManifest): OutputDescriptor[] {
    return manifest.credential_manifest.output_descriptors.map(descriptor => ({
      id: descriptor.id,
      schema: descriptor.schema,
      display: descriptor.display,
      styles: descriptor.styles
    }));
  }

  /**
   * Get presentation requirements
   */
  getPresentationDefinition(manifest: CredentialManifest): PresentationDefinition | undefined {
    return manifest.credential_manifest.presentation_definition;
  }

  /**
   * Create credential application
   */
  async createApplication(
    manifest: CredentialManifest,
    presentationSubmission?: any
  ): Promise<any> {
    const application = {
      credential_application: {
        id: this.generateApplicationId(),
        manifest_id: manifest.credential_manifest.id,
        format: 'jwt_vc_json',
        presentation_submission: presentationSubmission
      }
    };

    return application;
  }

  /**
   * Handle credential response
   */
  async handleCredentialResponse(
    response: any,
    manifest: CredentialManifest
  ): Promise<any> {
    try {
      // Parse credential dari response
      const credential = this.parseCredential(response);

      // Validate credential
      await this.validateCredential(credential);

      // Match dengan output descriptor
      const descriptor = this.matchOutputDescriptor(credential, manifest);

      // Return credential dengan metadata
      return {
        credential,
        manifestId: manifest.credential_manifest.id,
        descriptorId: descriptor?.id,
        display: descriptor?.display,
        issuer: manifest.credential_manifest.issuer
      };
    } catch (error) {
      console.error('Error handling credential response:', error);
      throw error;
    }
  }

  /**
   * Parse credential dari berbagai format
   */
  private parseCredential(response: any): any {
    if (response.format === 'jwt_vc_json') {
      // Parse JWT VC
      return this.parseJWTVC(response.credential);
    } else if (response.format === 'ldp_vc') {
      // Parse JSON-LD VC
      return response.credential;
    }
    
    throw new Error(`Unsupported credential format: ${response.format}`);
  }

  /**
   * Parse JWT VC
   */
  private parseJWTVC(jwt: string): any {
    // Decode JWT (simple base64 decode untuk demo)
    const parts = jwt.split('.');
    if (parts.length !== 3) {
      throw new Error('Invalid JWT format');
    }

    const payload = JSON.parse(
      Buffer.from(parts[1], 'base64').toString('utf-8')
    );

    return payload.vc;
  }

  /**
   * Validate credential
   */
  private async validateCredential(credential: any): Promise<void> {
    // Basic validation
    if (!credential['@context']) {
      throw new Error('Credential missing @context');
    }

    if (!credential.type || !Array.isArray(credential.type)) {
      throw new Error('Credential missing or invalid type');
    }

    if (!credential.issuer) {
      throw new Error('Credential missing issuer');
    }

    if (!credential.credentialSubject) {
      throw new Error('Credential missing credentialSubject');
    }

    // TODO: Add signature verification
    // TODO: Add DID resolution and verification
  }

  /**
   * Match credential dengan output descriptor
   */
  private matchOutputDescriptor(
    credential: any,
    manifest: CredentialManifest
  ): OutputDescriptor | undefined {
    const credentialTypes = credential.type;
    
    return manifest.credential_manifest.output_descriptors.find(descriptor => {
      // Match by schema/type
      return credentialTypes.includes(descriptor.schema);
    });
  }

  /**
   * Generate unique application ID
   */
  private generateApplicationId(): string {
    return `app-${Date.now()}-${Math.random().toString(36).substring(7)}`;
  }

  /**
   * Clear manifest cache
   */
  clearCache(): void {
    this.manifestCache.clear();
  }
}

export default new CredentialManifestService();
```

### 2.3 Test Credential Manifest Service

**File**: `src/services/credential/__tests__/CredentialManifestService.test.ts`

```typescript
import CredentialManifestService from '../CredentialManifestService';

describe('CredentialManifestService', () => {
  const mockManifest = {
    credential_manifest: {
      id: 'university-degree',
      issuer: {
        id: 'did:web:university.edu',
        name: 'University of Example'
      },
      output_descriptors: [
        {
          id: 'degree-output',
          schema: 'UniversityDegreeCredential',
          display: {
            title: { text: 'University Degree' }
          }
        }
      ]
    }
  };

  it('should parse output descriptors', () => {
    const descriptors = CredentialManifestService.parseOutputDescriptors(mockManifest);
    expect(descriptors).toHaveLength(1);
    expect(descriptors[0].id).toBe('degree-output');
  });

  it('should create credential application', async () => {
    const application = await CredentialManifestService.createApplication(mockManifest);
    expect(application.credential_application.manifest_id).toBe('university-degree');
  });
});
```

---

## 🎨 Step 3: Implement OCA Rendering Service (US-2.2)

### 3.1 Create OCA Service

**File**: `src/services/credential/OCAService.ts`

```typescript
interface OCABundle {
  capture_base: {
    type: string;
    classification: string;
    attributes: Record<string, string>;
  };
  overlays: {
    character_encoding?: any;
    format?: any;
    label?: any;
    information?: any;
    branding?: {
      logo?: string;
      background_image?: string;
      background_color?: string;
      primary_color?: string;
      secondary_color?: string;
    };
  };
}

interface RenderedCredential {
  credential: any;
  style: {
    background: string;
    primaryColor: string;
    secondaryColor?: string;
    logo?: string;
  };
  attributes: Array<{
    key: string;
    label: string;
    value: any;
    format?: string;
    info?: string;
  }>;
  layout: string;
}

class OCAService {
  private bundleCache: Map<string, OCABundle> = new Map();
  private readonly DEFAULT_REGISTRY_URL = 'https://oca.example.com';

  /**
   * Fetch OCA bundle untuk credential type
   */
  async fetchBundle(credentialType: string, issuerDID?: string): Promise<OCABundle> {
    try {
      // Check cache
      const cacheKey = `${credentialType}:${issuerDID || 'default'}`;
      if (this.bundleCache.has(cacheKey)) {
        return this.bundleCache.get(cacheKey)!;
      }

      // Fetch dari registry
      const registryURL = issuerDID 
        ? `${issuerDID}/.well-known/oca/${credentialType}`
        : `${this.DEFAULT_REGISTRY_URL}/oca/${credentialType}`;

      const response = await fetch(registryURL);

      if (!response.ok) {
        console.warn(`OCA bundle not found for ${credentialType}, using default`);
        return this.createDefaultBundle(credentialType);
      }

      const bundle: OCABundle = await response.json();

      // Cache bundle
      this.bundleCache.set(cacheKey, bundle);

      return bundle;
    } catch (error) {
      console.error('Error fetching OCA bundle:', error);
      return this.createDefaultBundle(credentialType);
    }
  }

  /**
   * Render credential dengan OCA styling
   */
  async render(credential: any, language: string = 'en'): Promise<RenderedCredential> {
    try {
      // Get credential type
      const credentialType = this.getCredentialType(credential);
      
      // Fetch OCA bundle
      const bundle = await this.fetchBundle(credentialType, credential.issuer);

      // Apply overlays
      const style = this.applyBrandingOverlay(bundle);
      const attributes = this.applyAllOverlays(credential, bundle, language);
      const layout = this.determineLayout(bundle);

      return {
        credential,
        style,
        attributes,
        layout
      };
    } catch (error) {
      console.error('Error rendering credential with OCA:', error);
      return this.renderDefault(credential);
    }
  }

  /**
   * Apply branding overlay
   */
  private applyBrandingOverlay(bundle: OCABundle): any {
    const branding = bundle.overlays.branding || {};

    return {
      background: branding.background_color || '#FFFFFF',
      primaryColor: branding.primary_color || '#000000',
      secondaryColor: branding.secondary_color,
      logo: branding.logo
    };
  }

  /**
   * Apply all overlays to attributes
   */
  private applyAllOverlays(
    credential: any,
    bundle: OCABundle,
    language: string
  ): any[] {
    const credentialSubject = credential.credentialSubject;
    const attributes: any[] = [];

    // Get overlays
    const labels = this.getLabels(bundle, language);
    const formats = this.getFormats(bundle);
    const information = this.getInformation(bundle);

    // Process each attribute
    for (const [key, value] of Object.entries(credentialSubject)) {
      if (key === 'id') continue; // Skip subject ID

      attributes.push({
        key,
        label: labels[key] || this.formatKey(key),
        value: this.formatValue(value, formats[key]),
        format: formats[key],
        info: information[key]
      });
    }

    return attributes;
  }

  /**
   * Get labels dari label overlay
   */
  private getLabels(bundle: OCABundle, language: string): Record<string, string> {
    const labelOverlay = bundle.overlays.label;
    if (!labelOverlay) return {};

    // Support multilingual labels
    return labelOverlay.attribute_labels || {};
  }

  /**
   * Get formats dari format overlay
   */
  private getFormats(bundle: OCABundle): Record<string, string> {
    const formatOverlay = bundle.overlays.format;
    if (!formatOverlay) return {};

    return formatOverlay.attribute_formats || {};
  }

  /**
   * Get information dari information overlay
   */
  private getInformation(bundle: OCABundle): Record<string, string> {
    const infoOverlay = bundle.overlays.information;
    if (!infoOverlay) return {};

    return infoOverlay.attribute_information || {};
  }

  /**
   * Format value berdasarkan format pattern
   */
  private formatValue(value: any, format?: string): any {
    if (!format) return value;

    // Date formatting
    if (format.includes('YYYY') || format.includes('MM') || format.includes('DD')) {
      return this.formatDate(value, format);
    }

    // Number formatting
    if (format.includes('0,0')) {
      return this.formatNumber(value, format);
    }

    return value;
  }

  /**
   * Format date
   */
  private formatDate(value: string, format: string): string {
    // Use date-fns atau similar library
    // For demo, just return as is
    return new Date(value).toLocaleDateString();
  }

  /**
   * Format number
   */
  private formatNumber(value: number, format: string): string {
    // Implement number formatting
    return value.toLocaleString();
  }

  /**
   * Format key untuk display (camelCase -> Proper Case)
   */
  private formatKey(key: string): string {
    return key
      .replace(/([A-Z])/g, ' $1')
      .replace(/^./, str => str.toUpperCase())
      .trim();
  }

  /**
   * Determine layout dari bundle
   */
  private determineLayout(bundle: OCABundle): string {
    // Could be specified in bundle metadata
    return 'professional_card';
  }

  /**
   * Get credential type dari credential
   */
  private getCredentialType(credential: any): string {
    const types = credential.type;
    // Return most specific type (last in array, excluding VerifiableCredential)
    return types.filter((t: string) => t !== 'VerifiableCredential').pop() || 'VerifiableCredential';
  }

  /**
   * Create default OCA bundle
   */
  private createDefaultBundle(credentialType: string): OCABundle {
    return {
      capture_base: {
        type: 'spec/capture_base/1.0',
        classification: credentialType,
        attributes: {}
      },
      overlays: {
        branding: {
          background_color: '#F5F5F5',
          primary_color: '#333333'
        }
      }
    };
  }

  /**
   * Render credential dengan default styling
   */
  private renderDefault(credential: any): RenderedCredential {
    const attributes = Object.entries(credential.credentialSubject)
      .filter(([key]) => key !== 'id')
      .map(([key, value]) => ({
        key,
        label: this.formatKey(key),
        value
      }));

    return {
      credential,
      style: {
        background: '#FFFFFF',
        primaryColor: '#000000'
      },
      attributes,
      layout: 'simple_card'
    };
  }

  /**
   * Clear bundle cache
   */
  clearCache(): void {
    this.bundleCache.clear();
  }
}

export default new OCAService();
```

---

## 🎴 Step 4: Implement Credential Card Component (US-2.3)

### 4.1 Create Credential Card Component

**File**: `src/components/credential/CredentialCard.tsx`

```typescript
import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Image,
  Pressable
} from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  interpolate
} from 'react-native-reanimated';
import { LinearGradient } from 'expo-linear-gradient';

interface CredentialCardProps {
  credential: any;
  renderedCredential?: any;  // From OCA rendering
  onPress?: () => void;
  onLongPress?: () => void;
  style?: 'card' | 'compact' | 'list';
}

export const CredentialCard: React.FC<CredentialCardProps> = ({
  credential,
  renderedCredential,
  onPress,
  onLongPress,
  style = 'card'
}) => {
  const [isFlipped, setIsFlipped] = useState(false);
  const rotation = useSharedValue(0);

  // Card flip animation
  const flipCard = () => {
    rotation.value = withTiming(isFlipped ? 0 : 180, { duration: 600 });
    setIsFlipped(!isFlipped);
  };

  const frontAnimatedStyle = useAnimatedStyle(() => {
    const rotateValue = interpolate(
      rotation.value,
      [0, 180],
      [0, 180]
    );

    return {
      transform: [
        { perspective: 1000 },
        { rotateY: `${rotateValue}deg` }
      ],
      opacity: interpolate(
        rotation.value,
        [0, 90, 90, 180],
        [1, 0, 0, 1]
      )
    };
  });

  const backAnimatedStyle = useAnimatedStyle(() => {
    const rotateValue = interpolate(
      rotation.value,
      [0, 180],
      [180, 360]
    );

    return {
      transform: [
        { perspective: 1000 },
        { rotateY: `${rotateValue}deg` }
      ],
      opacity: interpolate(
        rotation.value,
        [0, 90, 90, 180],
        [0, 0, 1, 1]
      )
    };
  });

  // Get styling dari OCA rendering
  const styling = renderedCredential?.style || {
    background: '#FFFFFF',
    primaryColor: '#000000'
  };

  const attributes = renderedCredential?.attributes || [];

  // Render based on style prop
  if (style === 'list') {
    return renderListStyle();
  }

  if (style === 'compact') {
    return renderCompactStyle();
  }

  // Default: card style
  return (
    <Pressable
      onPress={onPress}
      onLongPress={onLongPress}
      style={styles.cardContainer}
    >
      <View style={styles.card}>
        {/* Front of card */}
        <Animated.View style={[styles.cardFace, frontAnimatedStyle]}>
          <LinearGradient
            colors={[styling.background, shadeColor(styling.background, -20)]}
            style={styles.gradient}
          >
            {/* Logo */}
            {styling.logo && (
              <Image source={{ uri: styling.logo }} style={styles.logo} />
            )}

            {/* Credential Type */}
            <Text style={[styles.type, { color: styling.primaryColor }]}>
              {getCredentialType(credential)}
            </Text>

            {/* Issuer Name */}
            <Text style={[styles.issuer, { color: styling.primaryColor }]}>
              {getIssuerName(credential)}
            </Text>

            {/* Key attributes */}
            <View style={styles.attributesContainer}>
              {attributes.slice(0, 3).map((attr: any, index: number) => (
                <View key={index} style={styles.attribute}>
                  <Text style={[styles.attributeLabel, { color: styling.primaryColor + 'AA' }]}>
                    {attr.label}
                  </Text>
                  <Text style={[styles.attributeValue, { color: styling.primaryColor }]} numberOfLines={1}>
                    {attr.value}
                  </Text>
                </View>
              ))}
            </View>

            {/* Status badge */}
            <View style={styles.statusBadge}>
              <Text style={styles.statusText}>
                {getCredentialStatus(credential)}
              </Text>
            </View>

            {/* Flip button */}
            <TouchableOpacity onPress={flipCard} style={styles.flipButton}>
              <Text style={styles.flipIcon}>🔄</Text>
            </TouchableOpacity>
          </LinearGradient>
        </Animated.View>

        {/* Back of card */}
        <Animated.View style={[styles.cardFace, styles.cardBack, backAnimatedStyle]}>
          <LinearGradient
            colors={[styling.background, shadeColor(styling.background, -20)]}
            style={styles.gradient}
          >
            <Text style={[styles.backTitle, { color: styling.primaryColor }]}>
              Credential Details
            </Text>

            {/* All attributes */}
            <View style={styles.backAttributes}>
              {attributes.map((attr: any, index: number) => (
                <View key={index} style={styles.backAttribute}>
                  <Text style={[styles.backLabel, { color: styling.primaryColor + 'AA' }]}>
                    {attr.label}:
                  </Text>
                  <Text style={[styles.backValue, { color: styling.primaryColor }]}>
                    {attr.value}
                  </Text>
                </View>
              ))}
            </View>

            {/* Flip button */}
            <TouchableOpacity onPress={flipCard} style={styles.flipButton}>
              <Text style={styles.flipIcon}>🔄</Text>
            </TouchableOpacity>
          </LinearGradient>
        </Animated.View>
      </View>
    </Pressable>
  );

  // Helper render functions
  function renderListStyle() {
    return (
      <TouchableOpacity
        onPress={onPress}
        onLongPress={onLongPress}
        style={styles.listContainer}
      >
        <View style={styles.listContent}>
          <Text style={styles.listType}>{getCredentialType(credential)}</Text>
          <Text style={styles.listIssuer}>{getIssuerName(credential)}</Text>
        </View>
        <View style={styles.listBadge}>
          <Text style={styles.listBadgeText}>{getCredentialStatus(credential)}</Text>
        </View>
      </TouchableOpacity>
    );
  }

  function renderCompactStyle() {
    return (
      <TouchableOpacity
        onPress={onPress}
        onLongPress={onLongPress}
        style={styles.compactContainer}
      >
        <Text style={styles.compactType}>{getCredentialType(credential)}</Text>
        <Text style={styles.compactIssuer}>{getIssuerName(credential)}</Text>
      </TouchableOpacity>
    );
  }
};

// Helper functions
function getCredentialType(credential: any): string {
  const types = credential.type || [];
  return types.filter((t: string) => t !== 'VerifiableCredential')[0] || 'Credential';
}

function getIssuerName(credential: any): string {
  if (typeof credential.issuer === 'string') {
    return credential.issuer;
  }
  return credential.issuer?.name || credential.issuer?.id || 'Unknown Issuer';
}

function getCredentialStatus(credential: any): string {
  // Check expiration
  if (credential.expirationDate) {
    const expiry = new Date(credential.expirationDate);
    if (expiry < new Date()) {
      return '⏰ Expired';
    }
  }

  // Check revocation (would need actual check)
  // For now, assume active
  return '✅ Active';
}

function shadeColor(color: string, percent: number): string {
  // Simple color shading function
  // Implement proper color manipulation
  return color;
}

const styles = StyleSheet.create({
  cardContainer: {
    marginVertical: 10,
    marginHorizontal: 16,
  },
  card: {
    width: '100%',
    height: 200,
    borderRadius: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
  cardFace: {
    position: 'absolute',
    width: '100%',
    height: '100%',
    borderRadius: 16,
    backfaceVisibility: 'hidden',
  },
  cardBack: {
    // Styling for back face
  },
  gradient: {
    flex: 1,
    borderRadius: 16,
    padding: 20,
  },
  logo: {
    width: 50,
    height: 50,
    position: 'absolute',
    top: 16,
    right: 16,
    borderRadius: 8,
  },
  type: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  issuer: {
    fontSize: 14,
    opacity: 0.8,
    marginBottom: 16,
  },
  attributesContainer: {
    flex: 1,
  },
  attribute: {
    marginBottom: 8,
  },
  attributeLabel: {
    fontSize: 12,
    opacity: 0.7,
  },
  attributeValue: {
    fontSize: 16,
    fontWeight: '600',
  },
  statusBadge: {
    position: 'absolute',
    bottom: 16,
    left: 16,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
  },
  statusText: {
    fontSize: 12,
    color: '#FFFFFF',
  },
  flipButton: {
    position: 'absolute',
    bottom: 16,
    right: 16,
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  flipIcon: {
    fontSize: 20,
  },
  // Back face styles
  backTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  backAttributes: {
    flex: 1,
  },
  backAttribute: {
    marginBottom: 12,
  },
  backLabel: {
    fontSize: 12,
    opacity: 0.7,
    marginBottom: 4,
  },
  backValue: {
    fontSize: 14,
  },
  // List style
  listContainer: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  listContent: {
    flex: 1,
  },
  listType: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  listIssuer: {
    fontSize: 14,
    color: '#666',
  },
  listBadge: {
    justifyContent: 'center',
  },
  listBadgeText: {
    fontSize: 12,
  },
  // Compact style
  compactContainer: {
    padding: 12,
    backgroundColor: '#F5F5F5',
    borderRadius: 8,
    marginVertical: 4,
  },
  compactType: {
    fontSize: 14,
    fontWeight: '600',
  },
  compactIssuer: {
    fontSize: 12,
    color: '#666',
    marginTop: 2,
  },
});
```

---

## 🔍 Step 5: Implement Search Service (US-2.6)

### 5.1 Create Search Service

**File**: `src/services/credential/SearchService.ts`

```typescript
import Fuse from 'fuse.js';

interface SearchOptions {
  query?: string;
  filters?: {
    type?: string[];
    issuer?: string[];
    status?: string[];
    dateRange?: {
      from?: Date;
      to?: Date;
    };
  };
  sortBy?: 'date' | 'name' | 'issuer';
  sortOrder?: 'asc' | 'desc';
}

class CredentialSearchService {
  private fuse: Fuse<any> | null = null;
  private searchHistory: string[] = [];
  private readonly MAX_HISTORY = 10;

  /**
   * Initialize search index
   */
  initializeIndex(credentials: any[]): void {
    const options = {
      keys: [
        { name: 'type', weight: 0.3 },
        { name: 'credentialSubject.name', weight: 0.25 },
        { name: 'credentialSubject.title', weight: 0.2 },
        { name: 'credentialSubject.description', weight: 0.15 },
        { name: 'issuer.name', weight: 0.1 }
      ],
      threshold: 0.3,
      includeScore: true,
      useExtendedSearch: true
    };

    this.fuse = new Fuse(credentials, options);
  }

  /**
   * Search credentials
   */
  search(credentials: any[], options: SearchOptions): any[] {
    let results = [...credentials];

    // Apply text search
    if (options.query && this.fuse) {
      const searchResults = this.fuse.search(options.query);
      results = searchResults.map(result => result.item);

      // Add to search history
      this.addToHistory(options.query);
    }

    // Apply filters
    if (options.filters) {
      results = this.applyFilters(results, options.filters);
    }

    // Apply sorting
    if (options.sortBy) {
      results = this.sortResults(results, options.sortBy, options.sortOrder);
    }

    return results;
  }

  /**
   * Apply filters
   */
  private applyFilters(credentials: any[], filters: any): any[] {
    let filtered = credentials;

    // Filter by type
    if (filters.type && filters.type.length > 0) {
      filtered = filtered.filter(cred =>
        filters.type.some((type: string) => cred.type.includes(type))
      );
    }

    // Filter by issuer
    if (filters.issuer && filters.issuer.length > 0) {
      filtered = filtered.filter(cred => {
        const issuerName = typeof cred.issuer === 'string' 
          ? cred.issuer 
          : cred.issuer.name || cred.issuer.id;
        return filters.issuer.includes(issuerName);
      });
    }

    // Filter by status
    if (filters.status && filters.status.length > 0) {
      filtered = filtered.filter(cred => {
        const status = this.getCredentialStatus(cred);
        return filters.status.includes(status);
      });
    }

    // Filter by date range
    if (filters.dateRange) {
      filtered = filtered.filter(cred => {
        const issueDate = new Date(cred.issuanceDate);
        
        if (filters.dateRange.from && issueDate < filters.dateRange.from) {
          return false;
        }
        
        if (filters.dateRange.to && issueDate > filters.dateRange.to) {
          return false;
        }
        
        return true;
      });
    }

    return filtered;
  }

  /**
   * Sort results
   */
  private sortResults(credentials: any[], sortBy: string, order: string = 'desc'): any[] {
    return credentials.sort((a, b) => {
      let comparison = 0;

      switch (sortBy) {
        case 'date':
          comparison = new Date(a.issuanceDate).getTime() - new Date(b.issuanceDate).getTime();
          break;
        case 'name':
          const nameA = this.getCredentialName(a);
          const nameB = this.getCredentialName(b);
          comparison = nameA.localeCompare(nameB);
          break;
        case 'issuer':
          const issuerA = this.getIssuerName(a);
          const issuerB = this.getIssuerName(b);
          comparison = issuerA.localeCompare(issuerB);
          break;
      }

      return order === 'asc' ? comparison : -comparison;
    });
  }

  /**
   * Get credential status
   */
  private getCredentialStatus(credential: any): string {
    if (credential.expirationDate) {
      const expiry = new Date(credential.expirationDate);
      if (expiry < new Date()) {
        return 'expired';
      }
    }
    return 'active';
  }

  /**
   * Get credential name
   */
  private getCredentialName(credential: any): string {
    return credential.credentialSubject?.name ||
           credential.credentialSubject?.title ||
           credential.type[credential.type.length - 1];
  }

  /**
   * Get issuer name
   */
  private getIssuerName(credential: any): string {
    if (typeof credential.issuer === 'string') {
      return credential.issuer;
    }
    return credential.issuer?.name || credential.issuer?.id || '';
  }

  /**
   * Add to search history
   */
  private addToHistory(query: string): void {
    // Remove duplicates
    this.searchHistory = this.searchHistory.filter(q => q !== query);
    
    // Add to beginning
    this.searchHistory.unshift(query);
    
    // Limit history size
    if (this.searchHistory.length > this.MAX_HISTORY) {
      this.searchHistory = this.searchHistory.slice(0, this.MAX_HISTORY);
    }
  }

  /**
   * Get search history
   */
  getSearchHistory(): string[] {
    return this.searchHistory;
  }

  /**
   * Clear search history
   */
  clearHistory(): void {
    this.searchHistory = [];
  }
}

export default new CredentialSearchService();
```

---

## 📤 Step 6: Implement Export Service (US-2.8)

### 6.1 Create Export Service

**File**: `src/services/export/CredentialExport.ts`

```typescript
import RNFS from 'react-native-fs';
import Share from 'react-native-share';
import QRCode from 'react-native-qrcode-svg';

interface ExportOptions {
  format: 'json' | 'qr' | 'pdf';
  includeQR?: boolean;
  includeIssuerInfo?: boolean;
  template?: 'simple' | 'professional';
}

class CredentialExportService {
  /**
   * Export credential
   */
  async export(credential: any, options: ExportOptions): Promise<string> {
    switch (options.format) {
      case 'json':
        return await this.exportToJSON(credential);
      case 'qr':
        return await this.exportToQR(credential);
      case 'pdf':
        return await this.exportToPDF(credential, options);
      default:
        throw new Error(`Unsupported export format: ${options.format}`);
    }
  }

  /**
   * Export to JSON
   */
  private async exportToJSON(credential: any): Promise<string> {
    const fileName = `credential_${Date.now()}.json`;
    const filePath = `${RNFS.DocumentDirectoryPath}/${fileName}`;

    const jsonContent = JSON.stringify(credential, null, 2);
    
    await RNFS.writeFile(filePath, jsonContent, 'utf8');

    return filePath;
  }

  /**
   * Export to QR Code (returns base64 image)
   */
  private async exportToQR(credential: any): Promise<string> {
    // QR code will be generated by QRCode component
    // Return credential data as string
    return JSON.stringify(credential);
  }

  /**
   * Export to PDF
   */
  private async exportToPDF(credential: any, options: ExportOptions): Promise<string> {
    const fileName = `credential_${Date.now()}.pdf`;
    const filePath = `${RNFS.DocumentDirectoryPath}/${fileName}`;

    // Generate HTML content for PDF
    const htmlContent = this.generateHTMLForPDF(credential, options);

    // Convert HTML to PDF (would use react-native-html-to-pdf or similar)
    // For now, placeholder implementation
    // await RNHTMLtoPDF.convert({
    //   html: htmlContent,
    //   fileName: fileName,
    //   directory: 'Documents'
    // });

    return filePath;
  }

  /**
   * Generate HTML for PDF
   */
  private generateHTMLForPDF(credential: any, options: ExportOptions): string {
    const credType = this.getCredentialType(credential);
    const issuerName = this.getIssuerName(credential);
    const issueDate = new Date(credential.issuanceDate).toLocaleDateString();

    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <style>
          body {
            font-family: Arial, sans-serif;
            padding: 40px;
          }
          .header {
            text-align: center;
            margin-bottom: 40px;
          }
          .title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
          }
          .issuer {
            font-size: 18px;
            color: #666;
            margin-top: 10px;
          }
          .attributes {
            margin-top: 30px;
          }
          .attribute {
            margin-bottom: 15px;
            padding: 10px;
            background: #f5f5f5;
            border-radius: 5px;
          }
          .attribute-label {
            font-weight: bold;
            color: #333;
          }
          .attribute-value {
            margin-top: 5px;
            color: #666;
          }
          .footer {
            margin-top: 40px;
            text-align: center;
            font-size: 12px;
            color: #999;
          }
        </style>
      </head>
      <body>
        <div class="header">
          <div class="title">${credType}</div>
          <div class="issuer">Issued by: ${issuerName}</div>
          <div class="issuer">Issue Date: ${issueDate}</div>
        </div>

        <div class="attributes">
          ${this.generateAttributesHTML(credential.credentialSubject)}
        </div>

        ${options.includeQR ? '<div class="qr-placeholder">[QR Code]</div>' : ''}

        <div class="footer">
          This is a digitally signed verifiable credential.
          Verify at: [verification URL]
        </div>
      </body>
      </html>
    `;
  }

  /**
   * Generate attributes HTML
   */
  private generateAttributesHTML(credentialSubject: any): string {
    return Object.entries(credentialSubject)
      .filter(([key]) => key !== 'id')
      .map(([key, value]) => `
        <div class="attribute">
          <div class="attribute-label">${this.formatKey(key)}</div>
          <div class="attribute-value">${value}</div>
        </div>
      `)
      .join('');
  }

  /**
   * Share exported file
   */
  async shareFile(filePath: string, mimeType: string): Promise<void> {
    try {
      await Share.open({
        url: `file://${filePath}`,
        type: mimeType,
        title: 'Share Credential'
      });
    } catch (error) {
      console.error('Error sharing file:', error);
      throw error;
    }
  }

  /**
   * Helper: Get credential type
   */
  private getCredentialType(credential: any): string {
    const types = credential.type || [];
    return types.filter((t: string) => t !== 'VerifiableCredential')[0] || 'Credential';
  }

  /**
   * Helper: Get issuer name
   */
  private getIssuerName(credential: any): string {
    if (typeof credential.issuer === 'string') {
      return credential.issuer;
    }
    return credential.issuer?.name || credential.issuer?.id || 'Unknown Issuer';
  }

  /**
   * Helper: Format key
   */
  private formatKey(key: string): string {
    return key
      .replace(/([A-Z])/g, ' $1')
      .replace(/^./, str => str.toUpperCase())
      .trim();
  }
}

export default new CredentialExportService();
```

---

## 📝 Step 7: Testing

### 7.1 Test dengan Demo Issuers

```bash
# List of demo issuers untuk testing:
# 1. Sphereon Demo: https://ssi.sphereon.com/demo/issuer/
# 2. Walt.id: https://walt.id/
# 3. Mattr: https://launchpad.mattrlabs.com/
```

### 7.2 Test Credential Manifest Flow

1. Scan QR code dari issuer
2. Verify manifest fetching
3. Check output descriptors
4. Test credential application
5. Verify credential storage

### 7.3 Test OCA Rendering

1. Fetch OCA bundle
2. Verify styling application
3. Test dengan berbagai credential types
4. Test fallback rendering

### 7.4 Test Search & Export

1. Test full-text search
2. Test filtering
3. Test sorting
4. Test JSON export
5. Test QR export
6. Test PDF export

---

## 🔗 Next Steps

Setelah Sprint 2 selesai:
1. Sprint Review & Demo
2. Sprint Retrospective
3. Update Sprint 3 backlog (DIDComm v2)
4. Continue building!

---

**Documentation Version**: 1.0  
**Last Updated**: 2024  
**Status**: ✅ Ready for Implementation
