include "root" {
  path = find_in_parent_folders("hetzner.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/hcloudinteg/servers/servergroup1-ubuntu.hcl"
  expose = true
}

# Construct the terraform.source attribute using the source_base and default version
terraform {
  source = "${include.env.locals.source_base}//hetzner/server/v2.2"
}

dependency "placement_group_spread" {
  config_path = "${get_terragrunt_dir()}/../pg-spread"

  mock_outputs = {
    ids = ["123456"] # mock placement group ID
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    name = "privNet-hwninja-integ-test",
    id = "11420143"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "firewall" {
  config_path = "../firewall"
  mock_outputs = {
    firewall_id = "1234567890",
    firewall_name = "firewall-integ-test"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = merge(
  include.env.inputs,
  {
    placement_group_id = dependency.placement_group_spread.outputs.ids[0]
    firewall_ids = [dependency.firewall.outputs.firewall_id]
     networks = [
      {
        network_id = tonumber(dependency.networking.outputs.id)
        # ip = "optional-static-ip"  # add if needed
      }
     ]
  }
)