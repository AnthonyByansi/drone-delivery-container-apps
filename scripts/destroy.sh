#!/bin/bash

# Exit on any error
set -e

# Variables
RESOURCE_GROUP=$1

# Validate inputs
if [[ -z "$RESOURCE_GROUP" ]]; then
  echo "Usage: ./destroy.sh <resource-group-name>"
  exit 1
fi

# Check if Azure CLI is logged in
az account show > /dev/null 2>&1 || {
  echo "Please log in using 'az login'."
  exit 1
}

# Delete the resource group
echo "Deleting resource group '$RESOURCE_GROUP'..."
az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "Resource group deletion initiated."
