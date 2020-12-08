/* 
  This is where all of the networking eliments live.
  Notes:
    local.<key> are derived names from local.tf
  
*/


/*
  Public IP address for the host.
  If you do not need/want a Public IP, comment out this block
  and "public_ip_address_id" in the "ip_configuration" section
*/
/* Not using a PIP on this one
resource "azurerm_public_ip" "pip0" {
  name                = local.pip0
  location            = local.location
  resource_group_name = local.rgname
  allocation_method   = "Static" # "Static" or "Dynamic"
}
*/

# The host's interface 
resource "azurerm_network_interface" "int0" {
  name                          = local.int0
  location                      = local.location
  resource_group_name           = local.rgname
  enable_ip_forwarding          = false # Only set to "true" on routers/gateways
  enable_accelerated_networking = false # Not supported on the default size VM

  # IP address 
  ip_configuration {
    name                          = local.ip0
    primary                       = true
    subnet_id                     = data.azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    #  public_ip_address_id          = azurerm_public_ip.pip0.id # Built above
  }
}