variable "location" {
  default     = "Poland Central"
  type        = string
  description = "The Azure location"
}

variable "rg_name" {
  type        = string
  description = "The Azure resource group"
}

variable "name_prefix" {
  default     = "postgres"
  description = "Prefix of the resource name."
}