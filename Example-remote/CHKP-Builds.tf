## Build a Security Gateway

module "gw" {
  source   = "../modules/gw"
  basename = var.basename
  extnet   = var.externalname
  intnet   = var.internalname
  endpoint = module.common.endpoint
  sickey   = var.sickey
  tags = [
    {
      name  = "use"
      value = "gateway"
    },
    {
      name  = "ssh"
      value = "true"
    },
    {
      name  = "os"
      value = "gaia"
    },
    {
      name  = "x-chkp-management"
      value = "tmp-mgr"
    },
    {
      name  = "x-chkp-template"
      value = "central"
    }
  ]
  depends_on = [
    module.common,
    #module.agreements
  ]
}

module "udr" {
  source   = "../modules/routetables"
  basename = var.basename
  networks = [
    var.managementname,
    "lan",
    "dmz",
  ]
  dg = module.gw.lanip
  depends_on = [
    module.common
  ]
}

output "Gateway_Public_IP_Address" {
  value = module.gw.Gateway_public_ip
}

output "Manager_Public_IP_Address" {
  value = module.gw.Manager_Public_ip
}