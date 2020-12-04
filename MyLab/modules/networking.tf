/* 
  This is where all of the networking eliments live.
  Notes:
      "resource_group_name = azurerm_resource_group.rg.name" is setting
      the resource group where the resource will live. It is being
      derived from the object "rg" that is greated in ResourceGroups.tf
      The same is troy for the location.

      The ".local.<key>" are defined in locals.tf and derived from varables.
      The "var.<key>" uses the varable directly
*/

/* resource "azurerm_subnet" "test" {
  count                = "${length(var.subnet_prefix)}"
  name                 = "testsubnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "${element(var.subnet_prefix, count.index)}"
} /*

## Create the vnet & subnets ##
/* Though in terraform the order doesn't matter I find
   it easer to understand ordered this way.
*/

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "network" {
  type = string
}

variable "subnets" {
  type = map
}

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}



resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.network]
}

## Gateway's external (eth0) and internal (eth1) subnets
resource "azurerm_subnet" "frontend" {
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  count                = "length(var.subnets.name)"
  address_prefix       = "${var.network}.${count.index}"
}


output "location" {
  value = azurerm_resource_group.rg.location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}