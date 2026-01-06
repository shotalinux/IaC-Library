# Create servers for each name in the provided list
resource "hcloud_server" "this" {
  for_each = toset(var.names)

  name                       = each.value
  server_type                = try(var.server_overrides[each.value].server_type, var.server_type)
  image                      = try(var.server_overrides[each.value].image, var.image)
  location                   = try(var.server_overrides[each.value].location, var.location)
  datacenter                 = try(var.server_overrides[each.value].datacenter, var.datacenter)
  user_data                  = try(var.server_overrides[each.value].user_data, var.user_data)
  
  backups                    = try(var.server_overrides[each.value].backups, var.backups)
  keep_disk                  = try(var.server_overrides[each.value].keep_disk, var.keep_disk)
  placement_group_id         = try(var.server_overrides[each.value].placement_group_id, var.placement_group_id)

  # Security (Fixed Logic: Check for null explicitly)
  firewall_ids = try(
    var.server_overrides[each.value].firewall_ids != null ? var.server_overrides[each.value].firewall_ids : var.firewall_ids,
    var.firewall_ids
  )

  # Global Settings
  ssh_keys                   = var.ssh_keys
  labels                     = var.labels
  ignore_remote_firewall_ids = var.ignore_remote_firewall_ids
  
  delete_protection          = var.delete_protection
  rebuild_protection         = var.rebuild_protection
  allow_deprecated_images    = var.allow_deprecated_images
  shutdown_before_deletion   = var.shutdown_before_deletion
  iso                        = var.iso
  rescue                     = var.rescue

  public_net {
    ipv4_enabled = var.public_net.ipv4_enabled
    ipv6_enabled = var.public_net.ipv6_enabled
    ipv4         = try(var.public_net.ipv4, null)
  }

  # -------------------------------------------------------
  # DYNAMIC NETWORKS (FIXED)
  # -------------------------------------------------------
  dynamic "network" {
    # Logic: 
    # 1. Try to get override. 
    # 2. If override exists but is NULL, use global default.
    # 3. If override key doesn't exist (error), use global default.
    for_each = try(
      var.server_overrides[each.value].networks != null ? var.server_overrides[each.value].networks : var.networks,
      var.networks
    )
    
    content {
      network_id = network.value.network_id
      ip         = try(network.value.ip, null)
      alias_ips  = try(network.value.alias_ips, [])
    }
  }

  lifecycle {
    ignore_changes = [
      ssh_keys,
      firewall_ids,
      network
      ]
  }
}
