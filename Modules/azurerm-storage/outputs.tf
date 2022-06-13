output "id" {
  value = azurerm_storage_account.this.id
}

output "containers" {
  value = azurerm_storage_container.this.*.id
}
