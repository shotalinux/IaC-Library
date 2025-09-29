module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.1"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
  start_index  = var.start_index
}

# Determine home location
locals {
  fip_home_location = length(var.server_ids) > 0 ? var.server_locations[0] : "nbg1"
}

# Print message if default location is used
resource "null_resource" "fip_home_location_message" {
  count = length(var.server_ids) > 0 ? 0 : 1
  provisioner "local-exec" {
    command = "echo 'INFO: No servers provided. Default FIP home_location set to nbg1.'"
  }
}

# Create floating IPs and attach to servers if provided
resource "hcloud_floating_ip" "this" {
  for_each = toset(module.naming.names)

  type        = var.type
  name        = each.value
  home_location = local.fip_home_location
  description = var.description
  labels      = var.labels
  delete_protection = var.delete_protection

  server_id = length(var.server_ids) > 0 ? var.server_ids[each.key] : null
}