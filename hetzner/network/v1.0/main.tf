resource "hcloud_network" "privNet" {
  name                      = var.network_name
  ip_range                  = var.ip_range
  labels                    = var.network_labels
  delete_protection         = var.delete_protection
  expose_routes_to_vswitch  = var.expose_routes_to_vswitch
}

resource "hcloud_network_subnet" "privSubnet" {
  network_id    = hcloud_network.privNet.id
  type          = var.subnet_type
  ip_range      = var.subnet_ip_range
  network_zone  = var.network_zone
}

resource "hcloud_network_route" "privRoute" {
  count         = var.enable_route ? 1 : 0
  network_id    = hcloud_network.privNet.id
  destination   = var.route_destination
  gateway       = var.route_gateway
}