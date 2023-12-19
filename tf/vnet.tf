resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${random_pet.name_prefix.id}"
  address_space       = ["10.12.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${random_pet.name_prefix.id}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.12.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${random_pet.name_prefix.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "snsga" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_private_dns_zone" "pdz" {
  name                = "${random_pet.name_prefix.id}-pdz.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_subnet_network_security_group_association.snsga]
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdzvnetlink" {
  name                  = "${random_pet.name_prefix.id}-pdzvnetlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.pdz.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg.name
}
