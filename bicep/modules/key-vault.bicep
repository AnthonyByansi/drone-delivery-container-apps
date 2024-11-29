param vaultName string

resource keyVault 'Microsoft.KeyVault/vaults@2022-11-01' = {
  name: vaultName
  location: resourceGroup().location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [] // Managed Identity integration will add policies dynamically
  }
}

output vaultId string = keyVault.id
