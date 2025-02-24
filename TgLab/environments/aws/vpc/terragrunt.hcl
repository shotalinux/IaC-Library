include "root" {
  path = find_in_parent_folders("aws.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/aws/vpc/vpc.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//AWS/vpc/v1.0"
}
