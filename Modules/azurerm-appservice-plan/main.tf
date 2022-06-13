# -
# - Create App Service Plan
# -
resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name
  os_type  = var.os_type

  worker_count             = var.worker_count
  per_site_scaling_enabled = var.per_site_scaling_enabled
  zone_balancing_enabled   = var.zone_balancing_enabled

  tags = var.tags
}
