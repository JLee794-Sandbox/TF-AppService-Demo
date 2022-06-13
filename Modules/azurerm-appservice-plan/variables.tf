variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the App Service Environment and Plan"
}
variable "location" {
  type        = string
  description = "(Required) The name of the resource group in which to create the App Service Environment and Plan"
}

# -
# - App Service Plan Required Parameters
# -
variable "name" {
  type        = string
  description = "(Required) The name of the App Service"
}

variable "sku_name" {
  type        = string
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, and WS3."
  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "FREE", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.sku_name)
    error_message = "The sku_name must be one of B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, and WS3."
  }
}

variable "os_type" {
  type        = string
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer."
  validation {
    condition     = contains(["windows", "linux", "windowscontainer"], lower(var.os_type))
    error_message = "The os_type must be one of Windows, Linux, or WindowsContainer."
  }
}

# -
# - Optional Parameters
# -
variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers (instances) to be allocated."
  default     = null
}

variable "per_site_scaling_enabled" {
  type        = bool
  description = "(Optional) Should Per Site Scaling be enabled. Defaults to false."
  default     = false
}

variable "zone_balancing_enabled" {
  type        = bool
  description = "(Optional) Should the Service Plan balance across Availability Zones in the region. Defaults to false."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}
