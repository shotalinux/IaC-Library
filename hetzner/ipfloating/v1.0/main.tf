resource "hcloud_floating_ip" "this" {
  type              = var.type
  name              = var.name
  server_id         = var.server_id
  home_location     = var.home_location
  description       = var.description
  labels            = var.labels
  delete_protection = var.delete_protection
}