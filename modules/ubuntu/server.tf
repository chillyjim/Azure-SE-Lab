


resource "azurerm_virtual_machine" "linux" {                                                                    # The second parameter is a reference name
  name                             = local.hostname                                                             # The actual name of the gateway's VM
  location                         = local.location                                                             # The location of it's resource group
  resource_group_name              = local.rgname                                                               # The name of the Resource group
  network_interface_ids            = [azurerm_network_interface.int0.id] # Network interfaces to attach
  primary_network_interface_id     = azurerm_network_interface.int0.id                                        # Which interface is considered primary
  vm_size                          = "Standard_B1s"                                                             # Machine size. Fixed for now.
  delete_data_disks_on_termination = true                                                                       # Without this the disks don't get removed
  delete_os_disk_on_termination    = true                                                                       # Same as above
  #depends_on                       = [azurerm_marketplace_agreement.checkpoint]                                 # Agree to the T&Cs

  ## Next we create a disk for the VM
  storage_os_disk {
    name              = "server-${local.hostname}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  ## Where is the image comming from
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer" # name of the image
    sku       = "18.04-LTS"    # the SKU. sg="Single Gareway" 
    version   = "latest"       # use the lateset version
  }

  ## OS Settings
  os_profile {
    computer_name  = local.hostname
    admin_username = var.username                   # We don't care about this, azure requires it
    #custom_data    = file("../files/hostcommands.sh") # We can feed in a script here. See README.md for more info
  }

  ## I use SSH Keys. Change "key_data" to your public key
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/${var.username}/.ssh/authorized_keys"
    }
  }

  ## We WANT boot diagnostics, it is required for the "serial console" to work
  boot_diagnostics {
    enabled     = "true"
    storage_uri = var.endpoint
  }

}