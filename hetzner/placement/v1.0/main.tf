resource "hcloud_placement_group" "this" {
  name      = var.name
  type      = var.type
  labels    = var.labels
}