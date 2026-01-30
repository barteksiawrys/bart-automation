output "vm_proxy" {
  value = {
    name = vsphere_virtual_machine.vm_proxy.name,
    IP   = vsphere_virtual_machine.vm_proxy.default_ip_address
  }
}

output "vm_ctrl" {
  value = {
    name = vsphere_virtual_machine.vm_ctrl[*].name
    IP   = vsphere_virtual_machine.vm_ctrl[*].default_ip_address
  }
}

output "vm_work" {
  value = {
    name = vsphere_virtual_machine.vm_work[*].name
    IP   = vsphere_virtual_machine.vm_work[*].default_ip_address
  }
}
