output "id" {
  value = hcloud_server.this.id
}

output "name" {
  value = hcloud_server.this.name
}

output "ipv4_address" {
  value = hcloud_server.this.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.this.ipv6_address
}

output "status" {
  value = hcloud_server.this.status
}

output "server_type" {
  value = hcloud_server.this.server_type
}

output "image" {
  value = hcloud_server.this.image
}

output "location" {
  value = hcloud_server.this.location
}

output "datacenter" {
  value = hcloud_server.this.datacenter
}

output "labels" {
  value = hcloud_server.this.labels
}

output "firewall_ids" {
  value = hcloud_server.this.firewall_ids
}

output "placement_group_id" {
  value = hcloud_server.this.placement_group_id
}