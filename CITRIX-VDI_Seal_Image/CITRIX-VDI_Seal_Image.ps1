
<#
.Synopsis
   Runs actions needed before sealing up Citrix PVS Image
.DESCRIPTION
   Runs actions needed before sealing up Citrix PVS Image
.OUTPUTS
   N/A
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Stops/Clears System Center services/config & Clears event logs before shutting down for deployment.

    NAME:    CITRIX-VDI_Seal_Image.ps1
    AUTHOR:    Lassalle
    DATE:    2024/09/07
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Stops/Clears System Center services/config & Clears event logs before shutting down for deployment.
#>


#######Citrix VDI Base Image Cleanup#######
###Stop SMS Agent Host service
Stop-Service -Name CcmExec -Force
####Delete SMSCFG.Ini
Remove-Item -Path C:\Windows\SMSCFG.INI -Force
####Remove SMS Certs
Remove-Item -Path HKLM:\Software\Microsoft\SystemCertificates\SMS\Certificates\* -Force 
####Remove WMIC Inventory Action
Get-WmiObject -Namespace Root\CCM\Invagt -Class inventoryactionstatus | Where-Object {$_.InventoryActionID -eq '{00000000-0000-0000-0000-000000000001}'} | Remove-WmiObject


Write-Host " BEGIN Clear Selected Event Logs"-ForegroundColor Green
#Clear-EventLog "Application"
#Clear-EventLog "Security"
#Clear-EventLog "System"
wevtutil el | Foreach-Object {Write-Host "Clearing $_"; wevtutil cl "$_"}
Write-Host " END   Clear Selected Event Logs"-ForegroundColor Green
Write-Host ""-ForegroundColor Green
