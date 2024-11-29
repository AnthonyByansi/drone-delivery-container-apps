#!/bin/bash  

# Create directory structure  
mkdir -p bicep/modules  
mkdir -p bicep/parameters  
mkdir -p workflows  
mkdir -p scripts  
mkdir -p docs  

# Create files  
touch README.md  
touch bicep/main.bicep  
touch bicep/modules/container-app.bicep  
touch bicep/modules/cosmos-db.bicep  
touch bicep/modules/redis-cache.bicep  
touch bicep/modules/key-vault.bicep  
touch bicep/modules/service-bus.bicep  
touch bicep/modules/application-insights.bicep  
touch bicep/modules/log-analytics.bicep  
touch bicep/modules/managed-identity.bicep  
touch bicep/parameters/dev.parameters.json  
touch bicep/parameters/staging.parameters.json  
touch bicep/parameters/prod.parameters.json  
touch workflows/deployment-workflow.yaml  
touch workflows/monitoring-workflow.yaml  
touch scripts/deploy.sh  
touch scripts/destroy.sh  
touch docs/architecture-diagram.png  
touch docs/setup-guide.md  
touch docs/troubleshooting.md  
touch .gitignore  

echo "File tree created successfully!"  
