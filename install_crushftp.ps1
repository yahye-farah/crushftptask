# Install Chocolatey and Java
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-WebRequest https://community.chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
choco install jre8 -y

# Create shared folder and test file
New-Item -ItemType Directory -Path "C:\CrushFTP\shared" -Force
Set-Content -Path "C:\CrushFTP\shared\test.txt" -Value "Welcome to the Test file for John and Bob"


# Allow HTTPS 
New-NetFirewallRule -DisplayName "CrushFTP HTTPS" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow

# Allow HTTP temporiraly so that letsencrypt can verify the domain
New-NetFirewallRule -DisplayName "CrushFTP HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow

# Allow SSH on 22
New-NetFirewallRule -DisplayName "CrushFTP SSH" -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow


# Download and unzip CrushFTP
Invoke-WebRequest -Uri "https://www.crushftp.com/early9/J/CrushFTP9.zip" -OutFile "C:\CrushFTP\CrushFTP9.zip"
Expand-Archive "C:\CrushFTP\CrushFTP9.zip" -DestinationPath "C:\CrushFTP" -Force

# Download and unzip lets-encrypt to serve the user HTTPS
Invoke-WebRequest -Uri "https://github.com/win-acme/win-acme/releases/download/v2.2.9.1701/win-acme.v2.2.9.1701.x64.trimmed.zip" -OutFile "C:\CrushFTP\win-acme.zip"
Expand-Archive "C:\CrushFTP\win-acme.zip" -DestinationPath "C:\CrushFTP\win-acme" -Force


# Run CrushFTP
java -jar 'C:\CrushFTP\CrushFTP9\CrushFTP.jar' -d

# @TODO Create admin user CrushFTP API USER using their API INSTEAD OF USING RDB

# @TODO automate letsencrypt INSTEAD OF RDB
