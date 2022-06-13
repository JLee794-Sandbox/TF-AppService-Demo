output "azurecaf-naming-objects" {
  value = tomap({
    app     = module.azurecaf-app.*,
  })
}


#
# Application Layer Outputs
# ---------------------------------------------------------
output "app-rg" {
  value = module.app-rg.*
}

output "appservice-plan" {
  value = module.appservice-plan.*
}

// output "appservice-linux-webapp" {
//   value = module.appservice-linux-webapp.*
// }
