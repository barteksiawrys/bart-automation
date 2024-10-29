data "vsphere_virtual_machine" "proxy_template" {
  name          = var.vm_proxy_tmpl
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm_proxy" {
  name             = lower("${var.datacenter}-${var.vm_proxy_name}-${var.vm_suffix}")
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path
  num_cpus         = var.vm_proxy_cpu
  memory           = var.vm_proxy_ram
  guest_id         = data.vsphere_virtual_machine.proxy_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.proxy_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.proxy_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.proxy_template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.proxy_template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.proxy_template.id
  }
}