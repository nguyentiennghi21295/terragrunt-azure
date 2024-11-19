output "rg_name" {
  value = azurerm_resource_group.rg_each.name
}
output "rg_location" {
  value = azurerm_resource_group.rg_each.location
}
# Output Storage Account Name
output "storage_account_name" {
  value = azurerm_storage_account.sa_each.name
}

# Output Container Name
# output "storage_container_name" {
#   value = azurerm_storage_container.sc_each.name
# }