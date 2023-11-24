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

resource "azurerm_resource_group" "rg-tf" {
  name     = "rg-tf"
  location = "Poland Central"

  tags = {
    environment = "r&d"
  }
}

resource "azurerm_virtual_network" "vnet-tf" {
  name                = "vnet-tf"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  address_space       = ["10.4.0.0/16"]

  tags = {
    environment = "r&d"
  }
}