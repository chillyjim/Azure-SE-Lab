output "Gateway_Public-IP_Address" {
  value = module.gw.Gateway_public_ip
}

output "Manager_Public_IP_Address" {
  value = module.mgr.Manager_Public_ip
}