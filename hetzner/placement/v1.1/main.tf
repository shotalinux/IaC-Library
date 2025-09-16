resource "hcloud_placement_group" "this" {
  count = var.replicas

  name   = "${var.name}-${count.index + 1}"
  type   = var.type
  labels = var.labels
}