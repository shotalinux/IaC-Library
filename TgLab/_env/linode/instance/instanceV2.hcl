locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  tags            = [local.env_name]
  img             = "linode/debian11"
  region          = "fr-par"
  instance_type   = "g6-nanode-1"
}
