terraform {
  required_version = ">= 0.13"
}

module "common" {
  source          = "../modules/common/"
  location        = "eastus2"
  basename        = "troy"
  base_cidr_block = "10.200.0.0/16"
  networks = [
    {
      name     = "frontend"
      new_bits = 26 - 16
    },
    {
      name     = "backend"
      new_bits = 26 - 16
    },
    {
      name     = "lan"
      new_bits = 24 - 16
    },
    {
      name     = "management"
      new_bits = 24 - 16
    }
  ]
}

module "gw" {
  source   = "../modules/gw"
  basename = "troy"
  extnet   = "frontend"
  intnet   = "backend"
  endpoint = module.common.endpoint
  depends_on = [
    module.common,
  ]
}

module "mgr" {
  source   = "../modules/manager"
  basename = "troy"
  netname  = "management"
  endpoint = module.common.endpoint
  depends_on = [
    module.common,
  ]
}
