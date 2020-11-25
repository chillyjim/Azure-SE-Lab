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