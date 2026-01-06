# -------------------------
# Core Inputs
# -------------------------
variable "names" {
  description = "List of names for the servers."
  type        = list(string)
}

variable "server_type" {
  description = "Default server type (e.g., cx22)."
  type        = string
  default     = "cx22"
}

variable "image" {
  description = "Default OS image."
  type        = string
  default     = "debian-11"
}

variable "location" {
  description = "Default location (e.g., fsn1)."
  type        = string
  default     = null
}

variable "datacenter" {
  description = "Default datacenter."
  type        = string
  default     = null
}

# -------------------------
# Overrides
# -------------------------
variable "server_overrides" {
  description = "Map of server names to specific configurations. Overrides defaults."
  type = map(object({
    server_type        = optional(string)
    image              = optional(string)
    location           = optional(string)
    datacenter         = optional(string)
    user_data          = optional(string)
    keep_disk          = optional(bool)
    backups            = optional(bool)
    placement_group_id = optional(number)
    
    # -----------------------------------------------------
    # THIS SECTION MUST EXIST for the override to work
    # -----------------------------------------------------
    firewall_ids       = optional(list(number))
    networks           = optional(list(object({
      network_id = number
      ip         = optional(string)
      alias_ips  = optional(list(string))
    })))
    # -----------------------------------------------------
  }))
  default = {}
}

# -------------------------
# Access & Config
# -------------------------
variable "user_data" {
  description = "Default user_data (cloud-init)."
  type        = string
  default     = null
}

variable "ssh_keys" {
  description = "List of SSH keys."
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Labels map."
  type        = map(string)
  default     = {}
}

# -------------------------
# Networking & Security
# -------------------------
variable "public_net" {
  description = "Public network config."
  type = object({
    ipv4_enabled = bool
    ipv6_enabled = bool
    ipv4         = optional(number)
  })
  default = {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

variable "networks" {
  description = "Private networks to attach."
  type = list(object({
    network_id = number
    ip         = optional(string)
    alias_ips  = optional(list(string))
  }))
  default = []
}

variable "firewall_ids" {
  description = "Firewall IDs."
  type        = list(number)
  default     = []
}

variable "ignore_remote_firewall_ids" {
  type    = bool
  default = false
}

# -------------------------
# Maintenance
# -------------------------
variable "backups" {
  description = "Enable backups (default)."
  type        = bool
  default     = false
}

variable "placement_group_id" {
  type    = number
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