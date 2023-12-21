resource "azurerm_network_interface" "nic-tf" {
  name                = "nic-${azurerm_linux_virtual_machine.vmname}-"
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

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-tf"
  resource_group_name   = azurerm_resource_group.rg-tf.name
  location              = azurerm_resource_group.rg-tf.location
  size                  = "Standard_B1ls"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic-tf.id]

  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-script.tpl", {
      hostname     = self.public_ip_address,
      user         = "adminuser",
      identityfile = "~/.ssh/id_rsa"
    })
    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }

  tags = {
    environment = "r&d"
  }
}