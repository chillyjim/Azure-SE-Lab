/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"                  # Name of the virtual network
  rgname   = "${var.basename}-rg"                    # My resource group
  location = data.azurerm_resource_group.rg.location # The region I'm using
  gwname = "${var.basename}-gw"


  # Manager Locals #
  mgrname = "${var.basename}-mgr"   # Manager's hostname 
  mgrint0 = "${local.mgrname}-eth0" # Interface name
  mgrip0  = "${local.mgrname}-ip0"  # IP configuration name
  mgrpip0 = "${local.mgrname}-pip0" # Public IP address name
}