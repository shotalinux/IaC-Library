variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}

variable "location" {
  description = "The location/region where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet within the virtual network."
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = string
}