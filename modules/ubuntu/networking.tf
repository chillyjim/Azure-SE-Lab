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
resource "azurerm_public_ip" "pip0" {
  name                = local.pip0
  location            = local.location
  resource_group_name = local.rgname
  allocation_method   = "Static"
}

## The Gateways's interfaces (eth0 & eth1)
## External facing interface ##
resource "azurerm_network_interface" "int0" {
  name                          = local.int0
  location                      = local.location
  resource_group_name           = local.rgname
  enable_ip_forwarding          = true
  enable_accelerated_networking = false

  # Main IP address with the Gateways PIP
  ip_configuration {
    name                          = local.ip0
    primary                       = true
    subnet_id                     = local.netid
    private_ip_address_allocation = "Dynamic"
   # private_ip_address            = cidrhost(data.azurerm_subnet.mysubnet.address_prefix, 4) # adds 4 to the subnet address
    public_ip_address_id          = azurerm_public_ip.pip0.id                               # Built above
  }
}