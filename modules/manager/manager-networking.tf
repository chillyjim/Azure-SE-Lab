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


### Network interfaces ###
/*
  I build the NICs and PIPs here so if I want to destroy and rebuild a VM
  I can and get back the same addresses. It also save a little bit of time.
*/

### PIPs for the Manager ###
resource "azurerm_public_ip" "mgrpip0" {
  name                = local.mgrpip0                      # Derived name for the public IP address
  location            = local.location # Retrive the resource group's name
  resource_group_name = local.rgname     # and location
  allocation_method   = "Static"                           # Options are "Static" or "Dynamic" we want static to keep the IP Address
}

## The Managers's interfaces
resource "azurerm_network_interface" "mgreth0" {
  name                          = local.mgrint0                      # Derived name for the interface in Azure (not the OS name)
  location                      = local.location # Retrive the resource group's name
  resource_group_name           = local.rgname     # and location
  enable_ip_forwarding          = false                              # The manager doesn't forward traffic
  enable_accelerated_networking = true

  # Main IP address with the Managers PIP
  ip_configuration {
    name                          = local.mgrip0
    primary                       = true
    subnet_id                     = data.azurerm_subnet.mgrnetname.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(data.azurerm_subnet.mgrnetname.address_prefix, 4) # adds 4 to the subnet address
    public_ip_address_id          = azurerm_public_ip.mgrpip0.id                      # Built above
  }
}