locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.labels

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  namepref    = "server-ubuntu"
  replicas    = 2

  server_type = "cpx11"
  image       = "ubuntu-24.04"
  location    = "nbg1"

  ssh_keys    = ["shota@shotathink", "shota@shotalinux"]

  public_net = {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  labels       = local.env_vars.locals.labels

  backups      = false
  keep_disk    = false

  delete_protection        = false
  rebuild_protection       = false
  shutdown_before_deletion = true
}