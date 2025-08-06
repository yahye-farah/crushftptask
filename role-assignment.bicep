param principalId string
param storageAccountName string

resource existingStorage 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, existingStorage.id, 'blob-reader')
  scope: existingStorage
  properties: {
    principalId: principalId
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'  // Storage Blob Data Reader
    )
    principalType: 'ServicePrincipal'
  }
}
