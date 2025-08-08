resource "hcloud_firewall" "this" {
  name = var.name

  dynamic "rule" {
    for_each = var.rules
    content {
      direction       = rule.value.direction
      protocol        = rule.value.protocol
      port            = lookup(rule.value, "port", null)
      source_ips      = lookup(rule.value, "source_ips", [])
      destination_ips = lookup(rule.value, "destination_ips", [])
      description     = lookup(rule.value, "description", null)
    }
  }
}

resource "hcloud_firewall_attachment" "this" {
  count = length(var.server_ids) > 0 || length(var.label_selectors) > 0 ? 1 : 0

  firewall_id     = hcloud_firewall.this.id
  server_ids      = var.server_ids
  label_selectors = var.label_selectors
}