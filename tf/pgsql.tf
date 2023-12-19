resource "random_password" "pass" {
  length = 20
}

resource "azurerm_postgresql_flexible_server" "pgsql" {
  name                   = "pgsql-${random_pet.name_prefix.id}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "15"
  delegated_subnet_id    = azurerm_subnet.subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.pdz.id
  administrator_login    = "Bart"
  administrator_password = random_password.pass.result
  zone                   = "1"
  storage_mb             = 32768
  sku_name               = "GP_Standard_D2s_v3"
  backup_retention_days  = 7

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pdzvnetlink]
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "${random_pet.name_prefix.id}-db"
  server_id = azurerm_postgresql_flexible_server.pgsql.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}