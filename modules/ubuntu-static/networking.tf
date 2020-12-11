/* 
  This is where all of the networking eliments live.
  Notes:
    local.<key> are derived names from local.tf
  
*/

resource "azurerm_public_ip" "pip0" {  # Here we generate a public IP (PIP)
  name                = local.pip0     # Nam of this PIP
  location            = local.location # Where it lives
  resource_group_name = local.rgname   # Resource Group Name
  allocation_method   = "Static"       # Keep the same PIP if you turn off the VM or Dynamic if you don't care
}

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
    private_ip_address_allocation = "Static"    # Dynamic or Static
    private_ip_address            = var.ip_addr # Directly assign the IP address
    # I have not found a way to generate "The next availible IP Address"
    # if you want to attach the PIP to the host, uncomment the next line
    # public_ip_address = azurerm_public_ip.pip0.id # This will assign the IP to the interface
    # I make the assumption it will go on the GW
  }
}