resource "linode_firewall" "fire" {
  label = var.firewall_label

  inbound_policy = var.inbound_policy

  dynamic "inbound" {
    for_each = var.inbound_rules
    content {
      label    = inbound.value.label
      action   = inbound.value.action
      protocol = inbound.value.protocol
      ports    = inbound.value.ports
      ipv4     = inbound.value.ipv4
      ipv6     = inbound.value.ipv6
    }
  }

  outbound_policy = var.outbound_policy

  dynamic "outbound" {
    for_each = var.outbound_rules
    content {
      label    = outbound.value.label
      action   = outbound.value.action
      protocol = outbound.value.protocol
      ports    = outbound.value.ports
      ipv4     = outbound.value.ipv4
      ipv6     = outbound.value.ipv6
    }
  }

  linodes = var.linode_ids
}
