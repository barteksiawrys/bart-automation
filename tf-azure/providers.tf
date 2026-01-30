terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.0"
    }
  }

  # remote state
  #  backend "azurerm" {
  #    resource_group_name  = "mgmt"
  #    storage_account_name = "tfstate8250"
  #    container_name       = "tfstate"
  #    key                  = "terraform.tfstate"
  #  }
}

provider "azurerm" {
  features {}
}
