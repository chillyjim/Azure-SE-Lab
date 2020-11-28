/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"
  vnetrg   = "${var.basename}-main-rg"

  ## Gateway Locals ##
  gwname   = "${var.basename}-gw"
  gwrgname = "${local.gwname}-rg"
  gwint0   = "${local.gwname}-eth0"
  gwint1   = "${local.gwname}-eth1"
  gwip0    = "${local.gwname}-ip0"
  gwip1    = "${local.gwname}-ip1"
  #  gwip2    = "${var.gwname}-ip2"
  #  gwip3    = "${var.gwname}-ip3"
  #  gwip4    = "${var.gwname}-ip4"
  #  gwip5    = "${var.gwname}-ip5"

  gwpip0 = "${local.gwname}-pip0"

  ## Manager Locals ##
  mgrname     = "${var.basename}-mgr"
  mgr-rg-name = "${local.mgrname}-rg"
  mgrint0     = "${local.mgrname}-eth0"
  mgrip0      = "${local.mgrname}-ip0"

  mgrpip0 = "${local.mgrname}-pip0"
}