/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"
  rgname   = "${var.basename}-rg"
  location = data.azurerm_resource_group.rg.location
  intnetid = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.netname}"


  # Manager Locals #
  mgrname     = "${var.basename}-mgr"
  mgr-rg-name = "${local.mgrname}-rg"
  mgrint0     = "${local.mgrname}-eth0"
  mgrip0      = "${local.mgrname}-ip0"

  mgrpip0 = "${local.mgrname}-pip0"
}