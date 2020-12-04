/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"                  # Name of the virtual network
  rgname   = "${var.basename}-rg"                    # My resource group
  location = data.azurerm_resource_group.rg.location # The region I'm using
  #netid = "${data.azurerm_virtual_network.vnet.id}/subnets/${var.netname}" left here for reference on how to construct the subnet id


  # Manager Locals #
  mgrname = "${var.basename}-mgr"   # Manager's hostname 
  mgrint0 = "${local.mgrname}-eth0" # Interface name
  mgrip0  = "${local.mgrname}-ip0"  # IP configuration name
  mgrpip0 = "${local.mgrname}-pip0" # Public IP address name
}