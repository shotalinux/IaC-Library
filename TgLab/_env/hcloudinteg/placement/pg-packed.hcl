locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.labels

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  nameslist         = ["placement-integ-packed"]
  #type              = "packed"
  labels            = local.env_vars.locals.labels
}
