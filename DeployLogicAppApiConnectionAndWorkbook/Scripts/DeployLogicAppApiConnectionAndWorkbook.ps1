[CmdletBinding()]
Param
(
    [String]
    $KeyVaultResourceId,
    [String]
    $LogicAppLookupSecretName,
    [String]
    $APIConnectionSecretName,
    [String]
    $APIConnectionClientId,
    [String]
    $APIConnectionTenantId,
    [String]
    $DisplayNamePrefix,
    [String]
    $TemplateFilePath,
    [string]
    $ResourceGroupName,
    [string]
    $TemplateFilePath 
)

## Get Key Vault Secret
Write-Host "Getting Secret from Key Vault"
$KeyVault = Get-AzResource -ResourceId $KeyVaultResourceId
$SecretValue = Get-AzKeyVaultSecret -VaultName $KeyVault.name -Name $APIConnectionSecretName

# Build ParametersObject
Write-Host "Building Parameters objec"

$TemplateParameterObject = @{
    keyVaultResourceId = $KeyVaultResourceId
    logicAppLookupSecretName = $LogicAppLookupSecretName
    aPIConnectionSecret = $SecretValue.SecretValue
    aPIConnectionClientId = $APIConnectionClientId
    aPIConnectionTenantId = $APIConnectionTenantId
    displayNamePrefix = $DisplayNamePrefix
}

# Build Deployment Name
$DateString = Get-Date -Format "yyyyMMdd_hhmmss"
$DeploymentName = "DeployLogicAppApiConnectionAndWorkbook_$DateString"

Write-Host "Deploying Template"
New-AzResourceGroupDeployment `
    -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateUri $TemplateFilePath `
    -TemplateParameterObject $TemplateParameterObject

    Write-Host ($TemplateParameterObject | ConvertTo-Json -Depth 5)
