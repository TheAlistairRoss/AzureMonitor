# Azure Log Analytics workspace purge via PowerShell using Invoke-WebRequest
# https://learn.microsoft.com/en-us/azure/azure-monitor/logs/personal-data-mgmt#exporting-and-deleting-personal-data

# Constants - Change these to reflect your environment
    $SentinelWorkspaceResourceId = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroupName/providers/Microsoft.OperationalInsights/workspaces/workspaceName"

    $AppRegistrationClientId = "00000000-0000-0000-0000-000000000000"
    $AppRegistrationTenantId = "00000000-0000-0000-0000-000000000000"
    $AppRegistrationSecret = "00000000000000000000000000000"


# Authentication Token
# https://learn.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge?tabs=HTTP
    $Scope = "https://management.azure.com/"

    $Uri = "https://login.microsoftonline.com/$AppRegistrationTenantId/oauth2/token?api-version=2020-06-01";
    $Body = @{ 
        grant_type    = 'client_credentials'; 
        resource      = $Scope; 
        client_id     = $AppRegistrationClientId; 
        client_secret = $AppRegistrationSecret
    }

    $token = Invoke-RestMethod -Method Post -Uri $Uri -Body $Body


# Purge
# https://learn.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge?tabs=HTTP

    $Uri = "https://management.azure.com" + $SentinelWorkspaceResourceId + "/purge?api-version=2020-08-01"

    $Headers = @{
        authorization = "$($token.token_type) $($token.access_token)"
        ContentType   = "application/json"
    }

    $Body = @{
        table   = 'Heartbeat'
        filters = @(
            @{
                column   = 'TimeGenerated'
                operator = 'between'
                value    = @('2022-10-07T13:00:00','2022-10-07T13:10:00')
            }
        )
    } | ConvertTo-Json -Depth 3 

    $PurgeRequests = Invoke-WebRequest -Method Post -Uri $Uri -Headers $Headers -Body $Body



# Purge Status
# https://learn.microsoft.com/en-us/rest/api/loganalytics/workspace-purge/purge?tabs=HTTP

    $Headers = @{
        authorization = "$($token.token_type) $($token.access_token)"
        ContentType   = "application/json"
    }

    $PurgeIdUri = ($PurgeRequests.RawContent.Split("`n") | where {$_.StartsWith("x-ms-status-location:")}).TrimStart("x-ms-status-location: ")
    Invoke-WebRequest -Method Get -Uri $PurgeIdUri -Headers $Headers
