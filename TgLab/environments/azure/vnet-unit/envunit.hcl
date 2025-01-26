locals {
  env_name = "unittest"
  
  tags = {
    "Environment" = local.env_name
    "Owner"       = "Shota"
    "Project"     = "IaC-Library"
  }
}
