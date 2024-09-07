<#
.SYNOPSIS
    Bulk remove user list from Active Directory Group
.DESCRIPTION
    Remove a csv list of users from an Active Directory Group
.PARAMETER $userList
    Location of CSV file (including csv file)
.PARAMETER $ADGroup
    Active Directory Group that users should be removed from.
.EXAMPLE
    Script should be run as is listed below.
.NOTES
    NAME:    AD-BulkRemoveUsersFromGroup.ps1
    AUTHOR:    Lassalle
    DATE:    2024/02/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1 
        Initial Version
#>


Import-Module ActiveDirectory 

$userList = "C:\Temp\userlist.csv"
$ADGroup = "ExampleADGroup"
    
Import-Csv -Path $userList | ForEach-Object {Remove-ADGroupMember -Identity $ADGroup -Members $_.’User-Name’ -Confirm:$false}
