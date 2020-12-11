/*
  This will build out an Ubuntu host.
  local.<key> are derived names from "locals.tf"
*/

resource "azurerm_virtual_machine" "linux" {                             # The second parameter is a reference name
  name                             = local.hostname                      # The actual name of the host's VM
  location                         = local.location                      # The location of it's resource group
  resource_group_name              = local.rgname                        # The name of the Resource group
  network_interface_ids            = [azurerm_network_interface.int0.id] # Network interfaces to attach
  primary_network_interface_id     = azurerm_network_interface.int0.id   # Which interface is considered primary
  vm_size                          = "Standard_B1s"                      # Machine size. Fixed for now.
  delete_data_disks_on_termination = true                                # Without this the disks don't get removed
  delete_os_disk_on_termination    = true                                # Same as above


  ## Next we create a disk for the VM
  storage_os_disk {
    name              = "server-${local.hostname}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  ## Where is the image comming from. I have yet to figure out a good
  ## way to get this info other than deploying from the market place
  ## and looking at the template generated
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer" # name of the image
    sku       = "18.04-LTS"    # the SKU.  
    version   = "latest"       # use the lateset version
  }

  ## OS Settings
  os_profile {
    computer_name  = local.hostname
    admin_username = var.username # This user will be added to /etc/sudoers with full rights
    #custom_data    = file("../files/hostcommands.sh") # We can feed in a script or just commands to be excuted after boot
  }

  ## I use SSH Keys. Change "key_data" to your public key
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("../files/id_rsa.pub")
      path     = "/home/${var.username}/.ssh/authorized_keys"
    }
  }

  ## We WANT boot diagnostics, it is required for the "serial console" to work
  boot_diagnostics {
    enabled     = "true"
    storage_uri = var.endpoint
  }
  tags = {
    for tag in var.tags :
    tag.name => tag.value
  }
}