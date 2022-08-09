data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "current" {
  name = var.resource_group_name
}
#
# Manage Azure App Configuration
# ------------------------------------------------
resource "azurerm_app_configuration" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

#
# Manage Azure App Configuration Feature
# ------------------------------------------------
resource "azurerm_app_configuration_feature" "this" {
  for_each = var.app_configuration_features

  configuration_store_id = azurerm_app_configuration.this.id

  name        = each.key
  description = lookup(each.value, "description", "")
  label       = lookup(each.value, "label", "")
  enabled     = lookup(each.value, "enabled", false)
  tags        = lookup(each.value, "tags", {})

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}

#
# Manage Azure App Configuration Key
# ------------------------------------------------
resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = data.azurerm_resource_group.current.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration_key" "this" {
  for_each = var.app_configuration_keys

  configuration_store_id = azurerm_app_configuration.this.id
  key                    = each.key

  label               = lookup(each.value, "label", "")
  value               = lookup(each.value, "value", "")
  type                = lookup(each.value, "type", "kv")                                                                     # Default to key/value (kv), 'vault' for key ref
  vault_key_reference = lookup(each.value, "type", "kv") == "vault" ? lookup(each.value, "vault_key_reference", null) : null # Only used if type is vault

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}