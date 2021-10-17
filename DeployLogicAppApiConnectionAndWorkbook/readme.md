# Deploy Logic App, Api Connection and Workbook

## AIM
The aim of these ARM templates is to deploy the following resources

1. API Connection (Microsoft.Web/connections). This is used to store the credentials used by the Logic App
2. Logic App (Microsoft.Logic/workflows). This will be running a workflow when triggered within the workbook. This example retrieves a key from Key Vault
3. Azure Workbook (microsoft.insights/workbooks). This workbook requires a parameterised input in the form of the Logic App ResourceId to be able to execute ARM actions


## Prerequisites

1. Azure AD App Registration with a Client Secret https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app

2. Azure Key Vault
    
    - If using the NestedTemplateForSecret Example, then ensure the Key Vault is enabled for ARM Template deployments and store the Secret that will be used by the API Connection in the Key Vault

    - If using the PassSecretAsSecureString, only additional secrets are required to be stored.

3. A Resource group to deploy the resources to. Does not have to be the same as the Key Vault


## Pros and Cons

### **NestedTemplateForSecret**

#### Pros
- Does not require knowledge of the secret value beforehand as it will look it up from Key Vault

#### Cons
- Nested Deployment will return the value in plain text, so secure the ability to read deployments


### **PassSecretAsSecureString**

#### Pros
- Requires the secret to be passed to the template deployment at run time
- Ideal for CI/CD Pipelines which will look the value up and pass the parameter at time of deployment

#### Con
- Requires lookup of the secure string prior to deployment. 
- If deploying manually, the user will need access to the secret to paste in.