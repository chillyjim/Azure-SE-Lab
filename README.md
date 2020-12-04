### Use at your own risk 

This project is designed to to build (and eventualy configure) a Check Point lab in Azure,
using Terraform.

The "modules/gw" directory contains the code to build out security gateways, vnets, and subnets.
I will probably be reorgansing this as I expand functionality. More details below and included 
in the comments of each.

The "files" directoy includes any files you need tp pass to the VMs including:
    id_ras.pub -- The public ssh key to log in with
    gwinst -- Which is used to configure the gateway with /etc/cloud_init.py
              I do not yet understand this program, so this part is trial & error
    gwcommands.sh -- This should be passed with gwinst and excuted as a bootstrap script
                     I do not have it working yet.

"lab-gateways" contains an example of how to deploy one or more gateways. The only user file
is "Main.tf" which sources the code in "modules/gw" to create the actual gateways, vnets and subnets.
The basic format is:

module "gw" {
    source = "../modules/gw"
    location = "eastus2"
    basename = "paris"
    #extnet = "Options external network name"
    #intnet = "Optional internal network name"
}

Where:
    gw - Is a tag to refference this particular instance
    source - Is where the module comes from (don't change this)
    ### Required fields 
    location - The Azure region to build in.
    basename - Is the preface of most items names (e.g. paris-gateway)
    network - The first two octets of the vnet's address space (e.g. 10.25.0.0/16)
    ### Optional Fields
    extnet - External network name, defaults to "frontend"
    intnet - Internal network name, defaults to "backend"

The internal & external subnets are created as /25s nothing should be in them execpt the gateways.
The "gw" module is comprised of:

    main.tf (This should move)
      This loads the terraform providers & Azure agreements (Probably not needed 
      if you already agreeded on-line)

    variables.tf
      Defines the varables used by the module (see above.)
      These are referenced as "var.<name>"

    locals.tf
      Creates the derived varables using basename and other locals. 
      These are referenced as "local.<name>"
    
    ResourceGroups.tf
      This creates the resource group, can readily be modified to create more.
      It actually has the code for a seperate gateway and MDS group in it.

    random.tf
      random string generator used for gloably unique names
    
    storage_account.tf
      This creates the storage account used for boot diagnostics. We REALLY want 
      this enabled as it is required for the "Serial console" (so you can 
      "fw unloadlocal"). As I'm not currently setting a password on admin,
      you should do that right away. Passwords are disabled for ssh.

    networking.tf
      This is where all things networking are created. In order (within the file):
      One vnet named basename-vnet (local.vnetname).

      Two subnets for the gateway (var.extnet & var.intnet) each a /25 in the 
      ${var.network}.0 network, e.g. 10.10.0.0/25 (external) and 10.10.0.128/25 
      (internal).

      A routing table (UDR) named rt2gw with a default route to the internal 
      interface of the gateway. Additional routes can be added as needed with 
      additional "route {}" blocks.

      A public IP for the gateway (local.gwpip0) which is attached to the 
      external interface's primary private IP address (local.gwint0).

      Two interfaces for the gateway (local.gwint0 and local.gwint1)

      I am not creating any security groups (NSG), but this is where I would put 
      them. As I generalise this more, I will probably break this up.

    gateway.tf
      This is where I put it all together and create the gateway. 
      See the file itself for documentation.