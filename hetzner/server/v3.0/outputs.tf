output "ids" {
  value       = { for s in hcloud_server.this : s.name => s.id }
  description = "Map of server names to IDs."
}

output "names" {
  value       = keys(hcloud_server.this)
  description = "List of server names."
}

output "ipv4_addresses" {
  value       = { for s in hcloud_server.this : s.name => s.ipv4_address }
  description = "Map of server names to IPv4."
}

output "ipv6_addresses" {
  value       = { for s in hcloud_server.this : s.name => s.ipv6_address }
  description = "Map of server names to IPv6."
}

output "full_details" {
  value = {
    for s in hcloud_server.this : s.name => {
      id          = s.id
      status      = s.status
      server_type = s.server_type
      image       = s.image
      location    = s.location
      ipv4        = s.ipv4_address
    }
  }
  description = "Full details of servers."
}