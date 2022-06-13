terraform {
  required_providers {
    azurerm = "~> 3.4"
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview-3"
    }
  }
}

provider "azurerm" {
  features {}
}
