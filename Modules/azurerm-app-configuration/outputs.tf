output "azurerm_app_configuration" {
  value = azurerm_app_configuration.this
}
output "azurerm_app_configuration_feature" {
  value = azurerm_app_configuration_feature.this.*
}
output "azurerm_app_configuration_key" {
  value = azurerm_app_configuration_key.this.*
}
