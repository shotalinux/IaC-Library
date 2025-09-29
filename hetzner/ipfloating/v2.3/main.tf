module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.1"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
  start_index  = var.start_index
}

# Build a map from FIP names to server ID + location
locals {
  fip_map = {
    for idx, name in module.naming.names :
    name => {
      server_id = length(var.server_ids) > idx ? var.server_ids[idx] : null
      location  = length(var.server_locations) > idx ? var.server_locations[idx] : "nbg1"
      default_location_used = length(var.server_locations) <= idx
    }
  }
}

# Print message if default location is used
resource "null_resource" "fip_home_location_message" {
  for_each = { for k, v in local.fip_map : k => v if v.default_location_used }

  provisioner "local-exec" {
    command = "echo 'INFO: No server provided for ${each.key}. Default FIP home_location set to nbg1.'"
  }
}

# Create FIPs and assign to server if provided
resource "hcloud_floating_ip" "this" {
  for_each = local.fip_map

  type              = var.type
  name              = each.key
  home_location     = each.value.location
  description       = var.description
  labels            = var.labels
  delete_protection = var.delete_protection

  server_id = each.value.server_id
}