resource "random_pet" "name_prefix" {
  prefix = var.name_prefix
  length = 1
}

resource "azurerm_resource_group" "rg" {
  #  name     = var.rg_name
  name     = random_pet.name_prefix.id
  location = var.location
}
