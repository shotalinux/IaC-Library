output "id" {
  description = "ID of the floating IP."
  value       = hcloud_floating_ip.this.id
}

output "ip_address" {
  description = "The floating IP address."
  value       = hcloud_floating_ip.this.ip_address
}

output "type" {
  description = "Type of the floating IP (ipv4 or ipv6)."
  value       = hcloud_floating_ip.this.type
}