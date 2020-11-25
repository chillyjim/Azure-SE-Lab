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

## Create the vnet & subnets ##
/* Though in terraform the order doesn't matter I find
   it easer to understand ordered this way.
*/
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnetname
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["${var.network}.0.0/16"]
}

## Gateway's external (eth0) and internal (eth1) subnets
resource "azurerm_subnet" "frontend" {
  name                 = var.extnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "${var.network}.0.0/25"
}

resource "azurerm_subnet" "backend" {
  name                 = var.intnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "${var.network}.0.128/25"
}

### Routing Tables (UDR) ###
resource "azurerm_route_table" "rt2gw" {
  name                          = "rt2gw"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = true

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.gweth1.private_ip_address # Like name & location, this is a refference value
  }

  tags = {
    environment = "Production"
  }
}

### Network interfaces ###
/*
  I build the NICs and PIPs here so if I want to destroy and rebuild a VM
  I can and get back the same addresses. It also save a little bit of time.
*/

### PIPs for the Gateway ###
resource "azurerm_public_ip" "gwpip0" {
  name                = local.cwpip0
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}


## The Gateways's interfaces (eth0 & eth1)
## External facing interface ##
resource "azurerm_network_interface" "gweth0" {
  name                          = local.gwint0
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  # Main IP address with the Gateways PIP
  ip_configuration {
    name                          = local.gwip0
    primary                       = true
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.frontend.address_prefix, 4) # adds 4 to the subnet address
    public_ip_address_id          = azurerm_public_ip.gwpip0.id                         # Built above
  }
}

## The internal interface. This should be the "default gateway" for the other subnets.
resource "azurerm_network_interface" "gweth1" {
  name                          = local.gwint1
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = local.gwip1
    primary                       = true
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(azurerm_subnet.backend.address_prefix, 4)
  }
}


### Security Groups ###