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