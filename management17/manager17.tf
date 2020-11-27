terraform {
  required_version = ">= 0.12"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "basename" {
  type    = string
  default = "mgmt"
}

variable "network" {
  type    = string
  default = "10.16"
}

variable "mgrsub" {
  type    = string
  default = "1"
}

variable "extnet" {
  type    = string
  default = "frontend"
}

variable "intnet" {
  type    = string
  default = "backend"
}

variable "mgrnet" {
  type    = string
  default = "management"
}

module "mgr" {
  source   = "../modules/mgmt2"
  location = var.location
  basename = var.basename
  network  = var.network
  mgrsub   = var.mgrsub
  mgrnet  = var.mgrnet
  extnet   = var.extnet
  intnet   = var.intnet
}