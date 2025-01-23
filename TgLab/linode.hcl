generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "shotas3"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
EOF
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "skip"
  contents = <<EOF
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    linode = {
      source = "linode/linode"
    }
  }
}
EOF
}
