module "naming" {
  source = "git::https://github.com/shotalinux/IaC-Library.git//locals/naming/v1.0"

  namepref     = var.namepref
  nameslist    = var.nameslist
  replicas     = var.replicas
  suffix_style = var.suffix_style
  zero_padding = var.zero_padding
}

resource "hcloud_server" "this" {
  for_each = toset(module.naming.names)

  name              = each.value
  server_type       = var.server_type
  image             = var.image
  location          = var.location
  datacenter        = var.datacenter
  user_data         = var.user_data
  ssh_keys          = var.ssh_keys
  keep_disk         = var.keep_disk
  iso               = var.iso
  rescue            = var.rescue
  labels            = var.labels
  backups           = var.backups
  firewall_ids      = var.firewall_ids
  ignore_remote_firewall_ids = var.ignore_remote_firewall_ids
  placement_group_id         = var.placement_group_id
  delete_protection          = var.delete_protection
  rebuild_protection         = var.rebuild_protection
  allow_deprecated_images    = var.allow_deprecated_images
  shutdown_before_deletion   = var.shutdown_before_deletion

  public_net {
    ipv4_enabled = var.public_net.ipv4_enabled
    ipv6_enabled = var.public_net.ipv6_enabled
    ipv4         = try(var.public_net.ipv4, null)
  }

  dynamic "network" {
    for_each = var.networks
    content {
      network_id = network.value.network_id
      ip         = try(network.value.ip, null)
      alias_ips  = try(network.value.alias_ips, [])
    }
  }

  lifecycle {
    ignore_changes = [ssh_keys]
  }
}