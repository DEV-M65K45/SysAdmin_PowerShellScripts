<#
.Synopsis
   Checks the date/time the antivirus signatures were last updated on all pc's listed in CSV file and displays.
.DESCRIPTION
   Checks the date/time the antivirus signatures were last updated on all pc's listed in CSV file and displays.
.PARAMETER $csvPath
    Location of csv file that contains PC list
.OUTPUTS
   N/A
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Ensure that csv file has a column header of "pcname"

    NAME:    DEFENDER-CheckDefinitions.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Checks and displays last update time of virus definitions.
#>



$csvPath = "C:\Temp\pcs.csv"
$pclist = Import-CSV -Path $csvPath
$pcs = $pclist.pcname

foreach ($pc in $pcs) {
    if (Test-Connection $pc -count 1 -quiet) {
        write-host $pc, "...Checking Defender definitions" -ForegroundColor Green
        Invoke-Command $pc -Scriptblock {
        Get-MpComputerStatus | Select-Object AntivirusSignatureLastUpdated
          }
    }
    else {
        write-host $pc, "UNAVAILABLE" -ForegroundColor Red -BackgroundColor Yellow}
}
