variable "location" {
  type        = string
  description = "Region to build in"
  default     = "eastus2"
}

variable "cidr" {
  type        = string
  description = "CIDR range for the vNet"
}

variable "basename" {
  type        = string
  description = "The name we build most of the other names from"
}

variable "externalname" {
  type        = string
  description = "external subnet name"
  default     = "frontend"
}

variable "internalname" {
  type        = string
  description = "internal subnet name"
  default     = "backend"
}

variable "managementname" {
  type        = string
  description = "management subnet name"
  default     = "management"
}

## Additional subnets can be added to the main.tf file.
## Sizes can be changed there as well.

variable "username" {
  type = string
  description = "Workstation's admin user name"
}

variable "password" {
  type = string
  description = "password for abover username"
}

variable "sickey" {
  type = string
  description = "OTP for establish SIC"
  default = "Cpwins1!"
}