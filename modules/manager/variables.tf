
variable "basename" {
  type        = string
  description = "This will be used in locals to build other names REQUIRED"
}

variable "netname" {
  type        = string
  description = "The name of the managers subnet"
  default     = "management"
}

variable "endpoint" {
  type = string
}