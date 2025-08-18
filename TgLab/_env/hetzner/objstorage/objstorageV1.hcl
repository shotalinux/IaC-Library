locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  bucket_name       = "s3-bucket-hwninja"
  labels            = local.env_vars.locals
  acl               = "private"
  # please export TF_VAR_access_key="your-access-key" and export TF_VAR_secret_key="your-secret-key"
}