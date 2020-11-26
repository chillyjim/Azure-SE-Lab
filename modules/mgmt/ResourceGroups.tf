/* 
  This is where I create all of the resoures groupes I need
*/

resource "azurerm_resource_group" "rg" {
  name     = local.mgr-rg-name
  location = var.location
}