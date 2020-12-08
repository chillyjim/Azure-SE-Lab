/*
  This will generate the a gateway with the name <BASENAME>-gw
*/

## This is how we build a vm
resource "azurerm_virtual_machine" "gw" {                                                                       # The second parameter is a reference name
  name                             = local.gwname                                                               # The actual name of the gateway's VM
  location                         = local.location                                                             # The location of it's resource group
  resource_group_name              = local.rgname                                                               # The name of the Resource group
  network_interface_ids            = [azurerm_network_interface.gweth0.id, azurerm_network_interface.gweth1.id] # Network interfaces to attach
  primary_network_interface_id     = azurerm_network_interface.gweth0.id                                        # Which interface is considered primary
  vm_size                          = "Standard_DS2_v2"                                                          # Machine size. Fixed for now.
  delete_data_disks_on_termination = true                                                                       # Without this the disks don't get removed
  delete_os_disk_on_termination    = true                                                                       # Same as above
  #depends_on                       = [azurerm_marketplace_agreement.chkp-sg-byol]                                 # Agree to the T&Cs
  depends_on = [
    azurerm_network_interface.gweth1
  ]

  ## Next we create a disk for the VM
  storage_os_disk {
    name              = "R81sDisk-${local.gwname}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  ## Where is the image comming from
  storage_image_reference {
    publisher = "checkpoint"
    offer     = "check-point-cg-r81" # name of the image
    sku       = "sg-byol"            # the SKU. sg="Single Gareway" 
    version   = "latest"             # use the lateset version
  }
  ## This will match above
  plan {
    name      = "sg-byol"
    publisher = "checkpoint"
    product   = "check-point-cg-r81"
  }
  ## OS Settings
  os_profile {
    computer_name  = local.gwname                   # hostname
    admin_username = "notused"                      # We don't care about this, azure requires it
    custom_data    = file("../files/gwcommands.sh") # We can feed in a script here. See README.md for more info
  }

  ## I use SSH Keys. Change "key_data" to your public key
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/notused/.ssh/authorized_keys"
    }
  }

  ## We WANT boot diagnostics, it is required for the "serial console" to work.
  ## NOTE: set a password for admin. 
  boot_diagnostics {
    enabled     = "true"
    storage_uri = var.endpoint
  }

}