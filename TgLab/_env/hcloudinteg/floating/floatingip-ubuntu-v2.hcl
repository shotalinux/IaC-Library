locals {
  # Load env.hcl for labels
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.labels

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  namepref   = "fip-ubuntu"
  replicas   = 2
  type       = "ipv4"
  labels     = local.env_vars.locals.labels
}