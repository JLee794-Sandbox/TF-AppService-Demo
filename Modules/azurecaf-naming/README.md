# azurecaf-naming

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | 2.0.0-preview-3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 2.0.0-preview-3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.this](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview-3/docs/resources/name) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | (Required) Product/Application name which will be appended as a suffix. | `string` | n/a | yes |
| <a name="input_clean_input"></a> [clean\_input](#input\_clean\_input) | (Optional) - defaults to true. remove any noncompliant character from the name, suffix or prefix. | `bool` | `true` | no |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | (Required) Short country code to use for the name (eg. eu for europe, na for north america) | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | (Required) Numerical representation of the environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) location - example: South Central US = southcentralus | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) Email or ID of the owner for the resource. | `string` | n/a | yes |
| <a name="input_passthrough"></a> [passthrough](#input\_passthrough) | (Optional) - defaults to false. Enables the passthrough mode - in that case only the clean input option is considered and the prefixes, suffixes, random, and are ignored. The resource prefixe is not added either to the resulting string | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Optional) prefix to append as the first characters of the generated name - prefixes will be separated by the separator character | `string` | `"az"` | no |
| <a name="input_random_length"></a> [random\_length](#input\_random\_length) | (Optional) - defaults to 0 length of the randomly generated string to append to the name. | `number` | `0` | no |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | (Optional) - describes the type of azure resource you are requesting a name from (eg. azure container registry: azurerm\_container\_registry). See the Resource Type section | `string` | `""` | no |
| <a name="input_resource_types"></a> [resource\_types](#input\_resource\_types) | (Optional) - a list of additional resource type should you want to use the same settings for a set of resources | `list(string)` | `[]` | no |
| <a name="input_separator"></a> [separator](#input\_separator) | (Optional) - defaults to -. The separator character to use between prefixes, resource type, name, suffixes, random character | `string` | `"-"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | (Optional) suffix to append as the last characters of the generated name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) - tags to merge with the generated tags. | `map(any)` | `{}` | no |
| <a name="input_use_slug"></a> [use\_slug](#input\_use\_slug) | (Optional) - defaults to true. If a slug should be added to the name - If you put false no slug (the few letters that identify the resource type) will be added to the name. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_result"></a> [result](#output\_result) | n/a |
| <a name="output_results"></a> [results](#output\_results) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | Merge input tags with our tags. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
