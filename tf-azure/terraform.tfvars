rg_name     = "app"          # RG name
name_suffix = "tf"             # suffix for all resources
location    = "Poland Central" # region

vnet_cidr         = "10.4.0.0/16"
subnet_db_cidr    = "10.4.0.0/24"
subnet_pgsql_cidr = "10.4.1.0/24"
subnet_aks_cidr   = "10.4.16.0/20"

vm_name         = "db"
vm_size         = "Standard_B1ls"
pgsql_sku_name  = "GP_Standard_D2ds_v4"
k8s_version     = "1.28.3"
aks_worker_size = "Standard_B2s"
