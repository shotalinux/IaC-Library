locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  namepref   = "fip-ubuntu"
  replicas   = 2
  type       = "ipv4"
  labels     = local.env_vars.locals.labels
  delete_protection = false
}