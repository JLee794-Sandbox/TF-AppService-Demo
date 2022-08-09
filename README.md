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
  - [Terraform Overview](#terraform-overview)

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

## Terraform Overview

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->