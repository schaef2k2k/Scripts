#
# Automated Task Wrapper
# Wraps a PS script for windows task scheduler and logs output.
#
# Author: Jay Owen <cmykflutterby@gmail.com>
#
# Version: 1.0 February 2018 tested on Powershell v5.0
#

# Path you want logs to be in
$Path = "C:\scripts\LogRemoval"

# Script to execute
$Job = "C:\scripts\LogRemoval\LogRemoval.ps1"

# How many days of logs to keep (14days = -14)
$Daysback = "-30" 


# Delete all Log Files older than X day(s)
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
If(!(test-path "$Path\logs"))
{
    # create report folder, suppress folder creation output
    New-Item -ItemType Directory -Force -Path "$Path\logs" | Out-Null
}
else 
{
    Get-ChildItem "$Path\logs" | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | where {$_.Name -match ".log"} | Remove-item -Force
}

# Run Job
$datestamp = $(get-date -f yyyyMMdd_HHmmss);
$Job = $Job+ ' *> "$Path\logs\job_$datestamp.log"'
Invoke-Expression $Job 