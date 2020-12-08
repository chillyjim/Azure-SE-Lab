/*
  This will create a Check Point Manager.
  local.<key> are derived names from "locals.tf"
*/

resource "azurerm_virtual_machine" "mgr01" {                                    # The second parameter is a reference name
  name                             = local.mgrname                              # The actual name of the host's VM
  location                         = local.location                             # The location of it's resource group
  resource_group_name              = local.rgname                               # The name of the Resource group
  network_interface_ids            = [azurerm_network_interface.mgreth0.id]     # Network interfaces to attach
  primary_network_interface_id     = azurerm_network_interface.mgreth0.id       # Which interface is considered primary
  vm_size                          = "Standard_DS2_v2"                          # Machine size. Fixed for now.
  delete_data_disks_on_termination = true                                       # Without this the disks don't get removed
  delete_os_disk_on_termination    = true                                       # Same as above
  #depends_on                       = [azurerm_marketplace_agreement.chkp-mgmt-byol] # Agree to the T&Cs

  ## The disk for the VM
  storage_os_disk {
    name              = "R81sDisk-${local.mgrname}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  ## Where is the image comming from. I have yet to figure out a good
  ## way to get this info other than deploying from the market place
  ## and looking at the template generated
  storage_image_reference {
    publisher = "checkpoint"
    offer     = "check-point-cg-r81"
    sku       = "mgmt-byol"
    version   = "latest"
  }

  ## The billing plan, like above on how to get the info
  plan {
    name      = "mgmt-byol"
    publisher = "checkpoint"
    product   = "check-point-cg-r81"
  }

  ## The GAIA configuration
  os_profile {
    computer_name  = local.mgrname                    # hostname
    admin_username = "notused"                        # We are always "admin"
    custom_data    = file("../files/mgmtcommands.sh") # bootstrap script
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("../files/id_rsa.pub")
      path     = "/home/notused/.ssh/authorized_keys"
    }
  }

  ## We need boot diagnostic for the serial console. NOTE: make sure you set a password. 
  ## Look at ../files/mgrinit for an example.
  boot_diagnostics {
    enabled     = "true"
    storage_uri = var.endpoint
  }
}