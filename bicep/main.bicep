// Parameters
param resourceGroupLocation string = resourceGroup().location
param environmentName string
param containerRegistryName string
param ingressHostName string = 'drone-delivery.${resourceGroupLocation}.azurecontainerapps.io'

// Resource Identifiers
var containerAppEnvId = resourceId('Microsoft.App/managedEnvironments', environmentName)
var acrId = resourceId('Microsoft.ContainerRegistry/registries', containerRegistryName)

// Deploy Managed Environment for Azure Container Apps
resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: environmentName
  location: resourceGroupLocation
}

// Deploy Managed Identity
module managedIdentity './modules/managed-identity.bicep' = {
  name: 'managedIdentityModule'
  params: {
    identityName: 'drone-delivery-identity'
  }
}

// Deploy Azure Cosmos DB for MongoDB API
module cosmosDb './modules/cosmos-db.bicep' = {
  name: 'cosmosDbModule'
  params: {
    accountName: 'drone-delivery-db'
    databaseName: 'deliveryDatabase'
  }
}

// Deploy Azure Cache for Redis
module redisCache './modules/redis-cache.bicep' = {
  name: 'redisCacheModule'
  params: {
    cacheName: 'drone-delivery-cache'
  }
}

// Deploy Azure Service Bus
module serviceBus './modules/service-bus.bicep' = {
  name: 'serviceBusModule'
  params: {
    namespaceName: 'drone-delivery-bus'
    topicName: 'delivery-events'
    subscriptionName: 'workflow-service'
  }
}

// Deploy Application Insights
module appInsights './modules/application-insights.bicep' = {
  name: 'appInsightsModule'
  params: {
    appName: 'drone-delivery-insights'
  }
}

// Deploy Log Analytics Workspace
module logAnalytics './modules/log-analytics.bicep' = {
  name: 'logAnalyticsModule'
  params: {
    workspaceName: 'drone-delivery-logs'
  }
}

// Deploy Container Apps
module ingestionService './modules/container-app.bicep' = {
  name: 'ingestionServiceModule'
  params: {
    name: 'ingestion-service'
    environmentId: containerAppEnvId
    image: '${containerRegistryName}.azurecr.io/ingestion-service:latest'
    ingressEnabled: true
    ingressTargetPort: 80
  }
}

module workflowService './modules/container-app.bicep' = {
  name: 'workflowServiceModule'
  params: {
    name: 'workflow-service'
    environmentId: containerAppEnvId
    image: '${containerRegistryName}.azurecr.io/workflow-service:latest'
    ingressEnabled: false
  }
}

module droneSchedulerService './modules/container-app.bicep' = {
  name: 'droneSchedulerServiceModule'
  params: {
    name: 'drone-scheduler-service'
    environmentId: containerAppEnvId
    image: '${containerRegistryName}.azurecr.io/drone-scheduler-service:latest'
    ingressEnabled: false
  }
}

module packageService './modules/container-app.bicep' = {
  name: 'packageServiceModule'
  params: {
    name: 'package-service'
    environmentId: containerAppEnvId
    image: '${containerRegistryName}.azurecr.io/package-service:latest'
    ingressEnabled: false
  }
}

module deliveryService './modules/container-app.bicep' = {
  name: 'deliveryServiceModule'
  params: {
    name: 'delivery-service'
    environmentId: containerAppEnvId
    image: '${containerRegistryName}.azurecr.io/delivery-service:latest'
    ingressEnabled: true
    ingressTargetPort: 443
  }
}

// Outputs
output ingestionServiceUrl string = 'https://${ingressHostName}/ingestion'
output cosmosDbConnectionString string = cosmosDb.outputs.connectionString
output redisCacheHostname string = redisCache.outputs.redisHostName
output appInsightsInstrumentationKey string = appInsights.outputs.instrumentationKey
output serviceBusNamespaceId string = serviceBus.outputs.serviceBusNamespaceId
output managedIdentityPrincipalId string = managedIdentity.outputs.principalId
output logAnalyticsWorkspaceId string = logAnalytics.outputs.workspaceId
