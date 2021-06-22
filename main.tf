variable "user" {
  description = "vCenter administrator username"
  type        = string
}

variable "vcenter_password" {
  description = "vCenter administrator password"
  type        = string
}

module "prtg_qa" {
  source      = "./modules/prtg_qa"
user = var.vcenter_username
vcenter_password = var.vcenter_password
}
