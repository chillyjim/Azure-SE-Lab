This module builes out a Check Point primary manager version R81

Files:
  varables.tf - Input varables.
    basename - Used to construct other names.
    netname - Subnet to be place in.
    endpoint - The storage account for the diagnostics.

  data.tf - Gathers information from existing resources.
    Resource group, virtual network, subnet

  local.tf - builds deived varables
    vnetname - The name of the vnet, <basename>-vnet
    rgname - The name of the resource group, <basename>-rg
    location - The location of the resource group. This comes from data.tf
    mgrname - The hostname of the VM, <basename>-mgr
    mgrint0 - Network interface name
    mgrip0 - IP configuration name
    mgrpip0 - Public IP address name

  main.tf - Marketplace aggerments and dependancies. 
  networking.tf - Create all the network parts needed. See comments in file.
  manager.tf - The actual VM configuration. 
  outputs.tf - Return values.