output "id" {
  description = "ID of the load balancer"
  value       = hcloud_load_balancer.this.id
}

output "name" {
  description = "Name of the load balancer"
  value       = hcloud_load_balancer.this.name
}

output "ipv4" {
  description = "Public IPv4 address"
  value       = hcloud_load_balancer.this.ipv4
}

output "ipv6" {
  description = "Public IPv6 address"
  value       = hcloud_load_balancer.this.ipv6
}

output "targets" {
  description = "Attached targets"
  value       = hcloud_load_balancer_target.this
}

output "services" {
  description = "Configured services"
  value       = hcloud_load_balancer_service.this
}