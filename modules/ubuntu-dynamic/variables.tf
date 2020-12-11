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

variable "endpoint" {
  type        = string
  description = "primary_blob_endpoint for the diagnostic account"
}

variable "username" {
  type        = string
  description = "Admin use name"
}

variable "tags" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "List of tags"
  default = [{
    name  = "notag"
    value = "true"
  }]
}