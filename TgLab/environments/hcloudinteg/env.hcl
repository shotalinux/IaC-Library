locals {
  environment = "IntegTest"
  project  = "Personal"
  owner    = "Shota"

  labels = {
    "Environment" = local.environment
    "Owner"       = local.owner
    "Project"     = local.project
  }
}
