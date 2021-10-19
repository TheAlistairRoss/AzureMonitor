# PowerShell Script

This script is an example script to deploy the ARM templates. See the below example of the powershell script to deploy. Ensure you are signed in to the correct tenant using

 ```powershell
Connect-AzAccount
```

```powershell
.\DeployLogicAppApiConnectionAndWorkbook.ps1 `
    -KeyVaultResourceId "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.KeyVault/vaults/{keyVaultName}" `
    -LogicAppLookupSecretName "Secret001" `
    -APIConnectionSecretName "Secret002" `
    -APIConnectionClientId "00000000-0000-0000-0000-000000000000" `
    -APIConnectionTenantId "00000000-0000-0000-0000-000000000000" `
    -DisplayNamePrefix "Contoso" `
    -TemplateFilePath "https://raw.githubusercontent.com/TheAlistairRoss/AzureMonitor/main/DeployLogicAppApiConnectionAndWorkbook/Template/template.json"

```
