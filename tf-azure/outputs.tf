output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "vm_db_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "pgsql_flexible_server" {
  value = azurerm_postgresql_flexible_server.pgsql.name
}

output "pgsql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.pgsql.administrator_password
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_endpoint" {
  value = azurerm_kubernetes_cluster.aks.private_fqdn
}

output "aks_cluster_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}