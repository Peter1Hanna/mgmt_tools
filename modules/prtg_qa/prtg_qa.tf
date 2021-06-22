terraform {
  required_version = ">= 0.10.0"
}
variable "vsphere_compute" {
  default = "WHTQ30309 - MGMT"
}

data "vsphere_datacenter" "dc" {
  name = "Toronto"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "var.vsphere_compute"
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
  default = "al.jain@mgmt.certapay.com"
}

variable "vcenter_password" {
  description = "vCenter administrator password"
  type        = string
  default = "VMw@reNew!!"
}
provider "vsphere" {
    user           = "al.jain@mgmt.certapay.com"
  password       = "VMw@reNew!!"
  vsphere_server = "10.6.15.37"
  #version = "~&gt; 1.11"
 
  # If you have a self-signed cert
 allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "VM" {
  guest_id = "windows9Server64Guest"
  count = "1"
  name   = "PRTG_MDC_QA"
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

  # ...
} 
