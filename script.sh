#!/bin/bash

RESOURCE_GROUP_NAME="crashftp-resource-group"

# create resource group
echo "CREATING $RESOURCE_GROUP_NAME"
az group create --location eastus --name $RESOURCE_GROUP_NAME

# set resource group as default
az configure --defaults group=$RESOURCE_GROUP_NAME

#create azure blop
echo "CREATING BLOP STORAGE"
az deployment group create --name main --template-file azureBlop.bicep

#Upload download scripts
ACCOUNT_NAME=$(az storage account list --resource-group $RESOURCE_GROUP_NAME --query "[0].name" -o tsv);
CONTAINER_NAME=$(az storage container list --account-name $ACCOUNT_NAME  --query "[0].name" -o tsv);


# az storage container list --account-name "mystorageoyh7c7afmfxlu"  --query "[0].name" -o tsv
echo "UPLOADING SCRIPTS INTO STORAGE account_name: $ACCOUNT_NAME and container_name: $CONTAINER_NAME"
az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINER_NAME  --name  install-crushftp.ps1 --file ./install_crushftp.ps1

# deploy resources
echo "DEPLOYING RESOURCES"
az deployment group create --name main --template-file main.bicep --parameters adminPassword="YourStrongPass" storageAccount=$ACCOUNT_NAME storageContainer=$CONTAINER_NAME bobIP='' johnIP=''