include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/azresgroup/azresgroupV1.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//Azure/resource-group/v1.0"
}
