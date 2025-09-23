module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.0"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
}

resource "hcloud_placement_group" "this" {
  for_each = toset(module.naming.names)

  name   = each.value
  type   = var.type
  labels = var.labels
}