locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("envunit.hcl"))

  env_name = local.env_vars.locals.env_name  # Corrected this line to reference 'env_name'

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  vnet_name     = "vnet-${local.env_name}"
  location      = local.env_vars.locals.location
  tags          = local.env_vars.locals.tags
  address_space = ["10.0.0.0/16"]
}
