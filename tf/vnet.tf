resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.rg_name}-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "subnet-db" {
  name                 = "subnet-db-${var.rg_name}-${var.name_suffix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_db_cidr]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.rg_name}-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "snsga-db" {
  subnet_id                 = azurerm_subnet.subnet-db.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
