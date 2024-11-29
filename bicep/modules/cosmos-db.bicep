param accountName string
param databaseName string
param throughput int = 400

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: accountName
  location: resourceGroup().location
  kind: 'MongoDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: resourceGroup().location
        failoverPriority: 0
      }
    ]
  }
}

resource cosmosDbDatabase 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-05-15' = {
  parent: cosmosDbAccount
  name: databaseName
  properties: {
    resource: {
      id: databaseName
    }
    options: {
      throughput: throughput
    }
  }
}

output connectionString string = cosmosDbAccount.properties.connectionStrings[0]
