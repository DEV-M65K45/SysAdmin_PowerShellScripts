<#
.SYNOPSIS
    Bulk add user list to Active Directory Group
.DESCRIPTION
    Add a csv list of users to an Active Directory Group
.PARAMETER $userList
    Location of CSV file (including csv file)
.PARAMETER $ADGroup
    Active Directory Group that users should be added to.
.EXAMPLE
    Script should be run as is listed below.
.NOTES
    NAME:    AD-BulkAddUsersToGroup.ps1
    AUTHOR:    Lassalle
    DATE:    2024/02/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1 
        Initial Version
#>

Import-Module ActiveDirectory 

$userList = "C:\Temp\userList.csv"
$ADGroup = "ExampleADGroup"

Import-Csv -Path $userList | ForEach-Object {Add-ADGroupMember -Identity $ADGroup -Members $_.’User-Name’}