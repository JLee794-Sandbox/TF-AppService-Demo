# -
# - Create App Service
# -
# Enabling web sockets
# 64 bit
# .NET 6

resource "azurerm_linux_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {}

  app_settings = merge(
    var.app_settings,
    {
      APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.this.instrumentation_key
    }
  )

  // TODO: review config items with team
  //  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
  // application_stack {
  //   // docker_image = var.docker_image
  //   // docker_image_tag = var.docker_image_tag
  //   // dotnet_version = "6.0"
  // }
  // action {}
  // active_directory {}
  // application_logs {}
  // site_config {}
  // slow_request {}
  // status_code {}
  // sticky_settings {}
  // storage_account {}
  // trigger {}
  // auth_settings {}
  // auto_heal_setting {}
  // azure_blob_storage {}
  // backup {}
  // cors {}

  tags = var.tags
}

resource "azurerm_application_insights" "this" {
  name                = "${var.name}-appinsights"
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_id        = var.workspace_id
  application_type    = "web"
}
