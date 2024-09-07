
<#
.Synopsis
   Searches Machines in filter and displays all certificates that will expire in the next designated amount of days
.DESCRIPTION
   Searches Machines in filter and displays all certificates that will expire in the next designated amount of days
.PARAMETER $cred
   Will prompt for credentials to be used to access machines.
.PARAMETER $machines
   Filter to be used to narrow down scope of machines.  If wanting to search all machines, use "-Filter *"
.PARAMETER $numberofdays
   Script will display all certificates that expire this many days in the future.
.OUTPUTS
   Table will display all certificates that are expireing within $numberofdays
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Change value of $numberofdays and $machine variables, then run script as is listed below.

    NAME:    WINDOWS-GetExpiringCertificates.ps1
    AUTHOR:    Lassalle
    DATE:    2024/9/06
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Creates CSV file listing all computers inactive for longer than the specified days
#>


#Prompt for credentials that will be utilized to access each machine
$cred = Get-Credential

#Filter machines based on your own parameters.  Adjust per your own requirements  Filter below is searching for all Windows Server OS's
$machines = Get-ADComputer -Filter "OperatingSystem -like 'Windows Server*'"

#Script will look for certificates that expire this many days in the future
$numberofdays = 60

#Used for calculating percentage of completion while running
$c = 0


$machines | foreach{
 $p = ($c++/$servers.count) * 100
 Write-Progress -Activity "Checking $_" -Status "$p % completed" -PercentComplete $p;
 if(Test-Connection -ComputerName $_.DNSHostName -Count 2 -Quiet){
    Invoke-Command -ComputerName $_.DNSHostName -Credential $cred `
    {dir Cert:\LocalMachine\my | ? NotAfter -lt (Get-Date).AddDays($numberdays)}
  }
}