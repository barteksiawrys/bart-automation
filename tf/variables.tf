variable "rg_name" {
  type        = string
  description = "The Azure resource group"
}

variable "name_suffix" {
  description = "Suffix of the resource name"
  type        = string
}

variable "location" {
  default     = "Poland Central"
  type        = string
  description = "The Azure location"
}

variable "vnet_cidr" {
  description = "vnet address space"
  type        = string
}

variable "subnet_db_cidr" {
  description = "subnet-db address prefixes"
  type        = string
}

variable "subnet_pgsql_cidr" {
  description = "subnet-pgsql address prefixes"
  type        = string
}

variable "subnet_aks_cidr" {
  description = "subnet-aks address prefixes"
  type        = string
}

variable "vm_name" {
  description = "VM hostname"
  type        = string
  default     = "db"
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1ls"
}

variable "pgsql_sku_name" {
  description = "pgsql size"
  type        = string
  default     = "GP_Standard_D2ds_v4"
}

variable "k8s_version" {
  default     = "1.28.3"
  type        = string
  description = "The version of Kubernetes"
}

variable "aks_worker_size" {
  description = "AKS worker size"
  type        = string
  default     = "Standard_B2s"
}