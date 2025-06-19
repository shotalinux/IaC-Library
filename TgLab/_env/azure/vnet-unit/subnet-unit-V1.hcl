locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("envunit.hcl"))

  env_name = local.env_vars.locals.env_name # Corrected this line to reference 'env_name'

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  subnet_name      = ["subnet-${local.env_name}-1", "subnet-${local.env_name}-2"]
  location         = local.env_vars.locals.location
  address_prefixes = ["10.0.0.0/24", "10.0.1.0/24"]
  delegations      = []
  tags             = local.env_vars.locals.tags
}