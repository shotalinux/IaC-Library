locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  tags                  = [local.env_name]
  vpc_name              = "vpc-test"
  vpc_cidr              = "10.0.0.0/16"
  availability_zones    = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets        = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway    = true
  single_nat_gateway    = true
}