#!/bin/bash

# Exit on any error
set -e

# Variables
RESOURCE_GROUP=$1
PARAM_FILE=$2

# Validate inputs
if [[ -z "$RESOURCE_GROUP" || -z "$PARAM_FILE" ]]; then
  echo "Usage: ./deploy.sh <resource-group-name> <parameter-file>"
  exit 1
fi

# Check if Azure CLI is logged in
az account show > /dev/null 2>&1 || {
  echo "Please log in using 'az login'."
  exit 1
}

# Create the resource group if it doesn't exist
echo "Ensuring resource group '$RESOURCE_GROUP' exists..."
az group create --name "$RESOURCE_GROUP" --location "$(jq -r '.parameters.resourceGroupLocation.value' < "$PARAM_FILE")"

# Deploy the Bicep template
echo "Deploying Azure resources..."
az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file main.bicep \
  --parameters @"$PARAM_FILE"

echo "Deployment completed successfully."
