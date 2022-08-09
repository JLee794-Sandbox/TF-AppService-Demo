variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the App Service Environment and Plan"
}
variable "location" {
  type        = string
  description = "(Required) The name of the resource group in which to create the App Service Environment and Plan"
}

# -
# - App Configuration Parameters
# -
variable "name" {
  type        = string
  description = "(Required) The name of the App Configuration"
}

variable "app_configuration_features" {
  type        = map(any)
  description = "(Optional) Mapping of app configuration features"
  default     = {}
}

variable "app_configuration_keys" {
  type        = map(any)
  description = "(Optional) Mapping of app configuration keys"
  default     = {}
}
