# -------------------------
# Mode selection
# -------------------------
variable "mode" {
  description = "Allocation mode: 'auto' (Slicing), 'manual' (Explicit), or 'hybrid' (Merge)."
  type        = string
  default     = "auto"
  validation {
    condition     = contains(["auto", "manual", "hybrid"], var.mode)
    error_message = "Mode must be 'auto', 'manual', or 'hybrid'."
  }
}

variable "names" {
  description = "List of network names. In AUTO/HYBRID, this drives generation. In MANUAL, keys must match this list."
  type        = list(string)
  default     = []
}

# -------------------------
# AUTO / HYBRID Inputs
# -------------------------
variable "base_cidr" {
  description = "Super-CIDR used in AUTO/HYBRID mode (e.g., 10.0.0.0/8)."
  type        = string
  default     = "10.0.0.0/8"
}

variable "network_newbits" {
  description = "New bits to slice networks from base_cidr (e.g., 8 -> /16)."
  type        = number
  default     = 8
}

variable "subnet_newbits" {
  description = "New bits to slice subnets from each network (e.g., 8 -> /24)."
  type        = number
  default     = 8
}

variable "network_zone" {
  description = "Default zone for auto-generated subnets."
  type        = string
  default     = "eu-central"
}

variable "labels" {
  description = "Default labels for auto-generated networks."
  type        = map(string)
  default     = {}
}

variable "auto_expose_routes_to_vswitch" {
  description = "If true, auto-generated networks will expose routes to vSwitch."
  type        = bool
  default     = false
}

# -------------------------
# AUTO Routing
# -------------------------
variable "auto_routes_enabled" {
  description = "Enable automatic route generation."
  type        = bool
  default     = false
}

variable "auto_route_strategy" {
  description = "'none', 'peer' (mesh), or 'hub_spoke'."
  type        = string
  default     = "none"
  validation {
    condition     = contains(["none", "peer", "hub_spoke"], var.auto_route_strategy)
    error_message = "auto_route_strategy must be one of: none, peer, hub_spoke."
  }
}

variable "auto_hub_name" {
  description = "Name of the hub network for hub_spoke strategy."
  type        = string
  default     = ""
}

variable "auto_default_destination" {
  description = "Destination for default routes in hub_spoke."
  type        = string
  default     = "0.0.0.0/0"
}

variable "auto_gateway_host_index" {
  description = "Host index for gateway (e.g., 1 -> .1). Used for calculating route next-hops."
  type        = number
  default     = 1
}

# -------------------------
# MANUAL / OVERRIDE Inputs
# -------------------------
variable "manual_config" {
  description = "Explicit configuration map. Overrides AUTO config in Hybrid mode."
  type = map(object({
    ip_range = string
    subnets = list(object({
      ip_range   = string
      type       = string
      zone       = string
      vswitch_id = optional(number)
    }))
    routes = optional(list(object({
      destination = string
      gateway     = string
    })), [])
    expose_routes_to_vswitch = optional(bool, false)
    labels                   = optional(map(string), {})
  }))
  default = {}
}

variable "extra_routes" {
  description = "Additional manual routes appended to any network (Auto or Manual)."
  type = map(list(object({
    destination = string
    gateway     = string
  })))
  default = {}
}