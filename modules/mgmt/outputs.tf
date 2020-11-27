# Output the public ip of the manager
output "Manager_Public_ip" {
    value = azurerm_public_ip.mgrpip0.ip_address
}