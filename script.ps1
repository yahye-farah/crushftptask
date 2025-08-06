
$RESOURCE_GROUP_NAME="crashftp-resource-group"

#Your ipaddress 
$johnIP = Invoke-RestMethod -Uri 'https://api.ipify.org'
$bobIP = Invoke-RestMethod -Uri 'https://api.ipify.org'

#Create resource group
echo "CREATING $RESOURCE_GROUP_NAME"
az group create --location eastus --name $RESOURCE_GROUP_NAME

#Set resource group as default
az configure --defaults group=$RESOURCE_GROUP_NAME

#Create azure blop
echo "CREATING BLOB STORAGE"
az deployment group create --name main --template-file storage-account.bicep

#Upload download scripts
$ACCOUNT_NAME=$(az storage account list --resource-group $RESOURCE_GROUP_NAME --query "[0].name" -o tsv);
$CONTAINER_NAME=$(az storage container list --account-name $ACCOUNT_NAME  --query "[0].name" -o tsv);



echo "UPLOADING SCRIPTS INTO STORAGE account_name: $ACCOUNT_NAME and container_name: $CONTAINER_NAME"
az storage blob upload --account-name $ACCOUNT_NAME --container-name $CONTAINER_NAME  --name  install-crushftp.ps1 --file ./install_crushftp.ps1

$temp = & ./generate_encoded_base64.ps1 `
  -storageAccountName $ACCOUNT_NAME `
  -containerName $CONTAINER_NAME `
  -blobName "install-crushftp.ps1"


echo "CHECK TEMP BASE64"
echo $temp;
echo "CHECK TEMP BASE64"


# deploy resources
echo "DEPLOYING RESOURCES"
az deployment group create --name main --template-file main.bicep --parameters adminPassword="Geel@234455" storageAccountName=$ACCOUNT_NAME encodedScript=$temp  johnIP=$johnIP bobIP=$bobIP



