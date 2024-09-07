<#
.Synopsis
   Displays table of top 20 services, with CPU Time used
.DESCRIPTION
   Displays table of top 20 services, with CPU Time used
.OUTPUTS
   N/A
.EXAMPLE
   Script should be run as is listed below.
.NOTES
   Displays table of top 20 services, with CPU Time used

    NAME:    CITRIX-VDI_Seal_Image.ps1
    AUTHOR:    Lassalle
    DATE:    2024/09/07
    WWW:    
    GITHUB: https://github.com/DEV-M65K45

    VERSION HISTORY:
    2024.1
        Initial Version
.FUNCTIONALITY
   Displays table of top 20 services, with CPU Time used
#>




Get-Counter '\Process(*)\% Processor Time' | Select-Object -ExpandProperty countersamples | Select-Object -Property instancename, cookedvalue| Sort-Object -Property cookedvalue -Descending| Select-Object -First 20| ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100).toString('P')}} -AutoSize
