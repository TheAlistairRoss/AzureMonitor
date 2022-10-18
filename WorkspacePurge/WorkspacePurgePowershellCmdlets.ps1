# # Azure Log Analytics workspace purge via PowerShell using Invoke-WebRequest
# https://learn.microsoft.com/en-us/azure/azure-monitor/logs/personal-data-mgmt#exporting-and-deleting-personal-data

#Constants
    $WorkspaceSubscriptionId = "00000000-0000-0000-0000-000000000000"
    $WorkspaceResourceGroupName = "resourceGroupName"
    $WorkspaceName = "workspaceName"

    
    Connect-AzAccount

    Set-AzContext -Subscription $WorkspaceSubscriptionId

# Purge Request
# https://learn.microsoft.com/en-us/powershell/module/az.operationalinsights/new-azoperationalinsightspurgeworkspace?view=azps-8.3.0

    $Params =@{
        Table  = "Heartbeat"
        Column = "TimeGenerated"
        OperatorProperty = "between"
        Value = @('2022-10-07T12:00:00','2022-10-07T12:30:00')
    }

    $PurgeRequest = New-AzOperationalInsightsPurgeWorkspace `
        -ResourceGroupName $WorkspaceResourceGroupName `
        -WorkspaceName $WorkspaceName `
        @Params


# Purge Status
# https://learn.microsoft.com/en-us/powershell/module/az.operationalinsights/get-azoperationalinsightspurgeworkspacestatus?view=azps-8.3.0
    Get-AzOperationalInsightsPurgeWorkspaceStatus `
        -ResourceGroupName $WorkspaceResourceGroupName `
        -WorkspaceName $WorkspaceName`
        -PurgeId $PurgeRequest.OperationId
