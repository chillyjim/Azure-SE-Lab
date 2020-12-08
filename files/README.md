### These are files that are pushed out to the virtual machines

* id_rsa.pub -- The public key used for SSH login
* *commands.sh -- This will configure the verious Check Point VMs
** There are two base64 encoded files in these scripts. 
    ssh-keys.b64 - A tar of the server SSH keys I used to replace the auto-generated ones
    setup-commands.b64 - A clish script, mine adds an admin (jlh) account and sets the password for "admin" and "jlh"
      For managers this will run cloud_config.py. For gateways, I just use the blink config.
    setupcommands.sh.txt - I create a header of enviornment varaibles to set the internal route out eth1
      and set the SIC key, then append this file to the new gwcommands.cfg. I will find a better way to do this.
      This is done via the "local-exec" provider in modeles/gw/networking.tf. It is an ugly hack but it works.