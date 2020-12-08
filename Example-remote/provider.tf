/*
 Any prvider we need other than Terraform itself
*/
provider "azurerm" {
  version = "2.39.0"
  features {}
}

provider "random" {
  version = "= 2.2.1"
}