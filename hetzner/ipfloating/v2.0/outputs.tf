output "ids" {
  value       = [for fip in hcloud_floating_ip.this : fip.id]
  description = "IDs of the floating IPs."
}

output "names" {
  value       = [for fip in hcloud_floating_ip.this : fip.name]
  description = "Names of the floating IPs."
}

output "types" {
  value       = [for fip in hcloud_floating_ip.this : fip.type]
  description = "Types of the floating IPs."
}

output "server_ids" {
  value       = [for fip in hcloud_floating_ip.this : fip.server_id]
  description = "Server IDs to which floating IPs are attached."
}