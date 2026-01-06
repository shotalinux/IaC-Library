output "network_ids" {
  description = "Map of Network Names -> Network IDs."
  value       = { for name, net in hcloud_network.net : name => net.id }
}

output "networks_full" {
  description = "Comprehensive details of all networks, subnets, and routes created."
  value = {
    for name, net in hcloud_network.net : name => {
      id                       = net.id
      name                     = net.name
      network_cidr             = net.ip_range
      labels                   = net.labels
      expose_routes_to_vswitch = lookup(local.final_config_effective[name], "expose_routes_to_vswitch", false)

      subnets = [
        for s in local.final_config_effective[name].subnets : {
          ip_range   = s.ip_range
          # Construct ID explicitly to match resource loop key
          id         = hcloud_network_subnet.subnet["${name}::${s.ip_range}"].id
          type       = s.type
          zone       = s.zone
          vswitch_id = s.vswitch_id
        }
      ]

      routes = [
        for r in local.final_config_effective[name].routes : {
          destination = r.destination
          gateway     = r.gateway
          id          = hcloud_network_route.route["${name}::${r.destination}"].id
        }
      ]
    }
  }
}

output "names" {
  description = "Final list of names provided via input."
  value       = local.names
}

output "computed_config" {
  description = "Effective configuration map used to build resources."
  value       = local.final_config_effective
}

output "warnings" {
  description = "Diagnostics for configuration validation."
  value = {
    invalid_networks  = local.invalid_networks
    manual_extra_keys = tolist(local.manual_extra_keys)
  }
}