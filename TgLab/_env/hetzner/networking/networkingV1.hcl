locals {
  # Load the relevant env.hcl file based on where terragrunt was invoked. This works because find_in_parent_folders
  # always works at the context of the child configuration.
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env

  source_base = "https://github.com/shotalinux/IaC-Library.git"
}

inputs = {
  network_name              = "privNet-hwninja"
  ip_range                  = "10.10.0.0/16"

  subnet_type               = "cloud"
  subnet_ip_range           = "10.10.1.0/24"
  network_zone              = "eu-central"

  delete_protection         = false
  expose_routes_to_vswitch  = false

  enable_route              = true
  route_destination         = "10.20.0.0/16"
  route_gateway             = "10.10.1.1"

  network_labels = {
    environment = "dev"
    owner       = "shota"
  }

  subnet_labels = {
    subnet = "app-segment"
  }

  route_labels = {
    purpose = "app-routing"
  }
}
