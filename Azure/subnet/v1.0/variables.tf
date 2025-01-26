variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "delegations" {
  description = "List of delegations for the subnet"
  type        = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))
}