variable "type" {
  description = "Type of the floating IP. Options: ipv4, ipv6."
  type        = string
  default     = "ipv4"
}

variable "name" {
  description = "Name of the floating IP."
  type        = string
  default     = null
}

variable "server_id" {
  description = "Server ID to assign the floating IP to."
  type        = number
  default     = null
}

variable "home_location" {
  description = "Home location for the floating IP (used if server_id not provided)."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the floating IP."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels for the floating IP."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable or disable delete protection. Recommended to keep true."
  type        = bool
  default     = true
}