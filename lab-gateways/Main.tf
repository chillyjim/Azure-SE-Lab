terraform {
  required_version = ">= 0.12"
}

module "gw" {
    source = "../modules/gw"
    location = "eastus2"
    basename = "paris"
    network = "10.25"
    #extnet = "Options external network name"
    #intnet = "Optional internal network name"
}

module "frankford" {
    source = "../modules/gw"
    location = "eastus2"
    basename = "frankford"
    network = "10.25"
    #extnet = "Options external network name"
    #intnet = "Optional internal network name"
}

module "london" {
    source = "../modules/gw"
    location = "eastus2"
    basename = "london"
    network = "10.25"
    #extnet = "Options external network name"
    #intnet = "Optional internal network name"
}