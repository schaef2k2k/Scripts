ForEach ($instance in Get-Content "C:\scripts\SQLInstances.txt")
{
     [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
     $s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $instance
     $dbs=$s.Databases
     $dbs | select Parent, Name, RecoveryModel, ReadOnly, Status, LastBackupDate |
     Export-Csv -Append -Path c:\temp\SQLDBInfo.csv 
}
 