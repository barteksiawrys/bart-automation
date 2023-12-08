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

resource "azurerm_subnet" "subnet-tf" {
  name                 = "subnet-tf"
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.vnet-tf.name
  address_prefixes     = ["10.4.1.0/24"]
}

resource "azurerm_network_security_group" "nsg-tf" {
  name                = "nsg-tf"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  tags = {
    environment = "r&d"
  }
}

resource "azurerm_network_security_rule" "nsr-tf" {
  name                        = "SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "88.156.143.115/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-tf.name
  network_security_group_name = azurerm_network_security_group.nsg-tf.name
}

resource "azurerm_subnet_network_security_group_association" "sga-tf" {
  subnet_id                 = azurerm_subnet.subnet-tf.id
  network_security_group_id = azurerm_network_security_group.nsg-tf.id
}

resource "azurerm_public_ip" "ip-tf" {
  name                = "ip-tf"
  resource_group_name = azurerm_resource_group.rg-tf.name
  location            = azurerm_resource_group.rg-tf.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "r&d"
  }
}

resource "azurerm_network_interface" "nic-tf" {
  name                = "nic-tf"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-tf.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip-tf.id
  }

  tags = {
    environment = "r&d"
  }
}