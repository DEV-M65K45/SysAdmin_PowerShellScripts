<#
.Synopsis
   Deletes files (file type and age defined by user) from a Windows machine
.DESCRIPTION
   Deletes files (file type and age defined by user) from a Windows machine
.PARAMETER $targetFolder
    Location directory that you would like to delete files from
.PARAMETER $daysOlderThan
    Maximum file age that you would like to keep in number of days.  (7 - would delete any files older than 7 days old)
.PARAMETER $fileType
    File type that you would like to delete (examples:  *.log, *.*, etc.)
.OUTPUTS
   N/A
.EXAMPLE
   DeleteFiles "C:\inetpub\logs\LogFiles" 30 "*.log"
.EXAMPLE
   $ExchangeLogs="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"
   DeleteFiles $ExchangeLogs 30, "*.etl"
.NOTES
   Originally created to be run on Exchange directories below, but adapted for all files/directories so make tool more versatile
   \inetpub\logs\LogFiles\
   \Program Files\Microsoft\Exchange Server\V15\Logging\
   \Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\ETLTraces\
   \Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs

    NAME:    WINDOWS-DeleteFiles.ps1
    AUTHOR:    Lassalle
    DATE:    2024/2/18
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Deletes files defined by user
#>




Function DeleteFiles($targetFolder, $daysOlderThan, $fileType)
{
  write-host -debug -ForegroundColor Yellow -BackgroundColor Cyan $targetFolder

   if (Test-Path $targetFolder) {
        $now = Get-Date
        $lastWrite = $now.AddDays(-$daysOlderThan)
        $files=Get-ChildItem $targetFolder -Include $fileType -Recurse |  Where-Object {-not $_.PSIsContainer}  | Where-Object {$_.lastwritetime -le $lastWrite}
        foreach ($file in $files)
            {
               $fullFileName = $file.FullName  
               Write-Host "Deleting file $fullFileName" -ForegroundColor "yellow"; 
               Remove-Item $FullFileName -Force -ErrorAction SilentlyContinue | out-null  
            }
       }
   Else {
    Write-Host "The folder $targetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}