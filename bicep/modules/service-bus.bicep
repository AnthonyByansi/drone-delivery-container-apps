param namespaceName string
param topicName string
param subscriptionName string

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: namespaceName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource serviceBusTopic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  parent: serviceBusNamespace
  name: topicName
}

resource serviceBusSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  parent: serviceBusTopic
  name: subscriptionName
}

output serviceBusNamespaceId string = serviceBusNamespace.id
