/* This for now anyway is just grabing the providers
   I suspect I'll also pull the modules in here that I need eventaly as I learn how to use them */

terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "=1.44.0"

  #subscription_id = var.subscription_id
  #client_id = var.client_id
  #client_secret = var.client_secret
  #tenant_id = var.tenant_id
}

provider "random" {
  version = "= 2.2.1"
}

# Agreements

# Create virtual machine and Accept the agreement for the mgmt-byol for R80.40
resource "azurerm_marketplace_agreement" "checkpoint" {
  publisher = "checkpoint"
  offer     = "check-point-cg-r81"
  plan      = "mgmt-byol"
}

## I think this is needed to approve the market place agreement. I have to test that.
resource "azurerm_marketplace_agreement" "chkp-gw" {
  publisher = "checkpoint"
  offer     = "check-point-cg-r81"
  plan      = "sg-byol"
}