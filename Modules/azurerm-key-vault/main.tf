data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  sku_name = var.sku_name

  # Grant the current Azure deployment ID to manage secrets
  dynamic "access_policy" {
    for_each = var.enable_rbac_authorization ? [] : [1]
    content {
      tenant_id          = data.azurerm_client_config.current.tenant_id
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "Set", "Delete", "List"]
    }
  }

  dynamic "access_policy" {
    for_each = var.enable_rbac_authorization ? [] : var.access_policy
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value["object_id"]
      certificate_permissions = access_policy.value["certificate_permissions"]
      key_permissions         = access_policy.value["key_permissions"]
      secret_permissions      = access_policy.value["secret_permissions"]
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls
    content {
      bypass                     = network_acls.value["bypass"]
      default_action             = network_acls.value["default_action"]
      ip_rules                   = network_acls.value["ip_rules"]
      virtual_network_subnet_ids = network_acls.value["virtual_network_subnet_ids"]
    }
  }


  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

data "azuread_group" "this" {
  for_each = var.group_role_assignments

  display_name = each.key
}

locals {
  group_ids_by_display_name = {
    for group in data.azuread_group.this :
    group.display_name => group.id
  }
}

resource "azurerm_role_assignment" "dynamic" {
  for_each = var.group_role_assignments

  scope                = azurerm_key_vault.this.id
  role_definition_name = each.value
  principal_id         = local.group_ids_by_display_name[each.key]
}
