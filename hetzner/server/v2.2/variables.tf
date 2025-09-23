variable "namepref" {
  description = "Prefix for naming servers. Ignored if nameslist is set."
  type        = string
  default     = null
}

variable "nameslist" {
  description = "Explicit list of server names. Overrides namepref/replicas if provided."
  type        = list(string)
  default     = []
}

variable "replicas" {
  description = "Number of servers to create (used with namepref)."
  type        = number
  default     = 1
}

variable "suffix_style" {
  description = "Style of suffix for replica naming: 'numeric' or 'alpha'."
  type        = string
  default     = "numeric"
}

variable "zero_padding" {
  description = "Zero-padding width for numeric suffixes (e.g., 2 -> 01, 02)."
  type        = number
  default     = 0
}

variable "server_type" {
  type    = string
  default = "cx22"
}

variable "image" {
  type    = string
  default = "debian-11"
}

variable "location" {
  type    = string
  default = null
}

variable "datacenter" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "public_net" {
  type = object({
    ipv4_enabled = bool
    ipv4         = optional(string)
    ipv6_enabled = bool
  })
  default = {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

variable "keep_disk" {
  type    = bool
  default = false
}

variable "iso" {
  type    = string
  default = null
}

variable "rescue" {
  type    = string
  default = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "backups" {
  type    = bool
  default = false
}

variable "firewall_ids" {
  type    = list(string)
  default = []
}

variable "ignore_remote_firewall_ids" {
  type    = bool
  default = false
}

variable "networks" {
  type = list(object({
    network_id = number
    ip         = optional(string)
    alias_ips  = optional(list(string))
  }))
  default = []
}

variable "placement_group_id" {
  type    = string
  default = null
}

variable "delete_protection" {
  type    = bool
  default = false
}

variable "rebuild_protection" {
  type    = bool
  default = false
}

variable "allow_deprecated_images" {
  type    = bool
  default = false
}

variable "shutdown_before_deletion" {
  type    = bool
  default = false
}