### Use at your own risk 

This project is designed to to build (and eventualy configure) a Check Point lab in Azure,
using Terraform. It was bulit because I got tired of doing it by hand. I have tried to make the modules simple and easy to read.

Feel free to use and update as you like. Comments and questions are welcome.

The "modules/gw" directory contains the code to build out security gateways, vnets, and subnets.
I will probably be reorgansing this as I expand functionality. More details below and included 
in the comments of each.

The "files" directoy includes any files you need tp pass to the VMs including:
    id_ras.pub -- The public ssh key to log in with
    *.sh are files passed as custom data. I push a specific set of server ssh-keys and some clish
    commands, including a password hash that gets truncated, so these are base64 encoded. This also
    contains the config_system parametrs for /etc/cloud_config.py

Example-Build is just that. It will build out a vnet, four subnets, a gateway, a manager & two Ubuntu hosts

The module directory contains everything I build, each of the modules and the .tf files are directly documented. for specifics look there.
The modules are:
  common -- builds the common infrastructure
  gw -- builds a gateway (R81)
  manager -- a manager (R81)
  unbutu -- a linux host

To be build:
  Windows10 - Windows box
  WinServer - Wondows server
  mds - a Check Point MDS
  cluster - Check Point Cluster
  vmms - Check Point as a scale set

