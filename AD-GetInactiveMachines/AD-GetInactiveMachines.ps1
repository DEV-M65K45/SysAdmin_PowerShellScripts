<#
.Synopsis
   Gets time stamps for all computers in the domain that have NOT logged in since after specified date
.DESCRIPTION
   Gets time stamps for all computers in the domain that have NOT logged in since after specified date
.PARAMETER $exportfile
   Location of CSV file that will be created.
.PARAMETER $domain
   Target Domain
.PARAMETER $DaysInactive
   Find machines that have been inactive for longer than this number of days.
.PARAMETER $SearchLoc
   OU to search
.OUTPUTS
   CSV file will be created containing a list of all empty Active Directory Groups
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Change value of $emptyGroups variable to point to a location of your choosing, then run script as is listed below.

    NAME:    AD-GetInactiveMachines.ps1
    AUTHOR:    Mod by Tilo 2013-08-27
    DATE:    2024/9/06
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Creates CSV file listing all computers inactive for longer than the specified days
#>



import-module activedirectory 

$exportfile = "C:\Temp\InactivePC.csv"
$domain = "target.domain" 
$DaysInactive = 30 
$time = (Get-Date).Adddays(-($DaysInactive))
$SearchLoc = "OU=xxxx,OU=xxxx,OU=xxxx,OU=xxxx,DC=xxxxx,DC=xxxxx"


# Get all AD computers with lastLogonTimestamp less than our time
Get-ADComputer -searchbase "$SearchLoc" -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | Out-GridView


# Output hostname and lastLogonTimestamp into CSV
select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv $exportfile -notypeinformation 
