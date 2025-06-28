variable "server_name" {
  description = "Name of the Hetzner server"
  type        = string
}

variable "server_image" {
  description = "OS image to use for the server"
  type        = string
  default     = "debian-11"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cx22"
}

variable "ipv4_enabled" {
  description = "Enable public IPv4 networking"
  type        = bool
  default     = true
}

variable "ipv6_enabled" {
  description = "Enable public IPv6 networking"
  type        = bool
  default     = true
}