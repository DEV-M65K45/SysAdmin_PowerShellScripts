<#
.Synopsis
   Deletes files (file type and age defined by user) from a Windows machine
.DESCRIPTION
   Long description
.EXAMPLE
   DeleteFiles "C:\inetpub\logs\LogFiles" 30 "*.log"
.EXAMPLE
   $ExchangeLogs="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"
   DeleteFiles $ExchangeLogs 30, "*.etl"
.INPUTS
   $targetFolder=Directory containing the files to be deleted
   $daysOlderThan=Any files older than x days will be deleted.
   $fileType=File extension, or other name parameters, that will be deleted
.OUTPUTS
   N/A
.NOTES
   Originally created to be run on Exchange directories below, but adapted for all files/directories so make tool more versatile
   \inetpub\logs\LogFiles\
   \Program Files\Microsoft\Exchange Server\V15\Logging\
   \Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\ETLTraces\
   \Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
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