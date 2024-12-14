locals {
  env_name = "unit"
  
  tags = {
    "Environment" = local.env_name
    "Owner"       = "DevOps Team"
    "Project"     = "IaC-Library"
  }
}
