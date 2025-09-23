locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.labels
  srciplist = jsondecode(get_env("SRCIPLIST"))

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  name = "firewall-integ-test"

  rules = [
    {
      direction  = "in"
      protocol   = "icmp"
      source_ips = local.srciplist
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = local.srciplist
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "443"
      source_ips = ["0.0.0.0/0", "::/0"]
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "80-85"
      source_ips = local.srciplist
    },
    {
      direction  = "in"
      protocol   = "tcp"
      port       = "3389"
      source_ips = local.srciplist
    }
  ]

  # Optionally attach to servers
  # If the server is already created, use dependency outputs
  # server_ids = dependency.server.outputs.server_id
  # or use label-based attachment
  label_selectors = ["Stage=${local.env_name.Stage}"]
}