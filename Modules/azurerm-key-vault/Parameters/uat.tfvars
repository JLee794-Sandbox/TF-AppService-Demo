  name = "my-test-kv"
  resource_group_name = "validation-rg"
  location            = "EastUS2"

  group_role_assignments = {
    "mn-jinle-demo" = "Reader"
  }
  