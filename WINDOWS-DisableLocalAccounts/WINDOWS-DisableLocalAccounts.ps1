<#
.SYNOPSIS
    Disable all local accounts on the PC.
.DESCRIPTION
    This script gets all local accounts present on the PC and disables them.  This script should only be run on a PC that is domain attached.  
	***Be cautious when running so that users are not locked out of the PC.***
.PARAMETER N/A
    No parameters needed
.EXAMPLE
    Run script as is listed below.
.NOTES
    NAME:    WINDOWS-DisableLocalAccounts.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
#>


$AllLocalAccounts = Get-WmiObject -Class Win32_UserAccount -Namespace "root\cimv2" -Filter "LocalAccount='$True'"  -ErrorAction Stop

Foreach($LocalAccount in $AllLocalAccounts)
	{
		Disable-LocalUser $LocalAccount.Name
	}
