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
    RemoveUsersFromGroup "C:\Temp\userlist.csv" "Example AD Group"
    This will remove all users in the userlist.csv file from the Active Diretory Group named "Example AD Group"
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


Function RemoveUsersFromGroup($userList, $ADGroup)
{
    Import-Module ActiveDirectory 
    Import-Csv -Path $userList | ForEach-Object {Remove-ADGroupMember -Identity $ADGroup -Members $_.’User-Name’ -Confirm:$false}
    
}
