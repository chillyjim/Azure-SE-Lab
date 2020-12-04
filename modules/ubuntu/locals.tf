/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"
  rgname   = "${var.basename}-rg"
  location = data.azurerm_resource_group.rg.location
  netid    = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.subnet}"



  ## Gateway Locals ##
  hostname = var.hostname

  int0    = "${local.hostname}-eth0"
  ip0 = "${local.hostname}-ip0"

  pip0 = "${local.hostname}-pip0"
}