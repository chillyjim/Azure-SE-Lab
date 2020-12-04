resource "azurerm_windows_virtual_machine" "win10" {
  name                  = local.hostname
  resource_group_name   = local.rgname
  location              = local.location
  size                  = "Standard_F2"
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = [azurerm_network_interface.int0.id]

  os_disk {
    name                 = "windisc-${local.hostname}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10" # name of the image
    sku       = "19h2-pro"   # the SKU.  
    version   = "latest"     # use the lateset version
  }
}