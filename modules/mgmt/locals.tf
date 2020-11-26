/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetrg   = "${var.basename}-main-rg" # The existing vnet's resource group


  ## Manager Locals ##
  mgrname     = "${var.basename}-mgr"
  mgr-rg-name = "${local.mgrname}-rg"
  mgrint0     = "${local.mgrname}-eth0"
  mgrip0      = "${local.mgrname}-ip0"

  mgrpip0 = "${local.mgrname}-pip0"
}