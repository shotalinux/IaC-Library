# IaC-Library

## Overview

The IaC-Library is a repository designed to host reusable Infrastructure as Code (IaC) modules. It provides a collection of Terraform and Terragrunt configurations for deploying various cloud resources across multiple providers, including AWS, Linode, Azure and ect... This library aims to simplify the process of infrastructure management by offering pre-defined modules that can be easily integrated into your projects.

## Features

- **Reusable Modules**: Modular design allows for easy reuse of configurations across different projects.
- **Multi-Provider Support**: Enabling deployment in multiple cloud environments.
- **Terragrunt Integration**: Utilizes Terragrunt for managing Terraform configurations, making it easier to handle complex setups.
- **Unit Testing**: Built-in workflows for unit testing to ensure the reliability of the infrastructure code.

## Directory Structure:

.
├── AWS # AWS modules
│   └── sailinstance
│       └── v1.0
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
...
..
.
├── Azure # Azure modules
│   └── resource-group
│       └── v1.0
│           ├── main.tf
│           ├── outputs.tf
│           ├── README.md
│           └── variables.tf
...
..
.
├── Linode # Linode modules
│   ├── instance
│   │   ├── v1.0
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── v2.0
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── README.md
│   │   │   └── variables.tf
│   │   └── v2.1
│   │       ├── config.tf
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── README.md
│   │       └── variables.tf
...
..
.
├── README.md
├── examples
│   ├── some example scripts, configurations and other staff
├── LICENSE
└── TgLab  # Terragrunt Lab for testing and development
    ├── azure.hcl
    ├── _env
    │   ├── azresgroup
    │   │   └── azresgroupV1.hcl
    │   └── instance
    │       └── instanceV2.hcl
    ├── environments
    │   ├── azure
    │   │   ├── env.hcl
    │   │   └── resgroup
    │   │       └── terragrunt.hcl
    │   └── linode
    │       ├── env.hcl
    │       └── instanceV2
    │           └── terragrunt.hcl
    ├── linode.hcl
    └── README.md

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) - Ensure you have the latest version installed.
- [Terragrunt](https://terragrunt.gruntwork.io/) - Install Terragrunt to manage your Terraform configurations.
- Cloud Provider Accounts - Set up accounts with AWS, Linode, Azure etc..., and obtain necessary API keys.

### Module Usage

You can directly import or retrieve the modules from this GitHub repository. For example, in the `TgLab` test environment, you can reference the modules in your Terragrunt configurations as follows:

```hcl
terraform {
  source = "https://github.com/shotalinux/IaC-Library.git//Linode/instance/v2.0"
}
```

## Acknowledgments

- Thanks to the Terraform and Terragrunt communities for their contributions and support.
