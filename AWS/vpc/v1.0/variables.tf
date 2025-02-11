variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones to use for the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT gateways"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the VPC and its resources"
  type        = map(string)
  default     = {}
}