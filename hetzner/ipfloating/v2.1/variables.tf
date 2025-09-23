variable "namepref" {
  type        = string
  description = "Prefix for naming floating IPs"
}

variable "nameslist" {
  type        = list(string)
  description = "Explicit list of floating IP names"
  default     = []
}

variable "replicas" {
  type        = number
  description = "Number of floating IPs to create if using namepref"
}

variable "suffix_style" {
  type        = string
  description = "Suffix style for replicas: 'numeric' or 'alpha'"
  default     = "numeric"
}

variable "zero_padding" {
  type        = number
  description = "Digits for zero-padded numeric suffix"
  default     = 1
}

variable "start_index" {
  type        = number
  description = "Starting index for numeric suffix"
  default     = 1
}

variable "type" {
  type        = string
  description = "Type of floating IP: ipv4 or ipv6"
}

variable "home_location" {
  type        = string
  description = "Home location for floating IPs"
  default     = null
}

variable "description" {
  type        = string
  description = "Optional description for floating IPs"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "Optional labels"
  default     = {}
}

variable "delete_protection" {
  type        = bool
  description = "Enable/disable delete protection"
  default     = false
}

variable "server_ids" {
  type        = list(number)
  description = "Optional list of server IDs to assign FIPs to"
  default     = []
}