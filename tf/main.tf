terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-mgmt" {
  name     = "rg-mgmt"
  location = "Poland Central"
  tags = {
    environment = "mgmt"
  }
}