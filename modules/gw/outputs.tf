# Output the public ip of the gateway
output "Gateway_public_ip" {
  value = azurerm_public_ip.gwpip0.ip_address
}

output "Manager_Public_ip" {
  value = azurerm_public_ip.gwpip1.ip_address
}

output "lanip" {
  value = azurerm_network_interface.gweth1.ip_configuration[0].private_ip_address
}