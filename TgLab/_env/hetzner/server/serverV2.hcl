locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  name         = "demo-server"
  server_type  = "cx22"
  image        = "debian-11"
  location     = "fsn1"

  ssh_keys     = ["shota@shotathink"]

  public_net = {
    ipv4_enabled = true
    ipv6_enabled = true
    # ipv4 = "existing-ip-id" # optional if you're assigning an existing one
  }

  labels = {
    environment = "dev"
    team        = "infra"
  }

  backups      = false
  keep_disk    = false

  firewall_ids = []
  networks = []

  delete_protection        = false
  rebuild_protection       = false
  shutdown_before_deletion = true
}
