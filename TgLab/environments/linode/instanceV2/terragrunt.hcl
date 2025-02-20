include "root" {
  path = find_in_parent_folders("linode.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/instance/instanceV2.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//Linode/instance/v2.0"
}
