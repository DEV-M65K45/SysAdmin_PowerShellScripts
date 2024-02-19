<#
.Synopsis
   Updates the virus definitions on all PC's listed in the csv file from a network share, then checks date of last update and displays.
.DESCRIPTION
   Updates the virus definitions on all PC's listed in the csv file from a network share, then checks date of last update and displays.
.PARAMETER $csvPath
    Location of csv file that contains PC list
.PARAMETER $definitionFull
    Location of full virus definitions
.PARAMETER $definitionPartial
    Location of incremental virus definitions
.OUTPUTS
   N/A
.EXAMPLE
   UpdateDefinitions "C:\temp\pcs.csv" "\\FileShare1\mpam-fe.exe" "\\FileShare1\nis_full.exe"
.NOTES
   Ensure that csv file has a column header of "pcname"
   Manually download virus definitions from Microsoft and place them on a public file share that all PC's have access to prior to running the script.

    NAME:    DEFENDER-UpdateDefinitions.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Updates virus definitions on all PC's listed in the csv file from a public network share, then checks date of last update and displays.
#>


Function UpdateDefinitions($csvPath, $definitionFull, $definitionPartial)
{
    $pclist = Import-CSV -Path $csvPath
    $pcs = $pclist.pcname
    
    
    foreach ($pc in $pcs) {
        if (Test-Connection $pc -count 1 -quiet) {
            write-host $pc, "...Updating Defender definitions" -ForegroundColor Green
            Invoke-Command $pc -Scriptblock {
            $definitionPartial /q
            start-sleep 10
            $definitionFull /q
            start-sleep 5
            Get-MpComputerStatus | Select-Object AntivirusSignatureLastUpdated
            write-host $pc, " COMPLETE" -ForegroundColor Black -BackgroundColor Green
            }
        }
        else {
            write-host $pc, "UNAVAILABLE" -ForegroundColor Red -BackgroundColor Yellow}
        
    }
}
