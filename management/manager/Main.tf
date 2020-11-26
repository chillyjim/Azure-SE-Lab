terraform {
  required_version = ">= 0.12"
}

module "mgr" {
  source   = "../../modules/mgmt"
  location = "eastus2"
  basename = "management"
  vnetname = "management-vnet"
  network  = "10.16"
  mgrsub   = "1"
  netname  = "manager"
}
