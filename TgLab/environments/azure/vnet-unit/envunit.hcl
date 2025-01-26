locals {
  env_name = "unittest"
  location = "westeurope"

  tags = {
    "Environment" = local.env_name
    "Owner"       = "Shota"
    "Project"     = "IaC-Library"
  }
}
