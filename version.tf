terraform {
  required_providers {
    azurerm = {
      version = "3.4.0"
    }
  }

  # # TODO - Managed identity implementation once self-hosted agent is ready
  # backend "azurerm" {
  #   resource_group_name  = "bootstrap"
  #   storage_account_name = "bootstrapsadev"
  #   container_name       = "tfstate"
  #   key                  = "appsrv-poc/app.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
