include "root" {
  path = find_in_parent_folders("azure.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../../_env/azure/vnet-unit/subnet-unit-V1.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//Azure/subnet/v1.0"
}

dependency "resgroup" {
  config_path = "../resgroup"
  mock_outputs = {
    resource_group_name = "rg-mock-name"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "vnet" {
  config_path = "../vnet"
  mock_outputs = {
    vnet_name = "vnet-mock-name"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  rg_name              = dependency.resgroup.outputs.resource_group_name
  virtual_network_name = dependency.vnet.outputs.vnet_name
}