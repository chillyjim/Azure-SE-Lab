This will build a simple Unbutu VM with a public IP address (static) and a dynamic private IP.
If don't know how to tell terraform to use the "next available" private IP

Files:
  varables.tf - Input varables.
    basename - Used to construct other names.
    hostname - The name of the host. Can be altered in locals.tf.
    subnet - Subnet to be place in.
    ip_addr - The assigned private IP address
    endpoint - The storage account for the diagnostics.
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
    pip0 - Public IP address name; I'm assuming if it is static, you will want to IT

  networking.tf - Create all the network parts needed. See comments in file.
  server.tf - The actual VM configuration. 
  outputs.tf - Return values.