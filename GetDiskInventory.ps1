<#
.SYNOPSIS
Get-DiskInventory retreives logical disk information from one or more computers
.DESCRIPTION
Get-Inventory uses WMI to retreive the WIn32_LogicalDisk instances from
one or computers. It displays each disk's drive letter, free space,
total size and percentage of free space
#>
[CmdletBinding()]
param (
    [parameter(mandatory=$true,HelpMessage="Enter a ComputerName to query")]
    [Alias('hostname')]
    [string]$computername,
    [Validateset(1,2,3,4,5,6)]
    [int]$drivetype = 4
 )
Write-Verbose "Connecting to $computername"
Write-Verbose "Looking for drive type $DriveType"
Get-WmiObject -class Win32_LogicalDisk -computername $computername `
-filter "drivetype=$drivetype" | 
Sort-Object -Property DeviceID | 
Select-Object -Property DeviceID,
    @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
    @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
    @{label='%Free';expression={$_.FreeSpace / $_.SIze * 100 -as [int]}}
Write-Verbose "Finished running command"