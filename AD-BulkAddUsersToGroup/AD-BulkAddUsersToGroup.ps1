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
    ADDUsersToGroup "C:\Temp\userlist.csv" "Example AD Group"
    This will Add all users in the userlist.csv file to the Active Diretory Group named "Example AD Group"
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


Function ADDUsersToGroup($userList, $ADGroup)
{
    Import-Module ActiveDirectory 
    Import-Csv -Path $userList | ForEach-Object {Add-ADGroupMember -Identity $ADGroup -Members $_.’User-Name’}
    
}