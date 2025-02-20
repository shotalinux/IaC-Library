resource "random_string" "passwordrandom" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "random_string" "defaultname" {
  count   = var.instance_count
  length  = 16
  special = false
}

locals {
  root_password = var.root_password != "" ? var.root_password : random_string.passwordrandom.result
  randname_list = random_string.defaultname[*].result
  combined_names = join("-", var.names)
  complex_labels = [for i in range(var.instance_count) : "${local.combined_names}-${i + 1}"]
}

resource "linode_instance" "LinstanceV2" {
  count           = (length(var.names) > 0 && var.instance_count > 1) ? length(local.complex_labels) : (length(var.names) > 0 ? length(var.names) : length(local.randname_list))
  image           = var.img
  region          = var.region
  type            = var.instance_type
  label           = (length(var.names) > 0 && var.instance_count > 1) ? local.complex_labels[count.index] : (length(var.names) > 0 ? var.names[count.index] : local.randname_list[count.index])
  tags            = var.tags
  root_pass       = local.root_password
  authorized_keys = [var.ssh_key_label]
}
