# azurerm-app-configuration

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |
| [azurerm_app_configuration_feature.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_key) | resource |
| [azurerm_role_assignment.appconf_dataowner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_configuration_features"></a> [app\_configuration\_features](#input\_app\_configuration\_features) | (Optional) Mapping of app configuration features | `map(any)` | `{}` | no |
| <a name="input_app_configuration_keys"></a> [app\_configuration\_keys](#input\_app\_configuration\_keys) | (Optional) Mapping of app configuration keys | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The name of the resource group in which to create the App Service Environment and Plan | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the App Configuration | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the App Service Environment and Plan | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_app_configuration"></a> [azurerm\_app\_configuration](#output\_azurerm\_app\_configuration) | n/a |
| <a name="output_azurerm_app_configuration_feature"></a> [azurerm\_app\_configuration\_feature](#output\_azurerm\_app\_configuration\_feature) | n/a |
| <a name="output_azurerm_app_configuration_key"></a> [azurerm\_app\_configuration\_key](#output\_azurerm\_app\_configuration\_key) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
