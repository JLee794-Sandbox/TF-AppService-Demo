# azurerm-appservice

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A map of App Settings to set on the App Service. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location to deploy resources to. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the App Service | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the App Service Environment and Plan | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | (Required) The ID of the App Service Plan to deploy the linux application to | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Optional) A map of App Settings to set on the App Service. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | (Optional) Specifies the id of a log analytics workspace resource | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_linux_web_app"></a> [azurerm\_linux\_web\_app](#output\_azurerm\_linux\_web\_app) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
