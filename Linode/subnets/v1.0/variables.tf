variable "vpc_id" {
  description = "The ID of the parent VPC for this subnet."
  type        = number
}

variable "subnet_label" {
  description = "Label for the subnet."
  type        = string
}

variable "subnet_ipv4" {
  description = "The IPv4 range of the subnet in CIDR format."
  type        = string
}
