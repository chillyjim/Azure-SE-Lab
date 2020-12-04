/* Example build out */

terraform {
  required_version = ">= 0.13"
}

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

module "gw" {
  source   = "../modules/gw"
  basename = var.basename
  extnet   = var.externalname
  intnet   = var.internalname
  endpoint = module.common.endpoint
  depends_on = [
    module.common,
  ]
}

module "mgr" {
  source   = "../modules/manager"
  basename = var.basename
  netname  = var.managementname
  endpoint = module.common.endpoint
  depends_on = [
    module.common,
  ]
}

output "Manager_Public_IP_Address" {
  value = module.mgr.Manager_Public_ip
}

module "linuxhost" {
  source   = "../modules/ubuntu"
  basename = var.basename
  hostname = "linux-1"
  subnet   = "lan"
  endpoint = module.common.endpoint
  username = "jlh"
  depends_on = [
    module.common,
  ]
}

output "Linuxhost_public_ip" {
  value = module.linuxhost.Host_public_ip
}

module "linuxDMZ" {
  source   = "../modules/ubuntu"
  basename = var.basename
  hostname = "linux-DMZ"
  subnet   = "lan"
  endpoint = module.common.endpoint
  username = "jlh"
  depends_on = [
    module.common,
  ]
}

output "LinuxDMZ_public_ip" {
  value = module.linuxDMZ.Host_public_ip
}