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

variable "vm_name" {
  description = "VM hostname"
  type        = string
  default     = "db"
}