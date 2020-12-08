/*
  Locally constructed varables.
*/

locals {
  vnetname = "${var.basename}-vnet"                  # The existing vnet
  rgname   = "${var.basename}-rg"                    # The existing resource group
  location = data.azurerm_resource_group.rg.location # Keep everything in the same region



  ## Gateway Locals ##
  hostname = var.hostname # If you wish to construct the hostname instead of useing it as is

  int0 = "${local.hostname}-eth0" # Network interface name
  ip0  = "${local.hostname}-ip0"  # Interface IP name
  pip0 = "${local.hostname}-pip0" # Public IP name
}