$hashTable = @{
    "C:\test\.*(smtp|pop).*log$" = 0
    "C:\smtplogs\.*(smtp|pop).*log$" = 0
    "C:\poplogs\.*(smtp|pop).*log$" = 0
}

$keyArray = $hashTable.keys
foreach ($key in $keyArray)
{
    # grab value, value should be number of days
    $value = $hashTable[$key]

    # look at key string and take the path and set it to folder
    $folder = Split-Path -Path $key

    # look at the "leaf" or "filename" and set it as the pattern
    $pattern = Split-Path -Path $key -Leaf

    # Delete all smtp Log Files older than X day(s)
    $DatetoDelete = $CurrentDate.AddDays($value * -1)

    $files = get-childitem $folder | where {$_.Name -imatch $pattern} | where { $_.LastWriteTime -lt $DatetoDelete }   

   
}
