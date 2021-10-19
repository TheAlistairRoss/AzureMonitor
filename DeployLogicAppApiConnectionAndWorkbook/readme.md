# Deploy Logic App, Api Connection and Workbook

## AIM
The aim of these ARM templates is to deploy the following resources

1. API Connection (Microsoft.Web/connections). This is used to store the credentials used by the Logic App
2. Logic App (Microsoft.Logic/workflows). This will be running a workflow when triggered within the workbook. This example retrieves a key from Key Vault
3. Azure Workbook (microsoft.insights/workbooks). This workbook requires a parameterised input in the form of the Logic App ResourceId to be able to execute ARM actions


## Prerequisites

1. Azure AD App Registration with a Client Secret https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app

2. Azure Key Vault
    
    - This will require

3. A Resource group to deploy the resources to. Does not have to be the same as the Key Vault

#### Pros
- Requires the secret to be passed to the template deployment at run time
- Ideal for CI/CD Pipelines which will look the value up and pass the parameter at time of deployment

#### Con
- Requires lookup of the secure string prior to deployment. 
- If deploying manually, the user will need access to the secret to paste in.
- 

## Deploy

Ensure you have the following parameters:

- keyVaultResourceId
- logicAppLookupSecretName - This is the secret that the Logic App will look up. For Testing create a secret with any text as the value
- apiConnectionSecret - This is the App Registration Secret
- apiConnectionClientId - This is the App Registration Client Id
- apiConnectionTenantId - This is the tenant Id hosting the App Registration
- displayNamePrefix - a Prefix for all the resources deployed

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https%3A%2F%2Fraw.githubusercontent.com%2FTheAlistairRoss%2FAzureMonitor%2Fmain%2FDeployLogicAppApiConnectionAndWorkbook%2FPassSecretAsSecureString%2Ftemplate.json
)