############################################
# Networks
############################################
resource "hcloud_network" "net" {
  for_each = local.final_config_effective

  name                     = each.key
  ip_range                 = each.value.network_cidr
  expose_routes_to_vswitch = each.value.expose_routes_to_vswitch
  labels                   = each.value.labels
}

############################################
# Subnets
############################################
resource "hcloud_network_subnet" "subnet" {
  for_each = { for s in local.subnets_flat : s.key => s }

  network_id   = hcloud_network.net[each.value.net_name].id
  type         = each.value.type
  network_zone = each.value.zone
  ip_range     = each.value.ip_range
  vswitch_id   = each.value.vswitch_id # Supports null for cloud type
}

############################################
# Routes
############################################
resource "hcloud_network_route" "route" {
  for_each = { for r in local.routes_flat : r.key => r }

  network_id  = hcloud_network.net[each.value.net_name].id
  destination = each.value.destination
  gateway     = each.value.gateway
}