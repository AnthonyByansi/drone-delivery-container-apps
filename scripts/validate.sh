#!/bin/bash

# Exit on any error
set -e

# Validate the Bicep file
echo "Validating main.bicep..."
az bicep build --file main.bicep > /dev/null 2>&1 || {
  echo "Validation failed. Please fix the errors in main.bicep."
  exit 1
}

echo "Validation passed successfully."
