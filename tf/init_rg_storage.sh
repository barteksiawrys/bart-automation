#!/bin/bash
# skrypt do stworzenia pierwszej rg i storage account do zapisywania .tfstate

export RESOURCE_GROUP_NAME=mgmt
export STORAGE_ACCOUNT_NAME=tfstate$RANDOM
export CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location polandcentral

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_ZRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Check access_key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY
echo "Storage account $STORAGE_ACCOUNT_NAME access key: $ARM_ACCESS_KEY"
