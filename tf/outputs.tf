output "az_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.pgsql.name
}

output "postgresql_flexible_server_database_name" {
  value = azurerm_postgresql_flexible_server_database.db.name
}

output "postgresql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.pgsql.administrator_password
}
