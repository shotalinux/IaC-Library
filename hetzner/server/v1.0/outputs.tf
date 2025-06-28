output "ipv4_address" {
  description = "Public IPv4 of the server"
  value       = hcloud_server.node1.ipv4_address
}

output "ipv6_address" {
  description = "Public IPv6 of the server"
  value       = hcloud_server.node1.ipv6_address
}

output "server_id" {
  description = "ID of the Hetzner server"
  value       = hcloud_server.node1.id
}