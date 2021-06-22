
#DDC PRTG VMs
module "prtg_ddc" {
  source      = "./modules/prtg_ddc"
}

module "prtg_mdc" {
  source      = "./modules/prtg_mdc"

}

module "prtg_qa" {
 source      = "./modules/prtg_qa"

}
