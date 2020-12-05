/* 
  All varables are required
*/

variable "basename" {
  type        = string
  description = "This will be used in locals to build other names REQUIRED"
}

variable "hostname" {
  type        = string
  description = "The name of the host"
}

variable "subnet" {
  type        = string
  description = "Name of the subnet"
}

variable "username" {
  type        = string
  description = "Admin use name"
}

variable "password" {
  type        = string
  description = "user's password"
}