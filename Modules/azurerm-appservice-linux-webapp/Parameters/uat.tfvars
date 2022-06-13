# Shared
resource_group_name  = "validation-rg"
virtual_network_name = "test-vnet"
subnet_name          = "test-subnet"
name                 = "fmcsp-appsrv"
zone_redundant       = false

# ASE vars
internal_load_balancing_mode = "Web, Publishing"

# ASP Vars
os_type      = "Windows"
sku_name     = "I3v2" # Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments
worker_count = 4
