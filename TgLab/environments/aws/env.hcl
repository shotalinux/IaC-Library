locals {
  env_name = "Test"
  project  = "IaC-Library"
  owner    = "Shota"

  tags = {
    "Environment" = local.env_name
    "Owner"       = local.owner
    "Project"     = local.project
  }
}