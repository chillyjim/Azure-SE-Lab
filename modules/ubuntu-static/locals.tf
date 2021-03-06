/*
  Locally constructed varables.
*/

locals {
  vnetname = "${var.basename}-vnet"                                          # The existing vnet
  rgname   = "${var.basename}-rg"                                            # The existing resource group
  location = data.azurerm_resource_group.rg.location                         # Keep everything in the same region
  netid    = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.subnet}" # There is no good way to get the subnet ID so I construct it



  ## Gateway Locals ##
  hostname = var.hostname # If you wish to construct the hostname instead of useing it as is

  int0 = "${local.hostname}-eth0" # Network interface name
  ip0  = "${local.hostname}-ip0"  # Interface IP name
  pip0 = "${local.hostname}-pip0" # Public IP name

  tags = {
    Component   = "user-service"
    Environment = "production"
  }
}