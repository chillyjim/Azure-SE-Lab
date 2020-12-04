This module builes out the common stuff:
  The virtual network & subnets.
  The resource group.
  The storage account for diagnostics.

Files:
  varables.tf - Input varables.
    basename - Used to construct other names.
    location - Region for everything
    base_cidr_block - CIDR address for the vnet
    network - list if subnets to build


  local.tf - builds deived varables
    vnetname - The name of the vnet, <basename>-vnet
    vnetrg - The name of the resource group, <basename>-rg
    
  networking.tf - Create all the network parts needed. See comments in file.
  resourceGroups.tf - Any resource groups needed. I'm only using one.
  storage_account.tf - The storage account for diagnostics.
  random.tf - a random string for the storage account name.