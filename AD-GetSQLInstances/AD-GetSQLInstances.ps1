
<#
.Synopsis
   Searches all machines in filter, checks for SQL Instances and writes results to a file.
.DESCRIPTION
   Searches all machines in filter, checks for SQL Instances and writes results to a file.
.PARAMETER $results
   Location of CSV file that will be created.
.OUTPUTS
   CSV file will be created containing a list of all SQL Instances
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Change value of $emptyGroups variable to point to a location of your choosing, then run script as is listed below.

    NAME:    AD-GetSQLInstances.ps1
    AUTHOR:    Mod by Lassalle 2014-09-22
    DATE:    2024/9/22
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Searches all machines in filter, checks for SQL Instances and writes results to a file.
#>



import-module activedirectory 

$results = "C:\Temp\SQL.csv"
Get-ADComputer -Filter {OperatingSystem -like "*windows*server*"} | Find-DbaInstance | select *| Export-CSV -Delimiter '`t' -Path $results