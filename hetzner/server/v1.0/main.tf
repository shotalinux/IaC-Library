resource "hcloud_server" "node1" {
  name        = var.server_name
  image       = var.server_image
  server_type = var.server_type

  public_net {
    ipv4_enabled = var.ipv4_enabled
    ipv6_enabled = var.ipv6_enabled
  }
}