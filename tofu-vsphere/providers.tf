terraform {
  required_version = ">=1.7.0"

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~>2.8.2"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_pass
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 10
}
