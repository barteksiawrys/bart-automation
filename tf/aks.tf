resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-bs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  = var.k8s_version
  dns_prefix          = "aks-bs"

  default_node_pool {
    name           = "system"
    node_count     = 3
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.subnet.id
    zones          = ["1", "2", "3"]
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = var.ssh_key
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