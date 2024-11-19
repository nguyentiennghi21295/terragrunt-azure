resource "azurerm_resource_group" "rg_each" {
  name     = var.rg_name
  location = var.rg_location
  tags = {
    Environment = var.environment
    Region      = var.rg_location
  }
  lifecycle {
    prevent_destroy = true
  }
}

# Storage Account
resource "azurerm_storage_account" "sa_each" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    prevent_destroy = true
  }
}

# # Storage Container
# resource "azurerm_storage_container" "sc_each" {
#   name                  = var.sc_name
#   storage_account_name  = var.sa_name
#   container_access_type = "private"
#   lifecycle {
#     prevent_destroy = true
#   }
# }

