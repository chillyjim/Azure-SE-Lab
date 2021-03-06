variable "basename" {
  type        = string
  description = "This will be used in locals to build other names REQUIRED"
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

variable "endpoint" {
  type        = string
  description = "primary_blob_endpoint"
}

variable "sickey" {
  type        = string
  description = "One time password to establish SIC"
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