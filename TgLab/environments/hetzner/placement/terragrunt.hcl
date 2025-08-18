include "root" {
  path = find_in_parent_folders("hetzner.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/hetzner/placement/placementV1.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//hetzner/placement/v1.0"
}
