#
# azurecaf-naming
# -------------------------------------------------
# Assists in enforcing naming and tagging standards
# for Azure CAF resources.
#
# Additional information and implementation guidelines:
#  https://github.com/aztfmod/terraform-provider-azurecaf
# -------------------------------------------------
# Current naming convention example:
# az-asp-NA02SCUS-JLeeParts-app
#  prefix = "az"
#  resource_type = "asp"
#  country_code = "NA"
#  environment_code = "02"
#  short_location = SCUS
#  application_name = "JLeeParts"
#  suffix = "app"

locals {
  short_location_names = {
    "eastus"         = "eus"
    "westus"         = "wus"
    "eastus2"        = "eus2"
    "southcentralus" = "scus"
  }

  base_tags = {
    "Owner"           = var.owner
    "ApplicationName" = var.application_name,
  }

  prefixes       = [var.prefix]
  suffixes       = var.suffix == "" ? [var.application_name] : [var.application_name, var.suffix]
  body           = lower("${var.country_code}${var.environment_code}${local.short_location_names[var.location]}")
  resource_types = var.resource_type != "" ? [var.resource_type] : var.resource_types

  fmt_resource_types = contains(local.resource_types, "general") ? local.resource_types : concat(local.resource_types, ["general"])
}

resource "azurecaf_name" "this" {
  resource_types = local.fmt_resource_types

  name     = local.body
  prefixes = local.prefixes
  suffixes = local.suffixes

  # Extra configuration options
  clean_input   = var.clean_input
  use_slug      = var.use_slug
  random_length = var.random_length
  passthrough   = var.passthrough
  separator     = var.separator
}
