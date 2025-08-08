variable "name" {
  type    = string
  default = "my-server"
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