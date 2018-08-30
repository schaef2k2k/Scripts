[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | Out-Null

$Servers = @(Get-Content -path 'C:\scripts\SQLInstances.txt')

foreach ($Server in $Servers)
{
    Get-SqlAgentJobHistory -ServerInstance $Server | 
    where {($_.RunStatus -eq '0') -and ($_.StepName -eq '(job outcome)') -and ($_.RunDate -gt (Get-Date).AddDays(-8))} |
    select Server,JobName,RunDate,RunStatus | 
    Sort-Object -Property RunDate -Descending | 
    Format-table
}
