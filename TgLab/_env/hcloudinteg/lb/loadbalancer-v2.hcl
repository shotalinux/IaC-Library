locals {
  # Load environment-wide labels
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.labels

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  name               = "lb-rocky2"
  load_balancer_type = "lb11"
  labels             = local.env_name
  delete_protection  = false

  location     = "nbg1"
  network_zone = null

  # Normalized services
  services = [
    {
      protocol         = "http"
      listen_port      = 80
      destination_port = 80
      proxyprotocol    = false
      http = {
        sticky_sessions = false
        certificates    = []
        redirect_http   = false
      }
      health_check = {
        protocol = "http"
        port     = 80
        interval = 15
        timeout  = 10
        retries  = 3
        http = {
          path         = "/health"
          response     = "OK"
          status_codes = ["200"]
        }
      }
    },
    {
      protocol         = "https"
      listen_port      = 443
      destination_port = 443
      proxyprotocol    = false
      http = {
        sticky_sessions = true
        certificates    = []
        redirect_http   = true
      }
      health_check = {
        protocol = "tcp"
        port     = 443
        interval = 15
        timeout  = 10
        retries  = 3
      }
    }
  ]
}