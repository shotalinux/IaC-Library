include "root" {
  path = find_in_parent_folders("hetzner.hcl")
}

include "env" {
  path   = "${get_terragrunt_dir()}/../../../_env/hcloudinteg/lb/loadbalancer-v2.hcl"
  expose = true
}

terraform {
  source = "${include.env.locals.source_base}//hetzner/lb/v2.1"
}

# Dependencies
dependency "servers" {
  config_path = "../servergroup2"

  mock_outputs = {
    ids       = ["111111", "222222"]                # mock server IDs
    names     = ["server-rocky1", "server-rocky2"]
    locations = ["nbg1", "nbg1"]
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    name = "privNet-hwninja-integ-test"
    id   = "11420143"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "firewall" {
  config_path = "../firewall"
  mock_outputs = {
    firewall_id   = "1234567890"
    firewall_name = "firewall-integ-test"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = merge(
  include.env.inputs,
  {
    network_id = tonumber(dependency.networking.outputs.id)
    network_ip = null

    targets = [
      for sid in dependency.servers.outputs.ids : {
        type           = "server"
        server_id      = sid
        use_private_ip = true
      }
    ]

    # enforce env services
    services = include.env.inputs.services
  }
)