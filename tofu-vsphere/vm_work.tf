data "vsphere_virtual_machine" "work_template" {
  name          = var.vm_work_tmpl
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm_work" {
  count            = var.vm_work_count
  name             = lower("${var.datacenter}-${var.vm_work_name}-${var.vm_suffix}-${count.index + 1}")
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path
  num_cpus         = var.vm_work_cpu
  memory           = var.vm_work_ram
  guest_id         = data.vsphere_virtual_machine.work_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.work_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.work_template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.work_template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.work_template.disks.0.thin_provisioned
  }

  disk {
    label            = "disk1"
    size             = data.vsphere_virtual_machine.work_template.disks.1.size
    thin_provisioned = data.vsphere_virtual_machine.work_template.disks.1.thin_provisioned
    unit_number      = 1
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.work_template.id
  }
}