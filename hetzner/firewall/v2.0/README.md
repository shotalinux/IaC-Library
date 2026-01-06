# Hetzner Cloud Firewall Terraform Module

This Terraform module creates a Firewall in Hetzner Cloud and optionally attaches it to servers using IDs or Label Selectors.

## Usage

```hcl
module "my_firewall" {
  source = "./path/to/hcloudfire"

  name = "my-secure-firewall"

  labels = {
    environment = "production"
    owner       = "devops"
  }

  rules = [
    {
      direction       = "in"
      protocol        = "tcp"
      port            = "22"
      source_ips      = ["0.0.0.0/0", "::/0"]
      description     = "Allow SSH from anywhere"
    },
    {
      direction       = "in"
      protocol        = "tcp"
      port            = "80"
      source_ips      = ["0.0.0.0/0"]
      description     = "Allow HTTP"
    },
    {
      direction       = "out"
      protocol        = "tcp"
      port            = "443"
      destination_ips = ["0.0.0.0/0"]
      description     = "Allow HTTPS outbound"
    }
  ]

  # Attach to specific servers
  server_ids = [123456, 789012]

  # Or attach to servers matching these labels
  label_selectors = ["env=production"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Hetzner firewall | `string` | n/a | yes |
| `rules` | List of firewall rules | `list(object)` | n/a | yes |
| `labels` | User-defined labels (key-value pairs) | `map(string)` | `{}` | no |
| `server_ids` | List of server IDs to attach firewall to | `list(number)` | `[]` | no |
| `label_selectors` | List of label selectors to attach firewall to | `list(string)` | `[]` | no |

### Rule Object Structure

The `rules` list expects objects with the following attributes:

*   `direction` (Required): "in" or "out".
*   `protocol` (Required): "tcp", "udp", "icmp", "esp", or "gre".
*   `port` (Optional): Port or port range (e.g., "80", "80-85"). Required for TCP/UDP.
*   `source_ips` (Optional): List of CIDRs (e.g., `["10.0.0.0/16"]`). Required for direction "in".
*   `destination_ips` (Optional): List of CIDRs. Required for direction "out".
*   `description` (Optional): Description of the rule.

## Outputs

| Name | Description |
|------|-------------|
| `firewall_id` | The ID of the created firewall |
| `firewall_name` | The name of the created firewall |

## Requirements

*   Terraform >= 1.3.0
*   `hetznercloud/hcloud` provider >= 1.45.0
