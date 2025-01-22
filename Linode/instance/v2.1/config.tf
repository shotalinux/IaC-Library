resource "linode_instance_config" "the_config" {
  count     = length(linode_instance.LinstanceV2[*].id)
  linode_id = linode_instance.LinstanceV2[count.index].id
  label     = "the-config-${count.index + 1}"
  kernel    = "linode/grub2"

  # DISKS

  device {
    device_name = "sda"
    disk_id = linode_instance.LinstanceV2[count.index].disk[0].id
  }

  device {
    device_name = "sdb"
    disk_id = linode_instance.LinstanceV2[count.index].disk[1].id
  }

  # NETWORK

  dynamic "interface" {
    for_each = var.netoptions == 0 || var.netoptions == 2 || (var.netoptions != 1 && var.netoptions != 2) ? [1] : []
    content {
      purpose = "public"
    }
  }

  dynamic "interface" {
    for_each = var.netoptions == 1 || var.netoptions == 2 ? [1] : []
    content {
      purpose   = "vpc"
      subnet_id = var.sbnt_id
      ipv4 {
        vpc     = var.ipv4add  # Will be null if not set, using DHCP
      }
    }
  }

  booted = var.boot

}
