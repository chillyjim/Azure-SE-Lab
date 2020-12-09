/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"
  rgname   = "${var.basename}-rg"
  location = data.azurerm_resource_group.rg.location
  intnetid = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.intnet}"
  extnetid = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.extnet}"



  ## Gateway Locals ##
  gwname   = "${var.basename}-gw"
  gwrgname = "${local.gwname}-rg"
  gwint0   = "${local.gwname}-eth0"
  gwint1   = "${local.gwname}-eth1"
  gwip0    = "${local.gwname}-ip0"
  gwip1    = "${local.gwname}-ip1"
  gwip2    = "${local.gwname}-ip2"

  gwpip0 = "${local.gwname}-pip0"
  gwpip1 = "${local.gwname}-pip1" # not used for naming consistancy
  gwpip2 = "${local.gwname}-pip2"
}

