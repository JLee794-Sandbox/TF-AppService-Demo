#
# Simple Terraform demo around App Service
# ------------------------------------------------

locals {
  # These tags will be merged with the current tagging
  #   standards specified within the Modules/azurecaf-naming/outputs.tf
  #   file.
  additional_tags = merge(
    var.tags, 
    {
      Provisioner = "Terraform"
      Customer    = "myNexus"
    }
  )

  # Layer specific tags
  app_layer_tags     = {}
}

#
# Format names for Azure Resources based on given parameters
# ------------------------------------------------
module "azurecaf-app" {
  source = "./Modules/azurecaf-naming"

  country_code     = var.country_code
  environment_code = var.environment_code
  application_name = var.application_name
  resource_types = [
    "azurerm_resource_group",
    "azurerm_app_service_plan",
    "azurerm_app_service"
  ]
  location = var.location
  owner    = var.owner

  prefix = var.prefix
  suffix = "app"
  tags   = merge(local.additional_tags, local.app_layer_tags)
}

#
# Create the application resource group
# ------------------------------------------------
module "app-rg" {
  source = "./Modules/azurerm-resourcegroup"

  name     = module.azurecaf-app.results["azurerm_resource_group"]
  location = module.azurecaf-app.location

  tags = module.azurecaf-app.tags
}

#
# Create the app service plan
# ------------------------------------------------
module "appservice-plan" {
  source = "./Modules/azurerm-appservice-plan"

  name = module.azurecaf-app.results["azurerm_app_service_plan"]

  resource_group_name = module.app-rg.name
  location            = module.app-rg.location

  sku_name = "S2"
  os_type  = "Linux"

  worker_count             = null
  per_site_scaling_enabled = false
  zone_balancing_enabled   = false

  tags = module.azurecaf-app.tags
}

#
# Create the linux web application on the asp
# ------------------------------------------------
module "linux-webapp" {
  source = "./Modules/azurerm-appservice-linux-webapp"

  name = module.azurecaf-app.results["azurerm_app_service"]

  resource_group_name = module.app-rg.name
  location            = module.app-rg.location
  service_plan_id     = module.appservice-plan.id

  tags = module.azurecaf-app.tags
}
