# Demo.tf
# ------------------------------------------------
# Encapsulates declarations for adopting the
#   azurerm_storage and azurerm_key_vault modules.
# ------------------------------------------------
# Creates:
# - Storage account with AD groups and RBAC
# - Key vault with AD groups and RBAC
#
# ------------------------------------------------
variable "storage_account_contributors" {
  type = list(string)
  description = "List of AD Group display names to assign as Contributor to the storage account."
  default = []
}
variable "storage_account_readers" {
  type = list(string)
  description = "List of AD Group display names to assign as Reader to the storage account."
  default = []
}

module "azurerm_storage" {
  source = "./Modules/azurerm-storage"

  name = module.azurecaf-app.results["azurerm_storage_account"]
  resource_group_name = module.app-rg.name
  location            = module.app-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  contributors = var.storage_account_contributors
  readers      = var.storage_account_readers
  
  tags = module.azurecaf-app.tags
}

module "azurerm_key_vault" {
  source = "./Modules/azurerm-key-vault"

  name = module.azurecaf-app.results["azurerm_key_vault"]
  resource_group_name = module.app-rg.name
  location            = module.app-rg.location

  group_role_assignments = {
    "mn-jinle-demo" = "Reader"
  }

  tags = module.azurecaf-app.tags
}

output "kv" {
  value = module.azurerm_key_vault.*
}

output "azurerm_storage" {
  value = module.azurerm_storage.*
}
# variable "key_vault_contributors" {
#   type = list(string)
#   description = "List of AD Group display names to assign as Contributor to the storage account."
#   default = []
# }
# variable "key_vault_readers" {
#   type = list(string)
#   description = "List of AD Group display names to assign as Reader to the storage account."
#   default = []
# }

# resource "azurerm_storage_account" "this" {
#   name = module.azurecaf-app.results["azurerm_storage_account"]
#   resource_group_name = module.app-rg.name
#   location            = module.app-rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags = module.azurecaf-app.tags
# }


# locals {
#   all_ad_group_names = concat(
#     var.storage_account_contributors,
#     var.storage_account_readers,
#     var.key_vault_contributors,
#     var.key_vault_readers
#   )

#   ad_group_mapping = zipmap(local.all_ad_group_names,data.azuread_groups.ad_group_ids.object_ids)
# }

# data "azuread_groups" "ad_group_ids" {
#   display_names = local.all_ad_group_names
# }

# resource "azurerm_role_assignment" "st_contributors" {
#   for_each = toset(var.storage_account_contributors)

#   scope                = azurerm_storage_account.this.id
#   role_definition_name = "Storage Account Contributor"
#   principal_id         = local.ad_group_mapping[each.key]
# }

# resource "azurerm_role_assignment" "st_readers" {
#   for_each = toset(var.storage_account_readers)

#   scope                = azurerm_storage_account.this.id
#   role_definition_name = "Reader"
#   principal_id         = local.ad_group_mapping[each.key]
# }
