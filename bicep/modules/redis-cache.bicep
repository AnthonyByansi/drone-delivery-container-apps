param cacheName string
param skuName string = 'Standard'
param capacity int = 1

resource redisCache 'Microsoft.Cache/Redis@2021-06-01' = {
  name: cacheName
  location: resourceGroup().location
  properties: {
    sku: {
      name: skuName
      family: 'C'
      capacity: capacity
    }
    enableNonSslPort: false
  }
}

output redisHostName string = redisCache.properties.hostName
