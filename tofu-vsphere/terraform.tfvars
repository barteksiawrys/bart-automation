vsphere_user = "<username>"
#vsphere_pass = "<pass>" # it's better to "export TF_VAR_vsphere_pass=<pass>"

vsphere_server = ""
datacenter     = ""
datastore      = ""
cluster        = ""
resource_pool  = ""
folder         = ""
network        = ""

vm_proxy_tmpl = ""
vm_ctrl_tmpl  = ""
vm_work_tmpl  = ""
vm_suffix     = "tofu"
vm_ctrl_count = 3
vm_work_count = 3