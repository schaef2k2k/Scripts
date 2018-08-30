# With Hash Table
$hashTable = @{
    "C:\test\.*(smtp|pop).*log$" = 1
    "C:\smtplogs\.*(smtp|pop).*log$" = 1
    "C:\poplogs\.*(smtp|pop).*log$" = 1
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

    $files
}



# With arrays
$config = @(
    @("C:\test\","pattern",10),
    @("C:\pop\","pattern",30),
    @("C:\tmp\","pattern",40)
)

foreach ($x in $config)
{
    $path = $x[0]
    $pattern = $x[1]
    $days = $x[2]

    write-host "in $path, look at $pattern, delete older than $days"
}