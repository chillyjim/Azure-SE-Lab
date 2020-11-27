/* 
  This is where I create all of the resoures groupes I need
*/

/* Create the main resource group for all things networking 
 and common across the deployment e.g. bootdiagdisk 

NOTE: I desided to put everything in one group per "site" for 
now. My account was getting messy.
*/
resource "azurerm_resource_group" "rg" {
  name     = local.vnetrg
  location = var.location
}