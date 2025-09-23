variable "namepref" {
  description = "Prefix for floating IP names. Used with replicas if nameslist not provided."
  type        = string
  default     = null
}

variable "nameslist" {
  description = "Explicit list of floating IP names."
  type        = list(string)
  default     = []
}

variable "replicas" {
  description = "Number of floating IPs to create if nameslist is empty."
  type        = number
  default     = 1
}

variable "suffix_style" {
  description = "Suffix style: 'dash', 'underscore', or 'none'."
  type        = string
  default     = "dash"
}

variable "zero_padding" {
  description = "Number of digits to zero-pad replica suffixes (e.g., 2 → 01, 02)."
  type        = number
  default     = 0
}

variable "type" {
  description = "Type of floating IP (ipv4 or ipv6)."
  type        = string
}

variable "server_id" {
  description = "Optional single server ID to attach a floating IP."
  type        = string
  default     = null
}

variable "server_ids" {
  description = "Optional list of server IDs to map floating IPs to (1:1)."
  type        = list(string)
  default     = []
}

variable "home_location" {
  description = "Home location for the floating IP (e.g., nbg1)."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the floating IP."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for the floating IP."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable or disable delete protection for the floating IP."
  type        = bool
  default     = false
}