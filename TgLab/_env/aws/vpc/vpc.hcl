locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.env_name
  owner    = local.env_vars.locals.owner
  project  = local.env_vars.locals.project

  source_base = "https://github.com/shotalinux/IaC-Library.git"
  
}

inputs = {

  vpc_parameters = {
    "main-vpc" = {
      cidr_block           = "10.0.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      tags = {
        Environment = local.env_name
        Owner       = local.owner
        Project     = local.project
      }
    }
  }

  subnet_parameters = {
    "public-subnet-1" = {
      cidr_block = "10.0.1.0/24"
      vpc_name   = "main-vpc"
      tags = {
        Type        = "Public"
        Environment = local.env_name
        Owner       = local.owner
        Project     = local.project
      }
    }
    "private-subnet-1" = {
      cidr_block = "10.0.2.0/24"
      vpc_name   = "main-vpc"
      tags = {
        Type        = "Private"
        Environment = local.env_name
        Owner       = local.owner
        Project     = local.project
      }
    }
  }

  igw_parameters = {
    "igw-main" = {
      vpc_name = "main-vpc"
      tags = {
        Environment = local.env_name
        Owner       = local.owner
        Project     = local.project
      }
    }
  }

  rt_parameters = {
    "public-rt" = {
      vpc_name = "main-vpc"
      tags = {
        Type        = "Public"
        Environment = local.env_name
        Owner       = local.owner
        Project     = local.project
      }
      routes = [
        {
          cidr_block = "0.0.0.0/0"
          use_igw    = true
          gateway_id = "igw-main"
        }
      ]
    }
  }

  rt_association_parameters = {
    "public-subnet-1-to-public-rt" = {
      subnet_name = "public-subnet-1"
      rt_name     = "public-rt"
    }
  }

}