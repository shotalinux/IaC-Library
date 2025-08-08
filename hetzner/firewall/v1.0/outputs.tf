output "firewall_id" {
  description = "The ID of the created firewall"
  value       = hcloud_firewall.this.id
}

output "firewall_name" {
  description = "The name of the created firewall"
  value       = hcloud_firewall.this.name
}