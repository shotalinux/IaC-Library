
# hcloudnets

Terraform module for provisioning **multiple Hetzner Cloud networks**, **subnets**, and **static routes** with consistent names.  
It supports three allocation modes:

- **AUTO** – Super‑CIDR slicing with deterministic network/subnet generation and optional **auto‑routing**  
- **MANUAL** – Fully explicit map of network objects  
- **HYBRID** – Auto‑generates networks from a list, while allowing **manual overrides** or **sidecar additions**

> Works well with a naming module, but accepts any list of strings via `var.names`.

---

## ✅ Features

- **Hybrid Allocation**: Mix auto‑calculated CIDRs with manually defined special cases.
- **AUTO Mode**:
  - Derive network CIDRs from a base Super‑CIDR via `cidrsubnet`.
  - Derive a **default first subnet** per network.
  - Global toggle for `expose_routes_to_vswitch`.
  - **Optional** automatic route generation (Mesh or Hub‑and‑Spoke).
- **MANUAL Mode**:
  - Full control: per‑network CIDRs, subnets (Cloud or vSwitch), and routes.
  - Support for **vSwitch** subnets (L2 connection to dedicated servers).
- **Rich Outputs**: ID maps and full metadata for downstream modules.

---

## 📦 Inputs

### Mode Selection

- `mode` (string): `"auto"`, `"manual"`, or `"hybrid"`.  
  **Default:** `"auto"`

### AUTO / HYBRID Settings

- `names` (list(string)): List of network names to generate.
- `base_cidr` (string): Super‑CIDR for slicing (e.g., `"10.0.0.0/8"`).  
  **Default:** `"10.0.0.0/8"`
- `network_newbits` (number): Bits added for network allocation (e.g., `8` → `/16`).  
  **Default:** `8`
- `subnet_newbits` (number): Bits added for default subnets (e.g., `8` → `/24`).  
  **Default:** `8`
- `network_zone` (string): Zone for default subnets.  
  **Default:** `"eu-central"`
- `labels` (map(string)): Labels applied to automatically created networks.
- `auto_expose_routes_to_vswitch` (bool): Whether auto networks expose routes to vSwitch.  
  **Default:** `false`

#### Auto Routing

- `auto_routes_enabled` (bool): Enable automatic route generation.  
  **Default:** `false`
- `auto_route_strategy` (string): `"none"`, `"peer"`, or `"hub_spoke"`.
- `auto_hub_name` (string): Hub network name (for `"hub_spoke"`).
- `auto_default_destination` (string): Destination for auto routes (e.g., `"0.0.0.0/0"`).
- `auto_gateway_host_index` (number): Host index for route gateway (e.g., `5` → `.5`).

### MANUAL / HYBRID Overrides

`manual_config` (map(object)):

- **Manual Mode:** Defines all networks.
- **Hybrid Mode:** Overrides specific auto‑generated networks or adds new ones.

```hcl
{
  "net-name" = {
    ip_range = "10.0.0.0/16"
    subnets = [
      {
        ip_range   = "10.0.1.0/24"
        type       = "cloud" # or "vswitch"
        zone       = "eu-central"
        vswitch_id = 12345   # required if type = "vswitch"
      }
    ]
    routes = [...]
    expose_routes_to_vswitch = true
    labels = { ... }
  }
}
```

- `extra_routes` (map(list)): Add extra static routes to **any** network (auto or manual).

---

## 🔄 How Hybrid Mode Works

1. **Auto Calculation**: All names in `var.names` are converted into deterministic network objects.
2. **Manual Merge**:
   - If a key exists **only in Manual**, it is added.
   - If a key exists in **both**, Manual configuration overrides Auto.

---

## 📄 Examples

### Hybrid Mode (Typical)

Auto‑generate 3 networks, but override the first one as a custom “Hub”.

```hcl
module "hcloudnets" {
  source = "./modules/hcloudnets"

  mode  = "hybrid"
  names = ["net-hub", "net-spoke-01", "net-spoke-02"]

  # Auto settings (applied to spoke-01, spoke-02)
  base_cidr       = "10.0.0.0/8"
  network_newbits = 8

  # Manual override for net-hub
  manual_config = {
    "net-hub" = {
      ip_range = "10.100.0.0/16"
      subnets = [
        { ip_range = "10.100.1.0/24", type = "cloud", zone = "eu-central" }
      ]
      expose_routes_to_vswitch = true
    }
  }
}
```

### vSwitch Subnet Example

```hcl
manual_config = {
  "hybrid-net" = {
    ip_range = "10.0.0.0/16"
    subnets = [
      {
        ip_range   = "10.0.1.0/24"
        type       = "vswitch"
        zone       = "eu-central"
        vswitch_id = 456789
      }
    ]
  }
}
```

---

## 🔍 Outputs

- `network_ids` — map(name → network_id)
- `networks_full` — detailed metadata including:
   - `id`
  - `name`
  - `network_cidr`
  - `labels`
  - `expose_routes_to_vswitch`
  - `subnets[]`
  - `routes[]`
- `names` — list of names from the input.
- `computed_config` — effective configuration after merging auto + manual.
- `warnings` — optional diagnostics (invalid CIDRs, manual mismatches).

---

## ⚠️ Requirements

- Terraform **v1.3+**
- Hetzner Cloud Provider: `hetznercloud/hcloud`

---

## 📄 License

MIT License