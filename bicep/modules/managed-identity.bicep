param identityName string

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: identityName
  location: resourceGroup().location
}

output identityId string = userAssignedIdentity.id
output principalId string = userAssignedIdentity.properties.principalId
