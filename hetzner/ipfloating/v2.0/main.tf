module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.0"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
}

resource "hcloud_floating_ip" "this" {
  for_each = toset(module.naming.names)

  type              = var.type
  name              = each.value
  home_location     = var.home_location
  description       = var.description
  labels            = var.labels
  delete_protection = var.delete_protection

  # if server_ids list is provided, attach floating IP to server at same index
  server_id = (
    length(var.server_ids) != 0
      ? element(var.server_ids, index(module.naming.names, each.value))
      : var.server_id
  )
}