output "az_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "az_vm_private_ip" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}