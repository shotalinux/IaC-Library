output "firewall_id" {
  description = "The ID of the Linode firewall"
  value       = linode_firewall.fire.id
}

output "firewall_label" {
  description = "The label of the Linode firewall"
  value       = linode_firewall.fire.label
}

output "firewall_status" {
  description = "The status of the Linode firewall"
  value       = linode_firewall.fire.status
}

#output "firewall_rules" {
#  description = "The rules of the Linode firewall"
#  value       = linode_firewall.fire.rules
#}

output "inbound_rules" {
  description = "The inbound rules of the firewall"
  value       = var.inbound_rules
}

output "outbound_rules" {
  description = "The outbound rules of the firewall"
  value       = var.outbound_rules
}
