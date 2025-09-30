########################################
# Core Variables
########################################
variable "name" {
  description = "Name of the Load Balancer."
  type        = string
}

variable "load_balancer_type" {
  description = "Type of the Load Balancer (e.g., lb11, lb21)."
  type        = string
}

variable "location" {
  description = "Location where the LB should be created. Conflicts with network_zone."
  type        = string
  default     = null
}

variable "network_zone" {
  description = "Network zone where the LB should be created. Conflicts with location."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to assign to the Load Balancer."
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Whether delete protection is enabled."
  type        = bool
  default     = false
}

########################################
# Networking
########################################
variable "network_id" {
  description = "Optional network ID to attach the Load Balancer to."
  type        = number
  default     = null
}

variable "network_ip" {
  description = "Optional specific IP address to assign inside the network."
  type        = string
  default     = null
}

########################################
# Services
########################################
variable "services" {
  description = "List of LB services."
  type = list(object({
    protocol         = string
    listen_port      = optional(number)
    destination_port = optional(number)
    proxyprotocol    = optional(bool)

    http = optional(object({
      sticky_sessions = optional(bool)
      cookie_name     = optional(string)
      cookie_lifetime = optional(number)
      certificates    = optional(list(number))
      redirect_http   = optional(bool)
    }))

    health_check = optional(object({
      protocol = string
      port     = number
      interval = optional(number)
      timeout  = optional(number)
      retries  = optional(number)

      http = optional(object({
        domain       = optional(string)
        path         = optional(string)
        response     = optional(string)
        tls          = optional(bool)
        status_codes = optional(list(string))
      }))
    }))
  }))
  default = []
}

########################################
# Targets
########################################
variable "targets" {
  description = "List of LB targets (servers, labels, or IPs)."
  type = list(object({
    type           = string
    server_id      = optional(number)
    label_selector = optional(string)
    ip             = optional(string)
    use_private_ip = optional(bool)
  }))
  default = []
}