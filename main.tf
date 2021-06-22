variable "user" {
  description = "vCenter administrator username"
  type        = string
}

variable "password" {
  description = "vCenter administrator password"
  type        = string
}

module "prtg_qa" {
  source      = "./modules/prtg_qa"
user = "al.jain@mgmt.certapay.com"
password = "VMw@reNew!!"
}
