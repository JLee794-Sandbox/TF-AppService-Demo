#
# AzureCAF Naming Variables
# --------------------------------------------------
# Variables to construct naming and tags based on established standards
#   Current naming convention example:
#    az-asp-NA02SCUS-someApp-app
#     prefix = "az"
#     resource_type = "asp"
#     country_code = "NA"
#     environment_code = "02"
#     short_location = SCUS
#     application_name = "someApp"
#     suffix = "app"

variable "application_name" {
  description = "(Required) Product/Application name which will be appended as a suffix."
  type        = string
}

variable "prefix" {
  description = "(Optional) Prefix to set for the resource names. Defaults to 'az'."
  type        = string
  default     = "az"
}

variable "owner" {
  description = "(Required) Email or ID of the owner for the resource."
  type        = string
}

variable "country_code" {
  description = "(Required) Short country code to use for the name (eg. eu for europe, na for north america)"
  type        = string
  validation {
    condition     = contains(["na", "eu"], lower(var.country_code))
    error_message = "Currently only North America (NA) and Europe (EU) are supported."
  }
}

variable "environment_code" {
  description = "(Required) Numerical representation of the environment"
  type        = string
  validation {
    condition     = contains(["02", "01", "03"], var.environment_code)
    error_message = "Environment must be a number of 02 (nonprod), 03 (backup), or 04 (prod)."
  }
}

variable "location" {
  description = "(Required) location - example: South Central US = southcentralus"
  type        = string
  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus"], lower(var.location))
    error_message = "Location must be one of the following: eastus, eastus2, southcentralus, westus."
  }
}

variable "tags" {
  description = "(Optional) Additional tags to apply to the resource."
  type        = map(any)
  default     = {}
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
