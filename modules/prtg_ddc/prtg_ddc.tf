terraform {
  required_version = ">= 0.10.0"
}
variable "vsphere_compute" {
  default = "WHMQ30303 - MGMT"
}

data "vsphere_datacenter" "dc" {
  name = "Montreal"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VLAN105_Std"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "Windows2019_Interac_22Jun2021"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_resource_pool" "pool" {
  name          = "TF"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

variable "vcenter_username" {
  description = "vCenter administrator username"
  type        = string
  sensitive = true
}

variable "vcenter_password" {
  description = "vCenter administrator password"
  type        = string
  sensitive = true
}
provider "vsphere" {
    user           = var.vcenter_username
  password       = var.vcenter_password
  alias = ddc
  vsphere_server = "10.5.15.29"
  #version = "~&gt; 1.11"
 
  # If you have a self-signed cert
 allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "VM" {
  provider = 
  guest_id = "windows9Server64Guest"
  count = "1"
  name   = "PRTG_DDC_VM"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "vmxnet3" 
    }
    disk {
    label = "disk0"
    size = "${data.vsphere_virtual_machine.template.disks.0.size}"
  }
  firmware = "efi"

   clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
   }
  ignored_guest_ips =[]
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  #vcpu   = 2
  #memory = 4096
  # ...
} 