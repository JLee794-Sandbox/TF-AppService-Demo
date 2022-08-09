# App Service Demo

## Table of Contents

- [App Service Demo](#app-service-demo)
  - [Table of Contents](#table-of-contents)
  - [Pre-requisites](#pre-requisites)
  - [:rocket: Getting started](#rocket-getting-started)
    - [Setting up your environment](#setting-up-your-environment)
      - [Configure Terraform](#configure-terraform)
      - [Configure Remote Storage Account](#configure-remote-storage-account)
    - [Deploy the Terraform Configuration](#deploy-the-terraform-configuration)
      - [Configure Terraform Remote State](#configure-terraform-remote-state)
        - [Backend Attribute Descriptions:](#backend-attribute-descriptions)
      - [Provide Parameters Required for Deployment](#provide-parameters-required-for-deployment)
      - [Deploy](#deploy)
- [Terraform Solution Overview](#terraform-solution-overview)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Modules](#modules)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)

## Pre-requisites

1. [Terraform](#configure-terraform)
1. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
1. Azure Subscription

## :rocket: Getting started

### Setting up your environment

#### Configure Terraform

If you haven't already done so, configure Terraform using one of the following options:

* [Configure Terraform in Azure Cloud Shell with Bash](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash)
* [Configure Terraform in Azure Cloud Shell with PowerShell](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-powershell)
* [Configure Terraform in Windows with Bash](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash)
* [Configure Terraform in Windows with PowerShell](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-windows-powershell)

#### Configure Remote Storage Account

Before you use Azure Storage as a backend, you must create a storage account.
Run the following commands or configuration to create an Azure storage account and container:

Powershell

```powershell

$RESOURCE_GROUP_NAME='tfstate'
$STORAGE_ACCOUNT_NAME="tfstate$(Get-Random)"
$CONTAINER_NAME='tfstate'

# Create resource group
New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location eastus

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location eastus -AllowBlobPublicAccess $true

# Create blob container
New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context -Permission blob

```

For additional reading around remote state:

* [MS Doc | Store Terraform state in Azure Storage](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
* [TF Doc | AzureRM Provider Configuration Documentation](https://www.terraform.io/language/settings/backends/azurerm)

### Deploy the Terraform Configuration

#### Configure Terraform Remote State

To configure your Terraform deployment to use the newly provisioned storage account and container, edit the [`./version.tf`](./version.tf) file at lines 9-14 as below:

```hcl
  backend "azurerm" {
    resource_group_name  = "my-rg-name"
    storage_account_name = "mystorageaccountname"
    container_name       = "tfstate"
    key                  = "myapp/terraform.tfstate"
  }
```

##### Backend Attribute Descriptions:

* `resource_group_name`: Name of the Azure Resource Group that the storage account resides in.
* `storage_account_name`: Name of the Azure Storage Account to be used to hold remote state.
* `container_name`: Name of the Azure Storage Account Blob Container to store remote state.
* `key`: Path and filename for the remote state file to be placed in the Storage Account Container. If the state file does not exist in this path, Terraform will automatically generate one for you.

#### Provide Parameters Required for Deployment

As you configured the backend remote state with your live Azure infrastructure resource values, you must also provide them for your deployment.

1. Review the available variables with their descriptions and default values in the [variables.tf](./variables.tf) file.
2. Provide any custom values to the defined variables by creating a `terraform.tfvars` file in this directory (`terraform.tfvars`)
    * [TF Docs: Variable Definitions (.tfvars) Files](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files)

#### Deploy

1. Navicate to this project's root directory, where all the main `*.tf` configuration files are placed.
2. Initialize Terraform to install `required_providers` specified within the `version.tf` and to initialize the backend remote state
    * to run locally without the remote state, comment out the `backend "azurerm"` block in `version.tf` (lines 8-13)

    ```bash
    terraform init
    ```

3. See the planned Terraform deployment and verify resource values

    ```bash
    terraform plan
    ```

4. Deploy

    ```bash
    terraform apply
    ```

# Terraform Solution Overview

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app-rg"></a> [app-rg](#module\_app-rg) | ./Modules/azurerm-resourcegroup | n/a |
| <a name="module_appservice-plan"></a> [appservice-plan](#module\_appservice-plan) | ./Modules/azurerm-appservice-plan | n/a |
| <a name="module_azurecaf-app"></a> [azurecaf-app](#module\_azurecaf-app) | ./Modules/azurecaf-naming | n/a |
| <a name="module_azurerm_key_vault"></a> [azurerm\_key\_vault](#module\_azurerm\_key\_vault) | ./Modules/azurerm-key-vault | n/a |
| <a name="module_azurerm_storage"></a> [azurerm\_storage](#module\_azurerm\_storage) | ./Modules/azurerm-storage | n/a |
| <a name="module_linux-webapp"></a> [linux-webapp](#module\_linux-webapp) | ./Modules/azurerm-appservice-linux-webapp | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_configuration_features"></a> [app\_configuration\_features](#input\_app\_configuration\_features) | (Optional) Mapping of app configuration features | `map(any)` | `{}` | no |
| <a name="input_app_configuration_keys"></a> [app\_configuration\_keys](#input\_app\_configuration\_keys) | (Optional) Mapping of app configuration keys | `map(any)` | `{}` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | (Required) Product/Application name which will be appended as a suffix. | `string` | n/a | yes |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | (Required) Short country code to use for the name (eg. eu for europe, na for north america) | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | (Required) Numerical representation of the environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) location - example: South Central US = southcentralus | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) Email or ID of the owner for the resource. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Optional) Prefix to set for the resource names. Defaults to 'az'. | `string` | `"az"` | no |
| <a name="input_storage_account_contributors"></a> [storage\_account\_contributors](#input\_storage\_account\_contributors) | List of AD Group display names to assign as Contributor to the storage account. | `list(string)` | `[]` | no |
| <a name="input_storage_account_readers"></a> [storage\_account\_readers](#input\_storage\_account\_readers) | List of AD Group display names to assign as Reader to the storage account. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Additional tags to apply to the resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app-rg"></a> [app-rg](#output\_app-rg) | Application Layer Outputs --------------------------------------------------------- |
| <a name="output_appservice-plan"></a> [appservice-plan](#output\_appservice-plan) | n/a |
| <a name="output_azurecaf-naming-objects"></a> [azurecaf-naming-objects](#output\_azurecaf-naming-objects) | n/a |
| <a name="output_azurerm_storage"></a> [azurerm\_storage](#output\_azurerm\_storage) | n/a |
| <a name="output_kv"></a> [kv](#output\_kv) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->