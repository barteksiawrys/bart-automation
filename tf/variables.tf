variable "location" {
  default     = "Poland Central"
  type        = string
  description = "The Azure location"
}

variable "rg_name" {
  type        = string
  description = "The Azure resource group"
}

variable "k8s_version" {
  default     = "1.28.3"
  type        = string
  description = "The version of Kubernetes"
}

variable "ssh_key" {
  type        = string
  description = "The SSH public key"
}