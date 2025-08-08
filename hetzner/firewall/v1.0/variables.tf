variable "name" {
  description = "Name of the Hetzner firewall"
  type        = string
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