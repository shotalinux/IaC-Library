output "floating_ip_names" {
  description = "List of floating IP names created"
  value       = module.naming.names
}

output "floating_ip_ids" {
  description = "Map of floating IP names to their IDs"
  value       = { for name, fip in hcloud_floating_ip.this : name => fip.id }
}

output "floating_ip_assignment_ids" {
  description = "Map of floating IP names to assignment IDs (if assigned)"
  value       = { for name, assignment in hcloud_floating_ip_assignment.this : name => assignment.id }
}