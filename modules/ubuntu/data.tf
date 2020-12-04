/*
  These were built elsewhere, different module, portal, etc.
  If not built out of the included "common" module, adjust the
  nameing convention in "locals.tf"
*/

data "azurerm_resource_group" "rg" {
  name = local.rgname
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnetname
  resource_group_name = local.rgname
}

data "azurerm_subnet" "mysubnet" {
  name                 = var.subnet
  virtual_network_name = local.vnetname
  resource_group_name  = local.rgname
}