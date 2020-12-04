# Output the public ip of the gateway
output "Host_public_ip" {
  value = azurerm_public_ip.pip0.ip_address
}