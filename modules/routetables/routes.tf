
## Create the routing table(s)
resource "azurerm_route_table" "viagw" {
  name                          = "${var.basename}-viagw"
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name           = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = var.dg
  }
}

resource "azurerm_subnet_route_table_association" "udr1" {
  for_each = toset(var.networks)
  route_table_id = azurerm_route_table.viagw.id
  subnet_id      = "${data.azurerm_virtual_network.vnet.id}/subnets/${each.key}"
}