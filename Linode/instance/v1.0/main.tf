resource "random_string" "defaultname" {
  length  = 16
  special = false
}

resource "random_string" "passwordrandom" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

locals {
  name          = var.name != "" ? var.name : random_string.defaultname.result
  root_password = var.root_password != "" ? var.root_password : random_string.passwordrandom.result
}

resource "linode_instance" "LinstanceV1" {
  image      = var.img
  region     = var.region
  type       = var.instance_type
  label      = local.name
  tags       = var.tags
  root_pass  = local.root_password

  authorized_keys = [
    var.ssh_key_label
  ]
}
