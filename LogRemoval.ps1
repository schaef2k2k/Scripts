# PowerShell script to Delete Mail Logs older than X days
#
# Author: Jason.schaefer@drakesoftware.com
# Author: Jay Owen <cmykflutterby@gmail.com>
#
# Version: 1.0 May 2018 tested on Powershell v5.1
#
# Usage: 
#
# Delete IMAP, LS, MTA, POP, SF and SMTP logs older than X days in directory 'c:\Program Files (x86)\Mail Enable\Logging\'.
#

# Sets directories to search (c:\<mydirectory>\), text patterns to search for (Regex = .*(<pattern1>|<pattern2>).*<fileExtension>$) 
# and number of days back to search for each log type (30).
$hashTable = @{
    "c:\Program Files (x86)\Mail Enable\Logging\.*.log" = 30
}

$keyArray = $hashTable.keys
foreach ($key in $keyArray)
{
    # grabs the value, value should be number of days
    $value = $hashTable[$key]

    # looks at the key string and takes the path and set it to folder
    $folder = Split-Path -Path $key

    # looks at the "leaf" or "filename" and set it as the pattern
    $pattern = Split-Path -Path $key -Leaf

    # Sets the number of days to look back for logs
    $DatetoDelete = (get-date).AddDays($value * -1)

    # Gets the log files and deletes them
    $files = get-childitem $folder -Recurse | where {$_.Name -imatch $pattern} | where { $_.LastWriteTime -lt $DatetoDelete } | Remove-item -Force
}
