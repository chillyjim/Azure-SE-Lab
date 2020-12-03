data "azurerm_resource_group" "rg" {
  name = local.rgname
}

data "azurerm_virtual_network" "vnet" {
  name                 = local.vnetname
  resource_group_name  = local.rgname
}

data "azurerm_subnet" "mgrnetname" {
  name                 = var.netname
  virtual_network_name = local.vnetname
  resource_group_name  = local.rgname
}