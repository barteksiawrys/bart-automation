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

resource "azurerm_network_security_group" "nsg-db" {
  name                = "nsg-db-${var.rg_name}-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "snsga-db" {
  subnet_id                 = azurerm_subnet.subnet-db.id
  network_security_group_id = azurerm_network_security_group.nsg-db.id
}

resource "azurerm_subnet" "subnet-pgsql" {
  name                 = "subnet-pgsql-${var.rg_name}-${var.name_suffix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_pgsql_cidr]
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

resource "azurerm_network_security_group" "nsg-pgsql" {
  name                = "nsg-pgsql-${var.rg_name}-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "snsga-pgsql" {
  subnet_id                 = azurerm_subnet.subnet-pgsql.id
  network_security_group_id = azurerm_network_security_group.nsg-pgsql.id
}

resource "azurerm_private_dns_zone" "pdz" {
  name                = "pdz-${var.rg_name}-${var.name_suffix}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_subnet_network_security_group_association.snsga-pgsql]
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdzvnetlink" {
  name                  = "pdzvnetlink-${var.rg_name}-${var.name_suffix}.com"
  private_dns_zone_name = azurerm_private_dns_zone.pdz.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg.name
}
