This will build a simple Unbutu VM with a public IP address (static) and a dynamic private IP.
If don't know how to tell terraform to use the "next available" private IP.

A not of Storage account, the "azure_windows_virtual_machine" provider doesn't allow for blob storage,
so for diagnostics, you need to use managed storage disks. 

Files:
  varables.tf - Input varables.
    basename - Used to construct other names.
    hostname - The name of the host. Can be altered in locals.tf.
    subnet - Subnet to be place in.
    username - The administrative user. NOTE: I use ssh keys for login, no password is set.

  data.tf - Gathers information from existing resources.
    Resource group, virtual network, subnet

  local.tf - builds deived varables
    vnetname - The name of the vnet, <basename>-vnet
    rgname - The name of the resource group, <basename>-rg
    location - The location of the resource group. This comes from data.tf
    netid - The resource id for the subnet. There is no direct way to retrive it so it has to be constructed.
    hostname - The hostname of the VM. By default it is just var.hostname.
    int0 - Network interface name
    ip0 - IP configuration name
    pip0 - Public IP address name

  networking.tf - Create all the network parts needed. See comments in file.
  windows.tf - The actual VM configuration. 
  outputs.tf - Return values.