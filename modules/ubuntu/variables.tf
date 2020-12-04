variable "basename" {
  type        = string
  description = "This will be used in locals to build other names REQUIRED"
}

variable "hostname" {
  type = string
}

variable "subnet" {
  type        = string
  description = "Name of the subnet"
}

variable "endpoint" {
  type        = string
  description = "primary_blob_endpoint"
}

variable "username" {
  type = string
}