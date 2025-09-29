include "root" {
  path = find_in_parent_folders("hetzner.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/hcloudinteg/floating/floatingip-ubuntu-v2.hcl"
  expose = true
}

terraform {
  source = "${include.env.locals.source_base}//hetzner/ipfloating/v2.3"
}

dependency "servers" {
  config_path = "../servergroup1"
}

inputs = merge(
  include.env.inputs,
  {
    server_ids       = dependency.servers.outputs.ids
    server_locations = dependency.servers.outputs.locations
  }
)