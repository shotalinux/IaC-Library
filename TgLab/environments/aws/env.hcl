locals {
  env_name = "test"
  
  tags = {
    "Environment" = local.env_name
    "Owner"       = "Shota"
    "Project"     = "IaC-Library"
  }
}