<#
.Synopsis
   Creates CSV file listing all empty Active Directory Groups
.DESCRIPTION
   Creates CSV file listing all empty Active Directory Groups
.PARAMETER $emptyGroups
   Location of CSV file that will be created.
.OUTPUTS
   CSV file will be created containing a list of all empty Active Directory Groups
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Change value of $emptyGroups variable to point to a location of your choosing, then run script as is listed below.

    NAME:    AD-DisplayEmptyGroups.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Creates CSV file listing all empty Active Directory Groups
#>


Import-Module activedirectory

$emptyGroups = "C:\temp\emptygroups.csv"
Get-ADGroup -Filter * -Properties Members | Where-Object {-not $_.members} | Select-Object Name | Export-Csv $emptyGroups –NoTypeInformation
