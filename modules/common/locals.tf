/*
  Locally constructed varables.
  There has to be a better way to do this.
*/

locals {
  vnetname = "${var.basename}-vnet"
  vnetrg   = "${var.basename}-rg"


}