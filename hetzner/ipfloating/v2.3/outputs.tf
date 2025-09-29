output "floating_ip_names" {
  value = module.naming.names
}

output "floating_ip_ids" {
  value = { for name, fip in hcloud_floating_ip.this : name => fip.id }
}

output "floating_ip_assigned_servers" {
  value = { for name, fip in hcloud_floating_ip.this : name => fip.server_id }
}