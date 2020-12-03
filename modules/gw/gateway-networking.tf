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





### PIPs for the Gateway ###
resource "azurerm_public_ip" "gwpip0" {
  name                = local.gwpip0
  location            = local.location
  resource_group_name = local.rgname
  allocation_method   = "Static"
}


## The Gateways's interfaces (eth0 & eth1)
## External facing interface ##
resource "azurerm_network_interface" "gweth0" {
  name                          = local.gwint0
  location                      = local.location
  resource_group_name           = local.rgname
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  # Main IP address with the Gateways PIP
  ip_configuration {
    name                          = local.gwip0
    primary                       = true
    subnet_id                     = local.extnetid
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(data.azurerm_subnet.externalnet.address_prefix, 4) # adds 4 to the subnet address
    public_ip_address_id          = azurerm_public_ip.gwpip0.id                         # Built above
  }
}

## The internal interface. This should be the "default gateway" for the other subnets.
resource "azurerm_network_interface" "gweth1" {
  name                          = local.gwint1
  location                      = local.location
  resource_group_name           = local.rgname
  enable_ip_forwarding          = true
  enable_accelerated_networking = true

  ip_configuration {
    name                          = local.gwip1
    primary                       = true
    subnet_id                     = local.intnetid
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(data.azurerm_subnet.internalnet.address_prefix, 4)
  }
}