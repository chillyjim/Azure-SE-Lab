/*
  This will create a Check Point Manager. For now I'm just stealing code the
  gw module, until I generalise it more.
*/

resource "azurerm_virtual_machine" "mgr01" {
  name                             = local.mgrname
  location                         = local.location
  resource_group_name              = local.rgname
  network_interface_ids            = [azurerm_network_interface.mgreth0.id]
  primary_network_interface_id     = azurerm_network_interface.mgreth0.id
  vm_size                          = "Standard_DS2_v2"
  delete_data_disks_on_termination = true                                       # Without this the disks don't get removed
  delete_os_disk_on_termination    = true                                       # Same as above
  depends_on                       = [azurerm_marketplace_agreement.checkpoint] # Agree to the T&Cs

  storage_os_disk {
    name              = "R81sDisk-${local.mgrname}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "checkpoint"
    offer     = "check-point-cg-r81"
    sku       = "mgmt-byol"
    version   = "latest"
  }

  plan {
    name      = "mgmt-byol"
    publisher = "checkpoint"
    product   = "check-point-cg-r81"
  }
  os_profile {
    computer_name  = local.mgrname
    admin_username = "notused"
    custom_data    = file("../files/mgmtcommands.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("../files/id_rsa.pub")
      path     = "/home/notused/.ssh/authorized_keys"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = var.endpoint
  }

}