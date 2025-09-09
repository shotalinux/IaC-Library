variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "load_balancer_type" {
  description = "Type of load balancer (e.g., lb11, lb21, lb31)"
  type        = string
  default     = "lb11"
}

variable "location" {
  description = "Hetzner location (e.g., nbg1, fsn1, hel1). Conflicts with network_zone."
  type        = string
  default     = "nbg1"
}

variable "network_zone" {
  description = "Network zone (e.g., eu-central). Conflicts with location."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for the load balancer"
  type        = map(string)
  default     = {}
}

variable "delete_protection" {
  description = "Enable or disable delete protection"
  type        = bool
  default     = false
}

variable "network_id" {
  description = "Network ID to attach the load balancer to (optional)"
  type        = number
  default     = null
}

variable "network_ip" {
  description = "Private IP address to assign to the load balancer in the network (optional)"
  type        = string
  default     = null
}

variable "services" {
  description = <<EOT
List of services for the load balancer. Example:
[
  {
    protocol         = "http"
    listen_port      = 80
    destination_port = 80
    http = {
      sticky_sessions = true
      cookie_name     = "SESSION_ID"
    }
    health_check = {
      protocol = "http"
      port     = 80
      http = {
        path     = "/health"
        response = "OK"
      }
    }
  },
  {
    protocol         = "https"
    listen_port      = 443
    destination_port = 443
    http = {
      sticky_sessions = true
      certificates    = ["12345"] # cert IDs in Hetzner
      redirect_http   = true
    }
  },
  {
    protocol         = "tcp"
    listen_port      = 9000
    destination_port = 9000
  }
]
EOT
  type    = list(any)
  default = []
}

variable "targets" {
  description = <<EOT
List of targets for the load balancer. Example:
[
  { type = "server", server_id = 12345 },
  { type = "ip", ip = "192.168.1.100" }
]
EOT
  type    = list(any)
  default = []
}