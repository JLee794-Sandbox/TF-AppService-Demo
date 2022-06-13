output "result" {
  value = azurecaf_name.this.result
}

output "results" {
  value = azurecaf_name.this.results
}

output "location" {
  value = var.location
}

output "id" {
  value = azurecaf_name.this.id
}

# Merge input tags with our tags.
output "tags" {
  value = merge(local.base_tags, var.tags)
}
