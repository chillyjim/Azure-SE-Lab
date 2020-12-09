module "common" {
  source          = "../modules/common/"
  location        = var.location
  basename        = var.basename
  base_cidr_block = var.cidr
  networks = [
    {
      name     = var.externalname
      new_bits = 26 - 16
    },
    {
      name     = var.internalname
      new_bits = 26 - 16
    },
    {
      name     = var.managementname
      new_bits = 26 - 16
    },
    {
      name     = "lan"
      new_bits = 24 - 16
    },
    {
      name     = "dmz"
      new_bits = 24 - 16
    }
  ]
}



