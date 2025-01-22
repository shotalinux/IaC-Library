variable "inbound_rules" {
  description = "List of inbound rules"
  type = list(object({
    label    = string
    action   = string
    protocol = string
    ports    = string
    ipv4     = list(string)
    ipv6     = list(string)
  }))
  default = []
}

variable "outbound_rules" {
  description = "List of outbound rules"
  type = list(object({
    label    = string
    action   = string
    protocol = string
    ports    = string
    ipv4     = list(string)
    ipv6     = list(string)
  }))
  default = []
}

variable "firewall_label" {
  description = "Label for the firewall"
  type        = string
}

variable "inbound_policy" {
  description = "Default inbound policy"
  type        = string
  default     = "DROP"
}

variable "outbound_policy" {
  description = "Default outbound policy"
  type        = string
  default     = "ACCEPT"
}

variable "linode_ids" {
  description = "List of Linode instance IDs to attach to the firewall"
  type        = list(string)
  default     = []
}
