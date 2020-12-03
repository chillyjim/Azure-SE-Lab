variable "basename" {
  type        = string
  description = "This is what we build all the names off of"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "base_cidr_block" {
  type        = string
  description = "The CIDR block to use for the vnet"
}

variable "networks" {
  type = list(object({
    name     = string
    new_bits = number
  }))
  description = "Subnet names and sizes"
}