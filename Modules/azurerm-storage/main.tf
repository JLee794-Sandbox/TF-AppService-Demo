#
# Storage Account Management
# ------------------------------------------
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  blob_properties {
    dynamic "delete_retention_policy" {
      for_each = var.soft_delete_retention > 0 ? toset([1]) : toset([])
      content {
        days = var.soft_delete_retention
      }
    }
    dynamic "cors_rule" {
      for_each = var.cors_rule
      content {
        allowed_origins    = cors_rule.value.allowed_origins
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_headers    = cors_rule.value.allowed_headers
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action             = "Deny"
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids = var.network_rules.subnet_ids
      bypass                     = var.network_rules.bypass
    }
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

# 
# Create Containers if specified
# ------------------------------------------
resource "azurerm_storage_container" "this" {
  count                 = length(var.containers)
  name                  = var.containers[count.index].name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.containers[count.index].access_type
}

#
# Create Role Assignments if specified
# ------------------------------------------
data "azuread_groups" "ad_group_ids" {
  display_names = local.all_ad_group_names
}

locals {
  all_ad_group_names = concat(
    var.contributors,
    var.readers,
  )

  ad_group_mapping = zipmap(local.all_ad_group_names,data.azuread_groups.ad_group_ids.object_ids)
}

resource "azurerm_role_assignment" "st_contributors" {
  for_each = toset(var.contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = local.ad_group_mapping[each.key]
}

resource "azurerm_role_assignment" "st_readers" {
  for_each = toset(var.readers)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Reader"
  principal_id         = local.ad_group_mapping[each.key]
}
