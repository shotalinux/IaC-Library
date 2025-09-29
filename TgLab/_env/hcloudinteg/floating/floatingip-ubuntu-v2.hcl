locals {
  # Load env.hcl for common environment labels
  env_vars   = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_labels = local.env_vars.locals.labels

  # Base source URL for IaC modules
  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  namepref          = "fip-ubuntu"
  replicas          = 2
  type              = "ipv4"
  labels            = local.env_labels
  delete_protection = false
}