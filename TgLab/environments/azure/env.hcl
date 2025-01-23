locals {
  env_name = "UnitTest"
  
  tags = {
    "Environment" = local.env_name
    "Owner"       = "Shota"
    "Project"     = "IaC-Library"
  }
}
