param location string = 'westus2'
param userAssignedName string = 'umi-wweeks-dev-usw2-001'
param keyVaultName string = 'kv-wweeks-dev-usw2-001'
param keyName string = 'key-wweeks-dev-usw2-001'
param allowedIP string = '192.16.100.101'
keyvaultid


module managedIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.4.1' = {
    params: {
      name: userAssignedName
      location: location
    }
  }
  
  module vault 'br/public:avm/res/key-vault/vault:0.12.1' = {
    params: {
      name: keyVaultName
      location: location
      tags: {
        costCenter: 'wweeks-dev-usw2'
        environment: 'dev'
        owner: 'wweeks'
      }
      sku: 'premium'
      networkAcls: {
        bypass: 'AzureServices'
        defaultAction: 'Deny'
        ipRules: [
          {
            action: 'Allow'
            value: allowedIP
          }
        ]
        virtualNetworkRules: []
      }
      accessPolicies:[]
      enableVaultForDeployment: true
      enableVaultForDiskEncryption: true
      enableSoftDelete: true
      softDeleteRetentionInDays: 90
      enableRbacAuthorization: true
      keys: [ 
        {
          name: keyName
          attributes: {
            enabled: true
            exp: 1805385158  
          }
          kty: 'RSA'         
          keySize: 4096     
        }
      ]
    }
    dependsOn: [
      managedIdentity
    ]
  }

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(keyVaultid, userAssignedId, 'e147488a-f6f5-4113-8e2d-b22465e65bf6')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e147488a-f6f5-4113-8e2d-b22465e65bf6')
    principalId: managedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
  }
}
