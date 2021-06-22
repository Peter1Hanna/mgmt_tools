terraform {
  required_providers {
    vsphere = {
     version = "~> 1.0"
    }
  }
}
provider "vsphere" {
    user           = var.vcenter_username
  password       = var.vcenter_password
  vsphere_server = "10.6.15.37"
  #version = "~&gt; 1.11"
 
  # If you have a self-signed cert
 allow_unverified_ssl = true
}

variable "vcenter_username" {
  description = "vCenter administrator username"
  type        = string
}

variable "vcenter_password" {
  description = "vCenter administrator password"
  type        = string
}

module "prtg_ddc" {
  source      = "./modules/prtg_ddc"

vcenter_username = var.vcenter_username
vcenter_password = var.vcenter_password
}

module "prtg_mdc" {
  source      = "./modules/prtg_mdc"

vcenter_username = var.vcenter_username
vcenter_password = var.vcenter_password
}
module "prtg_qa" {
  source      = "./modules/prtg_qa"

vcenter_username = var.vcenter_username
vcenter_password = var.vcenter_password
}
