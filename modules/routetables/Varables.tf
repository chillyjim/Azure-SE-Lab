variable "basename" {
  type        = string
  description = "This is what we build all the names off of"
}

variable "networks" {
  type        = list(string)
  description = "Subnet names to apply this table to"
}

variable "dg" {
  type        = string
  description = "Default Gateway"
}