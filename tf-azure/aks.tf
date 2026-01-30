resource "azurerm_kubernetes_cluster" "aks" {
  name                    = "aks-${var.rg_name}-${var.name_suffix}"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  kubernetes_version      = var.k8s_version
  dns_prefix              = "aks-${var.rg_name}-${var.name_suffix}"
  private_cluster_enabled = true

  default_node_pool {
    name           = "system"
    node_count     = 3
    vm_size        = var.aks_worker_size
    vnet_subnet_id = azurerm_subnet.subnet-aks.id
    zones          = ["1", "2", "3"]

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}