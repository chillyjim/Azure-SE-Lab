data "azurerm_resource_group" "rg" {
  name = local.vnetrg
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnetname
  resource_group_name = local.vnetrg
}