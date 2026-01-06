variable "name" {
  description = "Name of the Hetzner firewall"
  type        = string
}

variable "labels" {
  description = "User-defined labels (key-value pairs) for the firewall"
  type        = map(string)
  default     = {}
}

variable "rules" {
  description = "List of firewall rules"
  type = list(object({
    direction       = string
    protocol        = string
    port            = optional(string)
    source_ips      = optional(list(string))
    destination_ips = optional(list(string))
    description     = optional(string)
  }))

  validation {
    condition = alltrue([
      for rule in var.rules : contains(["in", "out"], rule.direction)
    ])
    error_message = "Direction must be either 'in' or 'out'."
  }

  validation {
    condition = alltrue([
      for rule in var.rules : contains(["tcp", "udp", "icmp", "esp", "gre"], rule.protocol)
    ])
    error_message = "Protocol must be one of 'tcp', 'udp', 'icmp', 'esp', or 'gre'."
  }
}

variable "server_ids" {
  description = "List of server IDs to attach firewall to"
  type        = list(number)
  default     = []
}

variable "label_selectors" {
  description = "List of label selectors to attach firewall to"
  type        = list(string)
  default     = []
}