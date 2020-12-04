
/*
  This builds out an arbatry number of subnets.
  We feed the module a base CIDR range, an a list
  of network names and sizes. 

  The "dynamic" section itterates through the returned
  list and creates all the subnets
*/
module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.base_cidr_block
  networks        = var.networks
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnetname
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [module.subnet_addrs.base_cidr_block]

  dynamic "subnet" {
    for_each = module.subnet_addrs.network_cidr_blocks
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
}