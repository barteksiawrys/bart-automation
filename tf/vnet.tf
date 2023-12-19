resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aks-bs"
  address_space       = ["10.11.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-aks-bs"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.11.0.0/24"]
}
