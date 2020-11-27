# Output the public ip of the gateway
output "Gateway_public_ip" {
    value = azurerm_public_ip.gwpip0.ip_address
}