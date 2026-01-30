variable "vsphere_user" {
  type = string
}

variable "vsphere_pass" {
  type = string
}

variable "vsphere_server" {
  type = string
}

variable "datacenter" {
  type = string
}

variable "datastore" {
  type = string
}

variable "cluster" {
  type = string
}

variable "resource_pool" {
  type = string
}

variable "folder" {
  type = string
}

variable "network" {
  type = string
}

variable "vm_proxy_tmpl" {
  type = string
}

variable "vm_proxy_name" {
  default = "k8s-proxy"
  type    = string
}

variable "vm_proxy_cpu" {
  type    = number
  default = 2
}

variable "vm_proxy_ram" {
  type    = number
  default = 4096
}

variable "vm_ctrl_tmpl" {
  type = string
}

variable "vm_ctrl_name" {
  default = "k8s-ctrl"
  type    = string
}

variable "vm_ctrl_cpu" {
  type    = number
  default = 4
}

variable "vm_ctrl_ram" {
  type    = number
  default = 8192
}

variable "vm_ctrl_count" {
  type    = number
  default = 3
}

variable "vm_work_tmpl" {
  type = string
}

variable "vm_work_name" {
  default = "k8s-work"
  type    = string
}

variable "vm_work_cpu" {
  type    = number
  default = 8
}

variable "vm_work_ram" {
  type    = number
  default = 16384
}

variable "vm_work_count" {
  type    = number
  default = 3
}

variable "vm_suffix" {
  type    = string
  default = "tofu"
}