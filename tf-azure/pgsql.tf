resource "random_password" "pass" {
  length = 20
}

resource "azurerm_postgresql_flexible_server" "pgsql" {
  name                   = "pgsql-${var.rg_name}-${var.name_suffix}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "15"
  delegated_subnet_id    = azurerm_subnet.subnet-pgsql.id
  private_dns_zone_id    = azurerm_private_dns_zone.pdz.id
  administrator_login    = "ezdrpadmin"
  administrator_password = random_password.pass.result
  zone                   = "1"
  storage_mb             = 32768
  auto_grow_enabled      = "false"
  sku_name               = var.pgsql_sku_name
  backup_retention_days  = 7

  high_availability {
    mode = "ZoneRedundant"
  }

  lifecycle {
    ignore_changes = [zone, high_availability.0.standby_availability_zone]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pdzvnetlink]
}

resource "azurerm_postgresql_flexible_server_configuration" "config" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.pgsql.id
  value     = "UUID-OSSP"
}
