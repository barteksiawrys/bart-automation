resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.rg_name}-${var.name_suffix}"
  location = var.location
}
