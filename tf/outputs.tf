output "az_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "az_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "az_cluster_endpoint" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "az_cluster_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
