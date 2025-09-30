########################################
# Load Balancer Core
########################################
resource "hcloud_load_balancer" "this" {
  name               = var.name
  load_balancer_type = var.load_balancer_type

  # Defaults to location if set, otherwise network_zone
  location     = var.location
  network_zone = var.network_zone

  labels            = var.labels
  delete_protection = var.delete_protection
}

########################################
# Optional Network Attachment
########################################
resource "hcloud_load_balancer_network" "this" {
  count            = var.network_id != null ? 1 : 0
  load_balancer_id = hcloud_load_balancer.this.id
  network_id       = var.network_id
  ip               = var.network_ip
}

########################################
# Services (HTTP, HTTPS, TCP)
########################################
resource "hcloud_load_balancer_service" "this" {
  for_each         = { for idx, svc in var.services : idx => svc }
  load_balancer_id = hcloud_load_balancer.this.id

  protocol         = each.value.protocol
  listen_port      = lookup(each.value, "listen_port", null)
  destination_port = lookup(each.value, "destination_port", null)
  proxyprotocol    = lookup(each.value, "proxyprotocol", false)

  # HTTP/HTTPS configuration (one unified block)
  dynamic "http" {
    for_each = contains(["http", "https"], each.value.protocol) && try(each.value.http != null, false) ? [each.value.http] : []
    content {
      sticky_sessions = lookup(http.value, "sticky_sessions", false)
      cookie_name     = lookup(http.value, "cookie_name", null)
      cookie_lifetime = lookup(http.value, "cookie_lifetime", null)
      certificates    = lookup(http.value, "certificates", [])
      redirect_http   = lookup(http.value, "redirect_http", false)
    }
  }

  # Health check configuration
  dynamic "health_check" {
    for_each = try(each.value.health_check != null, false) ? [each.value.health_check] : []
    content {
      protocol = health_check.value.protocol
      port     = health_check.value.port
      interval = lookup(health_check.value, "interval", 15)
      timeout  = lookup(health_check.value, "timeout", 10)
      retries  = lookup(health_check.value, "retries", 3)

      dynamic "http" {
        for_each = try(health_check.value.http != null, false) ? [health_check.value.http] : []
        content {
          domain       = lookup(http.value, "domain", null)
          path         = lookup(http.value, "path", "/")
          response     = lookup(http.value, "response", null)
          tls          = lookup(http.value, "tls", false)
          status_codes = lookup(http.value, "status_codes", ["200"])
        }
      }
    }
  }
}

########################################
# Targets
########################################
resource "hcloud_load_balancer_target" "this" {
  for_each         = { for idx, tgt in var.targets : idx => tgt }
  type             = each.value.type
  load_balancer_id = hcloud_load_balancer.this.id

  server_id      = lookup(each.value, "server_id", null)
  label_selector = lookup(each.value, "label_selector", null)
  ip             = lookup(each.value, "ip", null)
  use_private_ip = lookup(each.value, "use_private_ip", false)
}