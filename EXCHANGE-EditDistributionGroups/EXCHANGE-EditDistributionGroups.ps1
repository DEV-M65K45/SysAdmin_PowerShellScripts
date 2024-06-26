<#
.SYNOPSIS
    Changing settings within distribution group(s)
.DESCRIPTION
    This powershell command list shows examples of looking at Exchange distribution group settings and setting them on an individual and bulk basis.
.PARAMETER N/A
    No parameters needed
.EXAMPLE
    Run command(s) as listed below.
.NOTES
    NAME:    EXCHANGE-EditDistributionGroupSettings.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/26
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
#>


#look at all settings on a dynamic distribution group
$groupName = TestGroup@domain.com   
Get-DynamicDistributionGroup -Identity $groupName | Format-List

#look at specific settings on a dynamic distribution group.  Choose from results of list above.  "-RequireSenderAuthenticatedEnabled" is only an example
$groupName = TestGroup@domain.com    
Get-DynamicDistributionGroup -Identity $groupName | Select-Object RequireSenderAuthenticationEnabled

#set settings on a dynamic distribution group.  Choose from results of list above.  "-RequireSenderAuthenticatedEnabled" is only an example.
$groupName = TestGroup@domain.com    
Set-DynamicDistributionGroup -Identity $groupName -RequireSenderAuthenticationEnabled $false

#bulk edit distribution groups.  Choose from results of list above.  "-RequireSenderAuthenticatedEnabled" is only an example.
$groupName = TestGroup@domain.com 
#csv file containing list of distribution groups to edit.
$csvFile = "C:\temp\csvfile.csv"
Get-Content $csvFile | Set-DynamicDistributionGroup -RequireSenderAuthenticationEnabled $false
