output "floating_ip_names" {
  value = module.naming.names
}

output "floating_ip_ids" {
  value = { for name, fip in hcloud_floating_ip.this : name => fip.id }
}

output "floating_ip_assignment_ids" {
  value = { for name, assignment in hcloud_floating_ip_assignment.this : name => assignment.id }
}