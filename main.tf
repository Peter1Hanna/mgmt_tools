
#DDC PRTG VMs
module "prtg_ddc" {
  source      = "./modules/prtg_ddc"
    user           = "al.jain@mgmt.certapay.com"
  password       = "VMw@reNew!!"
}

module "prtg_mdc" {
  source      = "./modules/prtg_mdc"
  user           = "al.jain@mgmt.certapay.com"
  password       = "VMw@reNew!!"
}

module "prtg_qa" {
 source      = "./modules/prtg_qa"
  user           = "al.jain@mgmt.certapay.com"
  password       = "VMw@reNew!!"
}
