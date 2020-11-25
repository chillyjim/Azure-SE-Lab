/* 
  This is where I create all of the resoures groupes I need
*/

## Create the main resource group for all things networking ##
## and common across the deployment e.g. bootdiagdisk ##
resource "azurerm_resource_group" "rg" {
  name     = local.vnetrg
  location = var.location
}

/*
  Not required here
  ## Create the resourse group for the MDS
resource "azurerm_resource_group" "mds-rg" {
  name     = local.mdsrgname
  location = azurerm_resource_group.rg.location
}
*/

# Create the gateway's resource group
#resource "azurerm_resource_group" "rg" {
#  name     = local.rgname
#  location = var.location
#}
#