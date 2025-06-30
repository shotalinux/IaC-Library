output "name" {
  description = "Name of the network"
  value       = hcloud_network.privNet.name
}

output "id" {
  description = "ID of the network"
  value       = hcloud_network.privNet.id
}

output "ip_range" {
  description = "IP range of the network in CIDR notation"
  value       = hcloud_network.privNet.ip_range
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = hcloud_network_subnet.privSubnet.id
}

output "subnet_ip_range" {
  description = "IP range of the subnet in CIDR notation"
  value       = hcloud_network_subnet.privSubnet.ip_range
}

output "subnet_type" {
  description = "Type of the subnet"
  value       = hcloud_network_subnet.privSubnet.type
}

output "subnet_network_zone" {
  description = "Network zone for the subnet"
  value       = hcloud_network_subnet.privSubnet.network_zone
}

output "network_labels" {
  description = "Labels applied to the network"
  value       = hcloud_network.privNet.labels
}

output "route_id" {
  value       = try(hcloud_network_route.privRoute[0].id, null)
  description = "ID of the network route"
}

output "route_destination" {
  value       = try(hcloud_network_route.privRoute[0].destination, null)
  description = "Destination for the network route in CIDR notation"
}

output "route_gateway" {
  value       = try(hcloud_network_route.privRoute[0].gateway, null)
  description = "Gateway for the network route"
}