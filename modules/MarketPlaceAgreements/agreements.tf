## Marketplace aggrements and any additional providers 

terraform {
  required_version = ">= 0.13"
}

provider "azurerm" {
  version = "2.39.0"
  features {}
}

# Agreements

## Create virtual machine and Accept the agreement for the mgmt-byol for R80.40
resource "azurerm_marketplace_agreement" "chkp-mgmt-byol" {
  publisher = "checkpoint"
  offer     = "check-point-cg-r81"
  plan      = "mgmt-byol"
}

## I think this is needed to approve the market place agreement. I have to test that.
resource "azurerm_marketplace_agreement" "chkp-sg-byol" {
  publisher = "checkpoint"
  offer     = "check-point-cg-r81"
  plan      = "sg-byol"
}