variable "delete_protection" {
  description = "Enable delete protection for the network"
  type        = bool
  default     = false 
}

variable "expose_routes_to_vswitch" {
  description = "Expose routes to the virtual switch"
  type        = bool
  default     = false
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "ip_range" {
  description = "IP range of the network in CIDR notation"
  type        = string
}

variable "subnet_type" {
  description = "Type of the subnet (e.g., cloud, server)"
  type        = string
  default     = "cloud"
}

variable "subnet_ip_range" {
  description = "IP range of the subnet in CIDR notation"
  type        = string
}

variable "network_zone" {
  description = "Network zone for the subnet"
  type        = string
  default     = "eu-central"
}

variable "route_destination" {
  description = "Destination for the network route in CIDR notation"
  type        = string
}

variable "route_gateway" {
  description = "Gateway for the network route"
  type        = string
}

variable "network_labels" {
  description = "Labels to apply to the network"
  type        = map(string)
  default     = {}
}

variable "enable_route" {
  description = "Enable creation of a network route"
  type        = bool
  default     = false
}