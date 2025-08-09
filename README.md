
# GOAL

This repository provides a solution to automate and deploy crushftp into Azure Windows Virtual Machine.\
Two users will be created in crushftp to transfter files between them.\
John will have access on the server over RDP and ssh for file transfer while Bob will only have ssh for the file transfers. \
Allow bob and john to access server from their ips but it's just assigned to your ip for now but you can change ips as needed. \
The two users will be able to access the crushftp over https. \

🌐 Deploys a secure Windows VM in Azure \
🔐 Uses Managed Identity to securely access Azure Blob Storage \
📦 Downloads a PowerShell script from private storage via az storage blob download \
📦 PowerShell script then Downloads letencrypt \
🛠️ Runs the script automatically using the Custom Script Extension 


### Prerequisites

* Azure CLI installed (az)
* Bicep CLI (or Azure CLI version with Bicep support)
* Logged into Azure via az login
* Appropriate permissions to deploy resources (Contributor role)

### Running the script 
./script.ps1

### Notes
to serve crushftp over https for the domainlabel that azure generated you need to:
* login to the server with the admin credentials you created in the script
* letsencrypt is already installed in the vm by the previous scripts
* generate certificate and take note where you saved the cerficate file
<img width="634" height="415" alt="Screenshot 2025-08-05 at 9 32 29 PM" src="https://github.com/user-attachments/assets/df5f3507-2980-47f9-a861-53068f21a246" />
<img width="686" height="402" alt="Screenshot 2025-08-05 at 9 32 45 PM" src="https://github.com/user-attachments/assets/6a8f5b83-54fa-4f0e-8415-f6ce9c6eb961" />

* start the crushftp server navigating to C:\CrushFTP\CrushFTP9\CrushFTP.exe and create admin user 
<img width="1094" height="571" alt="Screenshot 2025-08-05 at 9 37 42 PM" src="https://github.com/user-attachments/assets/74984a7d-8873-457c-bcf9-202f25af33f8" />

* login with the admin user credentials usually the server starts 127.0.0.1:8080 and navigate to admin 
* find from preferences find https:443 service and click on advanced tab and choose Keystore Location that you created earlier
<img width="1565" height="683" alt="Screenshot 2025-08-05 at 9 42 23 PM" src="https://github.com/user-attachments/assets/506a9d58-4695-4d83-9746-2077aaab82e5" />

* can test it by clicking test certificate if successful you should be able to reach the server https://{your_domain}


### Recommendations
This is simple and cost effective setup for my assessment but it might be better idea that you use azure bastion to reduce the attack service of your infrastructure.
### Recommendations
This is simple and cost effective setup for my assessment but it might be better idea that you use azure bastion to reduce the attack service of your infrastructure.

