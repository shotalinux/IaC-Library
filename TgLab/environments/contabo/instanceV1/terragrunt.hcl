include "root" {
  path = find_in_parent_folders("contabo.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/contabo/instance/instanceV1.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//contabo/instance/v1.0"
}
