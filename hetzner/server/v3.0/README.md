# Hetzner Cloud Server Terraform Module

This Terraform module provisions multiple [Hetzner Cloud](https://hetzner.cloud) servers with explicit names. It allows for **granular overrides**, enabling specific servers to have different configurations (e.g., different server types, images, or locations) while sharing a common default configuration.

## ✅ Features

- **Batch Provisioning:** Creates one `hcloud_server` resource for each name in the provided list.
- **Granular Overrides:** Customize specific servers (e.g., database nodes) differently from the defaults using the `server_overrides` map.
- **Networking:** Supports public (IPv4/IPv6) and private networking.
- **Security:** Easy configuration of Firewalls and SSH keys.
- **Cloud-init:** Supports user data for initialization.

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13
- [Hetzner Cloud Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest)

## 🚀 Usage

Here is a basic example of how to use this module:

```hcl
module "web_servers" {
  source = "./path/to/hcloudserver" # Or git URL

  names       = ["web-01", "web-02", "db-01"]
  server_type = "cx22"
  image       = "debian-11"
  location    = "fsn1"
  ssh_keys    = ["my-ssh-key"]

  # Specific overrides for the database server
  server_overrides = {
    "db-01" = {
      server_type = "cpx31"
      image       = "ubuntu-22.04"
      # You can also override location, user_data, etc.
    }
  }

  # Networking
  public_net = {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  
  labels = {
    environment = "production"
    terraform   = "true"
  }
}
```

## 📦 Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `names` | List of names for the servers. **Required**. | `list(string)` | - |
| `server_type` | Default server type (e.g., `cx22`). | `string` | `"cx22"` |
| `image` | Default OS image. | `string` | `"debian-11"` |
| `location` | Default location (e.g., `fsn1`). | `string` | `null` |
| `datacenter` | Default datacenter. | `string` | `null` |
| `server_overrides` | Map of server names to specific configurations. See below. | `map(object)` | `{}` |
| `ssh_keys` | List of SSH keys (names or IDs). | `list(string)` | `[]` |
| `user_data` | Default Cloud-init user data. | `string` | `null` |
| `labels` | Map of labels to apply to all servers. | `map(string)` | `{}` |
| `public_net` | Public network configuration. | `object` | `{ ipv4_enabled = true, ipv6_enabled = true }` |
| `networks` | List of private networks to attach. | `list(object)` | `[]` |
| `firewall_ids` | List of Firewall IDs to apply. | `list(number)` | `[]` |
| `backups` | Enable backups by default. | `bool` | `false` |
| `delete_protection` | Enable delete protection. | `bool` | `false` |
| `rebuild_protection` | Enable rebuild protection. | `bool` | `false` |
| `placement_group_id`| ID of the placement group. | `number` | `null` |

### Server Overrides

The `server_overrides` input allows you to specify a map where the key is the server name (must match one of the names in `names`), and the value is an object with any of the following optional fields:

- `server_type`
- `image`
- `location`
- `datacenter`
- `user_data`
- `keep_disk`
- `backups`
- `placement_group_id`

## 📤 Outputs

| Name | Description |
|------|-------------|
| `ids` | Map of server names to their IDs. |
| `names` | List of server names. |
| `ipv4_addresses` | Map of server names to their IPv4 addresses. |
| `ipv6_addresses` | Map of server names to their IPv6 addresses. |
| `full_details` | Map containing full details (ID, status, IP, etc.) for each server. |
