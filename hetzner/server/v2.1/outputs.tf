output "ids" {
  value = [for s in hcloud_server.this : s.id]
}

output "names" {
  value = [for s in hcloud_server.this : s.name]
}

output "ipv4_addresses" {
  value = [for s in hcloud_server.this : s.ipv4_address]
}

output "ipv6_addresses" {
  value = [for s in hcloud_server.this : s.ipv6_address]
}

output "statuses" {
  value = [for s in hcloud_server.this : s.status]
}

output "server_types" {
  value = [for s in hcloud_server.this : s.server_type]
}

output "images" {
  value = [for s in hcloud_server.this : s.image]
}

output "locations" {
  value = [for s in hcloud_server.this : s.location]
}

output "datacenters" {
  value = [for s in hcloud_server.this : s.datacenter]
}

output "labels" {
  value = [for s in hcloud_server.this : s.labels]
}

output "firewall_ids" {
  value = [for s in hcloud_server.this : s.firewall_ids]
}

output "placement_group_ids" {
  value = [for s in hcloud_server.this : s.placement_group_id]
}
