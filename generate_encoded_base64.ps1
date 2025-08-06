param(
    [string]$storageAccountName,
    [string]$containerName,
    [string]$blobName,
    [string]$downloadPath = "C:\scripts",
    [string]$azPath = "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"
)


$script = @"
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'


# Print PATH safely (optional, for debugging)
Write-Output "Path"
Write-Output "`$env:PATH"
Write-Output "Path"

# Add Azure CLI to PATH (Windows example)

`$env:PATH += ";$azPath"

az login --identity

New-Item -Path '$downloadPath' -ItemType Directory -Force | Out-Null
Write-Output "az command"
Write-Output "az `$storageAccountName"
Write-Output "az storage blob download --account-name $storageAccountName -c $containerName -n $blobName -f $downloadPath\$blobName --auth-mode login"
Write-Output "az command"
az storage blob download --account-name $storageAccountName -c $containerName -n $blobName -f $downloadPath\$blobName --auth-mode login

powershell -ExecutionPolicy Bypass -File $downloadPath\$blobName
"@


# Encode to Base64 using UTF-16LE (Unicode in .NET)
$bytes = [System.Text.Encoding]::Unicode.GetBytes($script)
$encoded = [Convert]::ToBase64String($bytes)

# Output result to console
# Write-Host "`n✅ Encoded PowerShell Script:"
# Write-Host "---------------------------------------------"
# Write-Host $encoded
# Write-Host "---------------------------------------------"
# Write-Host "powershell -EncodedCommand $encoded"

Write-Output $encoded
