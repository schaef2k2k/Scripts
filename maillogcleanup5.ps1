#
# Maillog Clean Up
#
# Author: Jason Schaefer <jason.schaefer@drakesoftware.com>
#
# Version: 1.0 May 2018 tested on Powershell v5.1
#
function Show-Menu
{
     param (
           [string]$Title = 'Mail Logs to Clear'
     )
     Write-Host "================ $Title ================"
    
     Write-Host "Delete logs from Mail Relays? press 'y' to confirm, press 'q' to quit "
}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           'y' {
                'Cleaning Logs from c:\test'
                    # Path you want to clear logs from
                    $Path = "c:\test"

                    # How many days of logs to keep for smtp(14days = -14)
                    $DaysbackSMTP = "-0"
                     
                     # How many days of logs to keep for xxx(14days = -14)
                    $Daysbackxxx = "-0" 

                    # Delete all smtp Log Files older than X day(s)
                    $CurrentDate = Get-Date
                    $DatetoDeleteSMTP = $CurrentDate.AddDays($DaysbackSMTP)

                    # Delete all xxx Log Files older than X day(s)
                    $CurrentDate = Get-Date
                    $DatetoDeletexxx = $CurrentDate.AddDays($Daysbackxxx)

                    Write-Host "($DatetoDeleteSMTP.Count) files deleted"
                    Get-ChildItem "$Path" | Where-Object { $_.LastWriteTime -lt $DatetoDeleteSMTP } | where {$_.Name -match "smtp.*\.log$"} | Remove-item -Force
                    Get-ChildItem "$Path" | Where-Object { $_.LastWriteTime -lt $DatetoDeletexxx } | where {$_.Name -match "xxx.*\.log$"} | Remove-item -Force

           } 'q' {
                return
           }
     }
}
until ($input -eq 'q')