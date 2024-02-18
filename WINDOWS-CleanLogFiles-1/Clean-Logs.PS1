#TEST

Function CleanLogfiles($targetFolder, $daysOlderThan, $fileType)
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