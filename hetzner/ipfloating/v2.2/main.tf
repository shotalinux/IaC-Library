module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.1"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
  start_index  = var.start_index
}

# Create floating IPs
resource "hcloud_floating_ip" "this" {
  for_each = toset(module.naming.names)

  type              = var.type
  name              = each.value
  home_location     = local.effective_home_location
  description       = var.description
  labels            = var.labels
  delete_protection = var.delete_protection
}

# Optional: assign floating IPs to servers if server_ids are provided
resource "hcloud_floating_ip_assignment" "this" {
  for_each = {
    for i, name in module.naming.names :
    i => name
    if length(var.server_ids) > i
  }

  floating_ip_id = hcloud_floating_ip.this[each.value].id
  server_id      = var.server_ids[each.key]
}