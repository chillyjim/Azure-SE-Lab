variable "location" {
  description = "Location for the vnet REQUIRED"
  type        = string
}

variable "basename" {
  type        = string
  description = "This will be used in locals to build other names REQUIRED"
}

variable "network" {
  type    = string
  default = "10.115"
}

variable "extnet" {
  type        = string
  description = "The name of the gateway's external network"
  default     = "frontend"
}

variable "intnet" {
  type        = string
  description = "The name of the gateway's internal network"
  default     = "backend"
}

variable "mgrsub" {
  type        = string
  description = "The third octet for the management subnet"
  default     = "1"
}

variable "mgrnet" {
  type        = string
  description = "The name of the managers subnet"
  default     = "management"
}

#subscription_id
#client_id
#client_secret
#tenant_id