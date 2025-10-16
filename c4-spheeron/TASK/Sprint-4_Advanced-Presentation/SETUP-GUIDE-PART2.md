# Sprint 4: Advanced Presentation - Setup Guide Part 2

## 🎛️ Step 7.8: Implement Consent Management UI (US-4.8)

### 7.8.1 Create Consent Management Component

**File**: `src/components/presentation/ConsentManager.tsx`

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, Switch, TouchableOpacity, ScrollView, Alert } from 'react-native';
import ConsentService from '@/services/presentation/ConsentService';
import type { ConsentRecord } from '@/types/presentation/ConsentTypes';

interface ConsentManagerProps {
  verifierDID: string;
  verifierName?: string;
  scope: string[];
  onConsentGranted?: (consentId: string) => void;
  onConsentDenied?: () => void;
}

export const ConsentManager: React.FC<ConsentManagerProps> = ({
  verifierDID,
  verifierName,
  scope,
  onConsentGranted,
  onConsentDenied
}) => {
  const [rememberConsent, setRememberConsent] = useState(false);
  const [expiryDuration, setExpiryDuration] = useState<number>(7 * 24 * 60 * 60 * 1000); // 7 days default
  const [existingConsent, setExistingConsent] = useState<ConsentRecord | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    checkExistingConsent();
  }, [verifierDID]);

  const checkExistingConsent = async () => {
    setLoading(true);
    try {
      const consent = await ConsentService.checkConsent(verifierDID);
      setExistingConsent(consent);
      
      if (consent && consent.remember) {
        // Automatically grant if remembered
        onConsentGranted?.(consent.id);
      }
    } catch (error) {
      console.error('Failed to check consent:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleGrantConsent = async () => {
    try {
      const consentId = await ConsentService.grantConsent({
        verifierDID,
        verifierName,
        scope,
        remember: rememberConsent,
        expiresIn: rememberConsent ? expiryDuration : undefined
      });

      onConsentGranted?.(consentId);
    } catch (error) {
      console.error('Failed to grant consent:', error);
      Alert.alert('Error', 'Failed to grant consent');
    }
  };

  const handleDenyConsent = () => {
    Alert.alert(
      'Deny Consent',
      'Are you sure you want to deny this request?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Deny',
          style: 'destructive',
          onPress: () => onConsentDenied?.()
        }
      ]
    );
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <Text>Checking consent...</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Consent Request</Text>
        <Text style={styles.verifier}>
          From: {verifierName || verifierDID}
        </Text>
      </View>

      {/* Scope Display */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Data Requested</Text>
        {scope.map((item, index) => (
          <View key={index} style={styles.scopeItem}>
            <Text style={styles.scopeIcon}>✓</Text>
            <Text style={styles.scopeText}>{formatScopeName(item)}</Text>
          </View>
        ))}
      </View>

      {/* Consent Options */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Consent Options</Text>
        
        <View style={styles.optionRow}>
          <View style={styles.optionInfo}>
            <Text style={styles.optionTitle}>Remember this decision</Text>
            <Text style={styles.optionDescription}>
              You won't be asked again for this verifier
            </Text>
          </View>
          <Switch
            value={rememberConsent}
            onValueChange={setRememberConsent}
          />
        </View>

        {rememberConsent && (
          <View style={styles.expirySection}>
            <Text style={styles.expiryTitle}>Consent expires in:</Text>
            
            <View style={styles.expiryOptions}>
              {[
                { label: '1 day', value: 1 * 24 * 60 * 60 * 1000 },
                { label: '7 days', value: 7 * 24 * 60 * 60 * 1000 },
                { label: '30 days', value: 30 * 24 * 60 * 60 * 1000 },
                { label: '90 days', value: 90 * 24 * 60 * 60 * 1000 }
              ].map((option) => (
                <TouchableOpacity
                  key={option.value}
                  style={[
                    styles.expiryOption,
                    expiryDuration === option.value && styles.expiryOptionSelected
                  ]}
                  onPress={() => setExpiryDuration(option.value)}
                >
                  <Text style={[
                    styles.expiryOptionText,
                    expiryDuration === option.value && styles.expiryOptionTextSelected
                  ]}>
                    {option.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        )}
      </View>

      {/* Privacy Notice */}
      <View style={styles.privacyNotice}>
        <Text style={styles.privacyIcon}>🔒</Text>
        <View style={styles.privacyContent}>
          <Text style={styles.privacyTitle}>Your Privacy</Text>
          <Text style={styles.privacyText}>
            • You can revoke this consent at any time{'\n'}
            • Consent is stored securely on your device{'\n'}
            • No third parties can access this consent{'\n'}
            • Audit log is maintained for transparency
          </Text>
        </View>
      </View>

      {/* Action Buttons */}
      <View style={styles.actions}>
        <TouchableOpacity
          style={[styles.button, styles.denyButton]}
          onPress={handleDenyConsent}
        >
          <Text style={styles.denyButtonText}>Deny</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.button, styles.grantButton]}
          onPress={handleGrantConsent}
        >
          <Text style={styles.grantButtonText}>Grant Consent</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

function formatScopeName(scope: string): string {
  return scope
    .replace(/([A-Z])/g, ' $1')
    .replace(/^./, str => str.toUpperCase())
    .trim();
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5'
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  header: {
    backgroundColor: 'white',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0'
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8
  },
  verifier: {
    fontSize: 14,
    color: '#666'
  },
  section: {
    backgroundColor: 'white',
    marginTop: 16,
    padding: 20
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 16
  },
  scopeItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12
  },
  scopeIcon: {
    fontSize: 16,
    color: '#4CAF50',
    marginRight: 12
  },
  scopeText: {
    fontSize: 15,
    color: '#333'
  },
  optionRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12
  },
  optionInfo: {
    flex: 1,
    marginRight: 12
  },
  optionTitle: {
    fontSize: 16,
    fontWeight: '500',
    marginBottom: 4
  },
  optionDescription: {
    fontSize: 13,
    color: '#666'
  },
  expirySection: {
    marginTop: 16,
    paddingTop: 16,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0'
  },
  expiryTitle: {
    fontSize: 14,
    fontWeight: '500',
    marginBottom: 12
  },
  expiryOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8
  },
  expiryOption: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#E0E0E0',
    backgroundColor: 'white'
  },
  expiryOptionSelected: {
    borderColor: '#2196F3',
    backgroundColor: '#E3F2FD'
  },
  expiryOptionText: {
    fontSize: 14,
    color: '#666'
  },
  expiryOptionTextSelected: {
    color: '#2196F3',
    fontWeight: '600'
  },
  privacyNotice: {
    flexDirection: 'row',
    backgroundColor: '#E8F5E9',
    margin: 16,
    padding: 16,
    borderRadius: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50'
  },
  privacyIcon: {
    fontSize: 24,
    marginRight: 12
  },
  privacyContent: {
    flex: 1
  },
  privacyTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2E7D32',
    marginBottom: 8
  },
  privacyText: {
    fontSize: 13,
    color: '#388E3C',
    lineHeight: 20
  },
  actions: {
    flexDirection: 'row',
    padding: 16,
    gap: 12
  },
  button: {
    flex: 1,
    paddingVertical: 16,
    borderRadius: 12,
    alignItems: 'center'
  },
  denyButton: {
    backgroundColor: 'white',
    borderWidth: 1,
    borderColor: '#F44336'
  },
  denyButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#F44336'
  },
  grantButton: {
    backgroundColor: '#2196F3'
  },
  grantButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: 'white'
  }
});
```

### 7.8.2 Create Consent List Screen

**File**: `src/screens/presentation/ConsentListScreen.tsx`

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, Alert } from 'react-native';
import { format } from 'date-fns';
import ConsentService from '@/services/presentation/ConsentService';
import type { ConsentRecord } from '@/types/presentation/ConsentTypes';

export const ConsentListScreen: React.FC = () => {
  const [consents, setConsents] = useState<ConsentRecord[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadConsents();
  }, []);

  const loadConsents = async () => {
    setLoading(true);
    try {
      const allConsents = await ConsentService.getAllConsents();
      setConsents(allConsents);
    } catch (error) {
      console.error('Failed to load consents:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleRevokeConsent = (verifierDID: string, verifierName?: string) => {
    Alert.alert(
      'Revoke Consent',
      `Are you sure you want to revoke consent for ${verifierName || verifierDID}?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Revoke',
          style: 'destructive',
          onPress: async () => {
            try {
              await ConsentService.revokeConsent(verifierDID);
              await loadConsents();
              Alert.alert('Success', 'Consent revoked successfully');
            } catch (error) {
              Alert.alert('Error', 'Failed to revoke consent');
            }
          }
        }
      ]
    );
  };

  const renderConsentItem = ({ item }: { item: ConsentRecord }) => {
    const isExpired = item.expiresAt && Date.now() > item.expiresAt;

    return (
      <View style={[styles.consentCard, isExpired && styles.consentCardExpired]}>
        <View style={styles.consentHeader}>
          <View style={styles.consentInfo}>
            <Text style={styles.verifierName}>
              {item.verifierName || 'Unknown Verifier'}
            </Text>
            <Text style={styles.verifierDID} numberOfLines={1}>
              {item.verifierDID}
            </Text>
          </View>

          {isExpired && (
            <View style={styles.expiredBadge}>
              <Text style={styles.expiredText}>EXPIRED</Text>
            </View>
          )}
        </View>

        <View style={styles.consentDetails}>
          <View style={styles.detailRow}>
            <Text style={styles.detailLabel}>Granted:</Text>
            <Text style={styles.detailValue}>
              {format(item.grantedAt, 'MMM d, yyyy HH:mm')}
            </Text>
          </View>

          {item.expiresAt && (
            <View style={styles.detailRow}>
              <Text style={styles.detailLabel}>Expires:</Text>
              <Text style={[
                styles.detailValue,
                isExpired && styles.detailValueExpired
              ]}>
                {format(item.expiresAt, 'MMM d, yyyy HH:mm')}
              </Text>
            </View>
          )}

          <View style={styles.detailRow}>
            <Text style={styles.detailLabel}>Used:</Text>
            <Text style={styles.detailValue}>
              {item.usageCount} time(s)
            </Text>
          </View>

          {item.lastUsed && (
            <View style={styles.detailRow}>
              <Text style={styles.detailLabel}>Last used:</Text>
              <Text style={styles.detailValue}>
                {format(item.lastUsed, 'MMM d, yyyy HH:mm')}
              </Text>
            </View>
          )}
        </View>

        <View style={styles.scopeSection}>
          <Text style={styles.scopeTitle}>Allowed Data:</Text>
          <View style={styles.scopeList}>
            {item.scope.map((s, index) => (
              <View key={index} style={styles.scopeChip}>
                <Text style={styles.scopeChipText}>{s}</Text>
              </View>
            ))}
          </View>
        </View>

        {!isExpired && (
          <TouchableOpacity
            style={styles.revokeButton}
            onPress={() => handleRevokeConsent(item.verifierDID, item.verifierName)}
          >
            <Text style={styles.revokeButtonText}>Revoke Consent</Text>
          </TouchableOpacity>
        )}
      </View>
    );
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <Text>Loading consents...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Consent Management</Text>
        <Text style={styles.subtitle}>
          {consents.length} active consent(s)
        </Text>
      </View>

      {consents.length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>🔐</Text>
          <Text style={styles.emptyText}>No consents granted yet</Text>
          <Text style={styles.emptySubtext}>
            Consents will appear here when you grant access to verifiers
          </Text>
        </View>
      ) : (
        <FlatList
          data={consents}
          renderItem={renderConsentItem}
          keyExtractor={item => item.id}
          contentContainerStyle={styles.list}
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5'
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  header: {
    backgroundColor: 'white',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0'
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 4
  },
  subtitle: {
    fontSize: 14,
    color: '#666'
  },
  list: {
    padding: 16
  },
  consentCard: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50'
  },
  consentCardExpired: {
    borderLeftColor: '#F44336',
    opacity: 0.7
  },
  consentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 12
  },
  consentInfo: {
    flex: 1
  },
  verifierName: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4
  },
  verifierDID: {
    fontSize: 12,
    color: '#666',
    fontFamily: 'monospace'
  },
  expiredBadge: {
    backgroundColor: '#F44336',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4
  },
  expiredText: {
    color: 'white',
    fontSize: 11,
    fontWeight: 'bold'
  },
  consentDetails: {
    marginBottom: 12
  },
  detailRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 6
  },
  detailLabel: {
    fontSize: 13,
    color: '#666'
  },
  detailValue: {
    fontSize: 13,
    color: '#333',
    fontWeight: '500'
  },
  detailValueExpired: {
    color: '#F44336'
  },
  scopeSection: {
    marginBottom: 12
  },
  scopeTitle: {
    fontSize: 13,
    fontWeight: '500',
    color: '#666',
    marginBottom: 8
  },
  scopeList: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 6
  },
  scopeChip: {
    backgroundColor: '#E3F2FD',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 12
  },
  scopeChipText: {
    fontSize: 12,
    color: '#1976D2'
  },
  revokeButton: {
    backgroundColor: '#FFEBEE',
    paddingVertical: 10,
    borderRadius: 8,
    alignItems: 'center'
  },
  revokeButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#F44336'
  },
  emptyState: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40
  },
  emptyIcon: {
    fontSize: 64,
    marginBottom: 16
  },
  emptyText: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
    color: '#333'
  },
  emptySubtext: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center'
  }
});
```

---

## 📋 Step 7.9: Implement Presentation Templates (US-4.9)

### 7.9.1 Create Template Types

**File**: `src/types/presentation/TemplateTypes.ts`

```typescript
/**
 * Presentation Template Type Definitions
 */

export interface PresentationTemplate {
  id: string;
  name: string;
  description?: string;
  credentialType: string;
  disclosedClaims: string[];
  createdAt: number;
  updatedAt: number;
  usageCount: number;
  isDefault?: boolean;
}

export interface TemplateCreateOptions {
  name: string;
  description?: string;
  credentialType: string;
  disclosedClaims: string[];
  isDefault?: boolean;
}
```

### 7.9.2 Create Template Service

**File**: `src/services/presentation/TemplateService.ts`

```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';
import type { PresentationTemplate, TemplateCreateOptions } from '@/types/presentation/TemplateTypes';

class TemplateService {
  private readonly STORAGE_KEY = 'presentation_templates';

  /**
   * Create new template
   */
  async createTemplate(options: TemplateCreateOptions): Promise<string> {
    const templates = await this.getAllTemplates();

    const newTemplate: PresentationTemplate = {
      id: `template-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`,
      ...options,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      usageCount: 0
    };

    templates.push(newTemplate);
    await this.saveTemplates(templates);

    return newTemplate.id;
  }

  /**
   * Get all templates
   */
  async getAllTemplates(): Promise<PresentationTemplate[]> {
    const data = await AsyncStorage.getItem(this.STORAGE_KEY);
    return data ? JSON.parse(data) : [];
  }

  /**
   * Get template by ID
   */
  async getTemplate(id: string): Promise<PresentationTemplate | null> {
    const templates = await this.getAllTemplates();
    return templates.find(t => t.id === id) || null;
  }

  /**
   * Get templates for credential type
   */
  async getTemplatesForCredentialType(credentialType: string): Promise<PresentationTemplate[]> {
    const templates = await this.getAllTemplates();
    return templates.filter(t => t.credentialType === credentialType);
  }

  /**
   * Update template
   */
  async updateTemplate(id: string, updates: Partial<TemplateCreateOptions>): Promise<void> {
    const templates = await this.getAllTemplates();
    const index = templates.findIndex(t => t.id === id);

    if (index === -1) {
      throw new Error('Template not found');
    }

    templates[index] = {
      ...templates[index],
      ...updates,
      updatedAt: Date.now()
    };

    await this.saveTemplates(templates);
  }

  /**
   * Delete template
   */
  async deleteTemplate(id: string): Promise<void> {
    const templates = await this.getAllTemplates();
    const filtered = templates.filter(t => t.id !== id);
    await this.saveTemplates(filtered);
  }

  /**
   * Increment usage count
   */
  async incrementUsage(id: string): Promise<void> {
    const templates = await this.getAllTemplates();
    const template = templates.find(t => t.id === id);

    if (template) {
      template.usageCount++;
      template.updatedAt = Date.now();
      await this.saveTemplates(templates);
    }
  }

  /**
   * Set as default template for credential type
   */
  async setDefault(id: string): Promise<void> {
    const templates = await this.getAllTemplates();
    const template = templates.find(t => t.id === id);

    if (!template) {
      throw new Error('Template not found');
    }

    // Remove default from other templates of same type
    templates.forEach(t => {
      if (t.credentialType === template.credentialType) {
        t.isDefault = false;
      }
    });

    // Set this template as default
    template.isDefault = true;
    await this.saveTemplates(templates);
  }

  /**
   * Get default template for credential type
   */
  async getDefaultTemplate(credentialType: string): Promise<PresentationTemplate | null> {
    const templates = await this.getTemplatesForCredentialType(credentialType);
    return templates.find(t => t.isDefault) || null;
  }

  /**
   * Save templates to storage
   */
  private async saveTemplates(templates: PresentationTemplate[]): Promise<void> {
    await AsyncStorage.setItem(this.STORAGE_KEY, JSON.stringify(templates));
  }
}

export default new TemplateService();
```

### 7.9.3 Create Template Manager Component

**File**: `src/components/presentation/TemplateManager.tsx`

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, Alert, TextInput, Modal } from 'react-native';
import TemplateService from '@/services/presentation/TemplateService';
import type { PresentationTemplate, TemplateCreateOptions } from '@/types/presentation/TemplateTypes';

export const TemplateManager: React.FC = () => {
  const [templates, setTemplates] = useState<PresentationTemplate[]>([]);
  const [loading, setLoading] = useState(true);
  const [showCreateModal, setShowCreateModal] = useState(false);

  useEffect(() => {
    loadTemplates();
  }, []);

  const loadTemplates = async () => {
    setLoading(true);
    try {
      const allTemplates = await TemplateService.getAllTemplates();
      setTemplates(allTemplates);
    } catch (error) {
      console.error('Failed to load templates:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteTemplate = (template: PresentationTemplate) => {
    Alert.alert(
      'Delete Template',
      `Are you sure you want to delete "${template.name}"?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Delete',
          style: 'destructive',
          onPress: async () => {
            try {
              await TemplateService.deleteTemplate(template.id);
              await loadTemplates();
            } catch (error) {
              Alert.alert('Error', 'Failed to delete template');
            }
          }
        }
      ]
    );
  };

  const handleSetDefault = async (template: PresentationTemplate) => {
    try {
      await TemplateService.setDefault(template.id);
      await loadTemplates();
      Alert.alert('Success', 'Template set as default');
    } catch (error) {
      Alert.alert('Error', 'Failed to set default template');
    }
  };

  const renderTemplateItem = ({ item }: { item: PresentationTemplate }) => (
    <View style={styles.templateCard}>
      <View style={styles.templateHeader}>
        <View style={styles.templateInfo}>
          <Text style={styles.templateName}>{item.name}</Text>
          {item.description && (
            <Text style={styles.templateDescription}>{item.description}</Text>
          )}
          <Text style={styles.templateType}>
            Type: {item.credentialType}
          </Text>
        </View>

        {item.isDefault && (
          <View style={styles.defaultBadge}>
            <Text style={styles.defaultText}>DEFAULT</Text>
          </View>
        )}
      </View>

      <View style={styles.templateDetails}>
        <Text style={styles.detailLabel}>Disclosed Fields:</Text>
        <View style={styles.claimsList}>
          {item.disclosedClaims.map((claim, index) => (
            <View key={index} style={styles.claimChip}>
              <Text style={styles.claimChipText}>{claim}</Text>
            </View>
          ))}
        </View>
      </View>

      <View style={styles.templateStats}>
        <Text style={styles.statText}>Used {item.usageCount} times</Text>
        <Text style={styles.statText}>
          Updated {new Date(item.updatedAt).toLocaleDateString()}
        </Text>
      </View>

      <View style={styles.templateActions}>
        {!item.isDefault && (
          <TouchableOpacity
            style={styles.actionButton}
            onPress={() => handleSetDefault(item)}
          >
            <Text style={styles.actionButtonText}>Set as Default</Text>
          </TouchableOpacity>
        )}

        <TouchableOpacity
          style={[styles.actionButton, styles.deleteButton]}
          onPress={() => handleDeleteTemplate(item)}
        >
          <Text style={[styles.actionButtonText, styles.deleteButtonText]}>
            Delete
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View>
          <Text style={styles.title}>Presentation Templates</Text>
          <Text style={styles.subtitle}>{templates.length} template(s)</Text>
        </View>

        <TouchableOpacity
          style={styles.createButton}
          onPress={() => setShowCreateModal(true)}
        >
          <Text style={styles.createButtonText}>+ New</Text>
        </TouchableOpacity>
      </View>

      {templates.length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>📋</Text>
          <Text style={styles.emptyText}>No templates yet</Text>
          <Text style={styles.emptySubtext}>
            Create templates to quickly share common credential combinations
          </Text>
        </View>
      ) : (
        <FlatList
          data={templates}
          renderItem={renderTemplateItem}
          keyExtractor={item => item.id}
          contentContainerStyle={styles.list}
        />
      )}

      <CreateTemplateModal
        visible={showCreateModal}
        onClose={() => setShowCreateModal(false)}
        onCreated={loadTemplates}
      />
    </View>
  );
};

// Create Template Modal Component
interface CreateTemplateModalProps {
  visible: boolean;
  onClose: () => void;
  onCreated: () => void;
}

const CreateTemplateModal: React.FC<CreateTemplateModalProps> = ({
  visible,
  onClose,
  onCreated
}) => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [credentialType, setCredentialType] = useState('');
  const [claims, setClaims] = useState('');

  const handleCreate = async () => {
    if (!name || !credentialType || !claims) {
      Alert.alert('Error', 'Please fill all required fields');
      return;
    }

    try {
      const claimsArray = claims.split(',').map(c => c.trim());

      await TemplateService.createTemplate({
        name,
        description,
        credentialType,
        disclosedClaims: claimsArray
      });

      setName('');
      setDescription('');
      setCredentialType('');
      setClaims('');
      onCreated();
      onClose();
    } catch (error) {
      Alert.alert('Error', 'Failed to create template');
    }
  };

  return (
    <Modal
      visible={visible}
      animationType="slide"
      transparent
      onRequestClose={onClose}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <Text style={styles.modalTitle}>New Template</Text>

          <TextInput
            style={styles.input}
            placeholder="Template Name *"
            value={name}
            onChangeText={setName}
          />

          <TextInput
            style={styles.input}
            placeholder="Description"
            value={description}
            onChangeText={setDescription}
            multiline
          />

          <TextInput
            style={styles.input}
            placeholder="Credential Type *"
            value={credentialType}
            onChangeText={setCredentialType}
          />

          <TextInput
            style={styles.input}
            placeholder="Claims (comma-separated) *"
            value={claims}
            onChangeText={setClaims}
            multiline
          />

          <View style={styles.modalActions}>
            <TouchableOpacity
              style={[styles.modalButton, styles.cancelButton]}
              onPress={onClose}
            >
              <Text style={styles.cancelButtonText}>Cancel</Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={[styles.modalButton, styles.createModalButton]}
              onPress={handleCreate}
            >
              <Text style={styles.createModalButtonText}>Create</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5'
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: 'white',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0'
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 4
  },
  subtitle: {
    fontSize: 14,
    color: '#666'
  },
  createButton: {
    backgroundColor: '#2196F3',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 8
  },
  createButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600'
  },
  list: {
    padding: 16
  },
  templateCard: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12
  },
  templateHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 12
  },
  templateInfo: {
    flex: 1
  },
  templateName: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 4
  },
  templateDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 4
  },
  templateType: {
    fontSize: 12,
    color: '#999'
  },
  defaultBadge: {
    backgroundColor: '#4CAF50',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4
  },
  defaultText: {
    color: 'white',
    fontSize: 11,
    fontWeight: 'bold'
  },
  templateDetails: {
    marginBottom: 12
  },
  detailLabel: {
    fontSize: 13,
    fontWeight: '500',
    color: '#666',
    marginBottom: 8
  },
  claimsList: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 6
  },
  claimChip: {
    backgroundColor: '#E3F2FD',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 12
  },
  claimChipText: {
    fontSize: 12,
    color: '#1976D2'
  },
  templateStats: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingTop: 12,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    marginBottom: 12
  },
  statText: {
    fontSize: 12,
    color: '#999'
  },
  templateActions: {
    flexDirection: 'row',
    gap: 8
  },
  actionButton: {
    flex: 1,
    paddingVertical: 10,
    borderRadius: 8,
    alignItems: 'center',
    backgroundColor: '#E3F2FD'
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#2196F3'
  },
  deleteButton: {
    backgroundColor: '#FFEBEE'
  },
  deleteButtonText: {
    color: '#F44336'
  },
  emptyState: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40
  },
  emptyIcon: {
    fontSize: 64,
    marginBottom: 16
  },
  emptyText: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
    color: '#333'
  },
  emptySubtext: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center'
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'center',
    padding: 20
  },
  modalContent: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 20
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20
  },
  input: {
    borderWidth: 1,
    borderColor: '#E0E0E0',
    borderRadius: 8,
    padding: 12,
    marginBottom: 12,
    fontSize: 15
  },
  modalActions: {
    flexDirection: 'row',
    gap: 12,
    marginTop: 8
  },
  modalButton: {
    flex: 1,
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: 'center'
  },
  cancelButton: {
    backgroundColor: '#F5F5F5'
  },
  cancelButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#666'
  },
  createModalButton: {
    backgroundColor: '#2196F3'
  },
  createModalButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: 'white'
  }
});
```

---

## 🎉 Sprint 4 Implementation Complete!

Anda sekarang memiliki implementasi lengkap untuk semua 9 user stories Sprint 4:

- ✅ **US-4.1**: SD-JWT Support (Step 2)
- ✅ **US-4.2**: BBS+ Signatures (Step 3)  
- ✅ **US-4.3**: Presentation Exchange v2 (Step 4)
- ✅ **US-4.4**: Advanced Disclosure UI (Step 5)
- ✅ **US-4.5**: Predicate Proofs UI (Step 7.5)
- ✅ **US-4.6**: JWT VC Presentation Profile (Step 7.6)
- ✅ **US-4.7**: Presentation History (Step 7.7)
- ✅ **US-4.8**: Consent Management UI (Step 7.8)
- ✅ **US-4.9**: Presentation Templates (Step 7.9)

### 📊 Total Implementation Summary

**Lines of Code**: ~4,500+ lines
**Files Created**: 25+ files
**Components**: 8 major components
**Services**: 6 core services
**Test Files**: 5+ test suites

**Next Steps**: Refer to main SETUP-GUIDE.md Step 8 for deployment checklist!
