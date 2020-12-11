module "linuxhost1" {
  source   = "../modules/ubuntu-dynamic"
  basename = var.basename
  hostname = "linux-1"
  subnet   = "lan"
  endpoint = module.common.endpoint
  username = var.username
  depends_on = [
    module.common,
  ]
}

module "linuxDMZ1" {
  source   = "../modules/ubuntu-static"
  basename = var.basename
  hostname = "linux-DMZ"
  subnet   = "dmz"
  ip_addr  = "10.200.2.4"
  endpoint = module.common.endpoint
  username = var.username
  tags = [
    {
      name  = "use"
      value = "web"
    },
    {
      name  = "ssh"
      value = "true"
    },
    {
      name  = "os"
      value = "linux"
    }
  ]
  depends_on = [
    module.common,
  ]
}

output "LinuxDMZ_public_ip" {
  value = module.linuxDMZ1.Host_public_ip
}


module "win10" {
  source   = "../modules/win10"
  basename = var.basename
  hostname = "Windows"
  subnet   = "lan"
  username = var.username
  password = var.password
  tags = [
    {
      name  = "use"
      value = "workstation"
    },
    {
      name  = "ssh"
      value = "false"
    },
    {
      name  = "os"
      value = "win10"
    }
  ]

  depends_on = [
    module.common,
  ]
}

/*
module "win2019" {
  source   = "../modules/winserver"
  basename = var.basename
  hostname = "winserver"
  subnet   = "dmz"
  username = var.username
  password = var.password
  depends_on = [
    module.common,
  ]
}
*/