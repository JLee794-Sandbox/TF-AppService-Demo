variable "prefix" {
  type        = string
  description = "(Optional) prefix to append as the first characters of the generated name - prefixes will be separated by the separator character"
  default     = "az"
}

variable "suffix" {
  type        = string
  description = "(Optional) suffix to append as the last characters of the generated name"
  default     = ""
}

variable "resource_type" {
  type        = string
  description = "(Optional) - describes the type of azure resource you are requesting a name from (eg. azure container registry: azurerm_container_registry). See the Resource Type section"
  default     = ""
}

variable "resource_types" {
  type        = list(string)
  description = "(Optional) - a list of additional resource type should you want to use the same settings for a set of resources"
  default     = []
}

variable "application_name" {
  description = "(Required) Product/Application name which will be appended as a suffix."
  type        = string
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
    condition     = contains(["01", "02", "03"], var.environment_code)
    error_message = "Environment must be a number of 02 (nonprod), 03 (backups), or 01 (prod)."
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

# -
# - CAF Naming Configuration
# - ---------------------------------------------------------------------------------------------------------------------

variable "separator" {
  type        = string
  description = "(Optional) - defaults to -. The separator character to use between prefixes, resource type, name, suffixes, random character"
  default     = "-"
}

variable "clean_input" {
  type        = bool
  description = "(Optional) - defaults to true. remove any noncompliant character from the name, suffix or prefix."
  default     = true
}

variable "use_slug" {
  type        = bool
  description = "(Optional) - defaults to true. If a slug should be added to the name - If you put false no slug (the few letters that identify the resource type) will be added to the name."
  default     = true
}

variable "passthrough" {
  type        = bool
  description = "(Optional) - defaults to false. Enables the passthrough mode - in that case only the clean input option is considered and the prefixes, suffixes, random, and are ignored. The resource prefixe is not added either to the resulting string"
  default     = false
}

variable "random_length" {
  type        = number
  default     = 0
  description = "(Optional) - defaults to 0 length of the randomly generated string to append to the name."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "(Optional) - tags to merge with the generated tags."
}
