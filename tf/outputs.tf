output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "vm_db_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.pgsql.name
}

output "postgresql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.pgsql.administrator_password
}
