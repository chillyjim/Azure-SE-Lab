/* 
  This is where all of the networking eliments live.
  Notes:
    local.<key> are derived names from local.tf
  
*/

resource "azurerm_network_interface" "int0" {    # Here is where we build the network interface
  name                          = local.int0     # Name of the interface
  location                      = local.location # Where it lives
  resource_group_name           = local.rgname   # Resource Group
  enable_ip_forwarding          = false          # Only set to "true" on routers/gateways
  enable_accelerated_networking = false          # Not supported on the default size VM

  # In Azure, interfaces may have multipul IP addresses, each in an ip_configuration block
  ip_configuration {
    name                          = local.ip0   # This is tbe
    primary                       = true        # One IP has to be the primary
    subnet_id                     = local.netid # What subnet
    private_ip_address_allocation = "Dynamic"   # Dynamic or Static
    # I have not found a way to generate "The next availible IP Address"
  }
}