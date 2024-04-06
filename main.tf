####################################################################
################# Resource Group ###################################
####################################################################
module "resource" {
  source = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  rg_location = var.rg_location
}