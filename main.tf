variable "vcenter_username" {
  description = "vCenter administrator username"
  type        = string
}

variable "vcenter_password" {
  description = "vCenter administrator password"
  type        = string
}
#DDC PRTG VMs
/*
module "prtg_ddc" {
  source      = "./modules/prtg_ddc"

vcenter_username = "${var.vcenter_username}"
vcenter_password = "${var.vcenter_password}"
}

module "prtg_mdc" {
  source      = "./modules/prtg_mdc"
vcenter_username = "${var.vcenter_username}"
vcenter_password = "${var.vcenter_password}"
}
*/
module "prtg_qa" {
 source      = "./modules/prtg_mdc"
vcenter_username = "al.jain@mgmt.certapay.com"
vcenter_password = "VMw@reNew!!"
}
