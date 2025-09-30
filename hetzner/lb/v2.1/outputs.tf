output "id" {
  description = "ID of the Load Balancer."
  value       = hcloud_load_balancer.this.id
}

output "name" {
  description = "Name of the Load Balancer."
  value       = hcloud_load_balancer.this.name
}

output "ipv4" {
  description = "Public IPv4 of the Load Balancer."
  value       = hcloud_load_balancer.this.ipv4
}

output "ipv6" {
  description = "Public IPv6 of the Load Balancer."
  value       = hcloud_load_balancer.this.ipv6
}

output "targets" {
  description = "List of LB targets."
  value = {
    for k, v in hcloud_load_balancer_target.this :
    k => {
      id             = v.id
      server_id      = v.server_id
      ip             = v.ip
      label_selector = v.label_selector
      type           = v.type
      use_private_ip = v.use_private_ip
    }
  }
}