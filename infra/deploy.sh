#!/bin/bash
# Azure deployment script for Railway Management Application
# This script deploys the application infrastructure to Azure

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID:-}"
RESOURCE_GROUP_NAME="rg-railway-mgmt"
LOCATION="centralindia"
DEPLOYMENT_NAME="railway-deployment-$(date +%s)"

# Function to print colored messages
print_step() {
    echo -e "${GREEN}[STEP]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Step 1: Check prerequisites
print_step "Checking prerequisites..."

if ! command -v az &> /dev/null; then
    print_error "Azure CLI is not installed. Please install it first: https://docs.microsoft.com/cli/azure/install-azure-cli"
    exit 1
fi

if ! command -v mvn &> /dev/null; then
    print_warning "Maven not found in PATH. Make sure Maven is installed and available."
fi

# Step 2: Check if user is logged in
print_step "Checking Azure CLI login status..."
az account show > /dev/null 2>&1 || {
    print_step "Please log in to Azure..."
    az login
}

# Step 3: Set subscription if provided
if [ -n "$SUBSCRIPTION_ID" ]; then
    print_step "Setting subscription: $SUBSCRIPTION_ID"
    az account set --subscription "$SUBSCRIPTION_ID"
fi

# Get current subscription
CURRENT_SUBSCRIPTION=$(az account show --query id -o tsv)
print_step "Using subscription: $CURRENT_SUBSCRIPTION"

# Step 4: Create resource group
print_step "Creating resource group: $RESOURCE_GROUP_NAME in $LOCATION..."
az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --output table

# Step 5: Validate Bicep template
print_step "Validating Bicep template..."
az bicep build --file ./infra/main.bicep

# Step 6: Deploy infrastructure
print_step "Deploying infrastructure using Bicep..."
print_warning "⚠️  IMPORTANT: Update the MySQL admin password in parameters.bicepparam BEFORE deploying!"
read -p "Have you updated the MySQL password? (yes/no): " -r PASSWORD_CONFIRMED

if [ "$PASSWORD_CONFIRMED" != "yes" ]; then
    print_error "Please update the password in parameters.bicepparam and try again."
    exit 1
fi

# Read password from parameters file or prompt
MYSQL_PASSWORD=$(grep 'param mysqlAdminPassword' ./infra/parameters.bicepparam | grep -o "'[^']*'" | tr -d "'")

az deployment group create \
    --name "$DEPLOYMENT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --template-file ./infra/main.bicep \
    --parameters ./infra/parameters.bicepparam \
    --parameters mysqlAdminPassword="$MYSQL_PASSWORD" \
    --output table

# Step 7: Get deployment outputs
print_step "Retrieving deployment outputs..."
OUTPUTS=$(az deployment group show \
    --name "$DEPLOYMENT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --query properties.outputs)

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo ""
echo "Deployment Outputs:"
echo "$OUTPUTS" | jq '.'

# Step 8: Save outputs to file
OUTPUT_FILE=".azure/deployment-outputs.json"
echo "$OUTPUTS" > "$OUTPUT_FILE"
print_step "Outputs saved to: $OUTPUT_FILE"

# Step 9: Next steps
print_step "Next steps:"
echo "1. Build the application: mvn clean package"
echo "2. Update database connection in src/main/java/db/DBConnection.java"
echo "3. Deploy to App Service: az webapp deployment source config-zip --resource-group $RESOURCE_GROUP_NAME --name <app-service-name> --src target/RailwayManagement.war"
echo ""
print_step "Deployment summary saved. Review the outputs above for Azure resource details."
