variable "vpc_label" {
  description = "Label for the VPC."
  type        = string
  default     = "exampleVPC"
}

variable "region" {
  description = "The region to deploy the Linode VPC in."
  type        = string
  default     = "fr-par"
}

variable "vpc_description" {
  description = "Description for the VPC."
  type        = string
  default     = "My first VPC."
}
