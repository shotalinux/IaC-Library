# IaC-Library

## Overview
The IaC-Library is a collection of reusable Infrastructure as Code (IaC) modules for various cloud providers (AWS, Azure, Linode, Hetzner, etc.), designed to simplify infrastructure management using Terraform and Terragrunt.

## Features
- **Reusable Modules**: Modular design for easy integration.
- **Multi-Provider Support**: Deploy across multiple cloud environments.
- **Terragrunt Integration**: Simplified state and configuration management.
- **Testing**: Built-in workflows for unit testing.

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- Cloud Provider Credentials (AWS, Azure, Linode, etc.)

## Module Usage
Modules can be sourced directly from this repository.

Example `terragrunt.hcl`:
```hcl
terraform {
  source = "https://github.com/shotalinux/IaC-Library.git//Linode/instance/v2.0"
}
```

**Note on Module Referencing:**
This project intentionally uses direct git URL referencing without version pinning (e.g., `?ref=...`) to facilitate rapid testing and learning. While strictly pinning versions is best practice for production environments to ensure immutability, this setup allows for immediate feedback during the development and study of these modules.

## Resources
We are grateful for the free and open-source resources provided by the Terraform and Terragrunt communities. These tools enable us to build, share, and learn globally.

## Disclaimer
**Note:** This project is strictly for **learning and testing purposes**. It is **not** intended for production use. Use at your own risk.