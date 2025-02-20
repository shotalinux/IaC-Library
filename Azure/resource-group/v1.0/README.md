# Azure Resource Group Module

This module creates an Azure Resource Group with configurable parameters.

## Usage

To use this module in your Terraform configuration, follow the example below:

```hcl
module "azure_resource_group" {
  source   = "./azure-resource-group"
  name     = "example-resources"
  location = "East US"
  tags     = {
    Environment = "Production"
    Department  = "IT"
  }
}
