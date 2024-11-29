param name string
param environmentId string
param image string
param cpu int = 1
param memory string = '1Gi'
param ingressEnabled bool = true
param ingressTargetPort int = 80

resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    environmentId: environmentId
    configuration: {
      ingress: ingressEnabled
        ? {
            external: true
            targetPort: ingressTargetPort
          }
        : null
    }
    template: {
      containers: [
        {
          name: name
          image: image
          resources: {
            cpu: cpu
            memory: memory
          }
        }
      ]
    }
  }
}

output appId string = containerApp.id
