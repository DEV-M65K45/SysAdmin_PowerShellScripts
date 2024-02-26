<#
.SYNOPSIS
    Gets all email alias and saves then to a csv file for manipulation/searching.
.DESCRIPTION
    This powershell command gets all email alias' in the domain and puts them in a csv file for manipulation/searching/etc. 
.PARAMETER N/A
    No parameters needed
.EXAMPLE
    Run command as is listed below.
.NOTES
    NAME:    EXCHANGE-ShowEmailAlias.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/26
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
#>


$csvFile = "C:\temp\aliaslist.csv"
Get-Mailbox | Select-Object DisplayName,@{Name=”EmailAddresses”;Expression={$_.EmailAddresses |Where-Object {$_ -LIKE “SMTP:*”}}} | Sort | Export-Csv $csvFile