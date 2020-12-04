terraform {
  required_version = ">= 0.12"
}

module "troy" {
  source   = "./modules/"
  location = "eastus2"
  name     = "troy"
  network  = "10.200.0.0/16"
  subnets = {
    name = [frontend, backend, lan]
    size = [25, 25, 24]
  }
}


output "subnets" {
  value = module.troy.name
}