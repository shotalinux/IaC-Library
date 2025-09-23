include "root" {
  path = find_in_parent_folders("hetzner.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/hcloudinteg/networking/networkingV1.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//hetzner/network/v1.0"
}
