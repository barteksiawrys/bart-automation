terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
  
  # remote state
  #backend "azurerm" {
  #  resource_group_name  = "mgmt"
  #  storage_account_name = "tfstate8250"
  #  container_name       = "tfstate"
  #  key                  = "terraform.tfstate"
  #}
}

provider "azurerm" {
  features {}
}

