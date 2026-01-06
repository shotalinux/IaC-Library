locals {
  names = var.names
}

# 2. AUTO Config Calculation
#    Calculates deterministic CIDRs for every name in the list.
locals {
  auto_config = {
    for idx, name in local.names : name => {
      network_cidr = cidrsubnet(var.base_cidr, var.network_newbits, idx)

      subnets = [
        {
          ip_range   = cidrsubnet(cidrsubnet(var.base_cidr, var.network_newbits, idx), var.subnet_newbits, 1)
          type       = "cloud"
          zone       = var.network_zone
          vswitch_id = null
        }
      ]

      routes                   = []
      expose_routes_to_vswitch = var.auto_expose_routes_to_vswitch
      labels                   = var.labels
    }
  }
}

# 3. MANUAL Config Normalization
#    Standardizes inputs and ensures optional fields (like vswitch_id) exist.
locals {
  manual_config_norm = {
    for name, v in var.manual_config : name => {
      network_cidr             = v.ip_range
      
      subnets = [
        for s in v.subnets : {
          ip_range   = s.ip_range
          type       = s.type
          zone       = s.zone
          vswitch_id = try(s.vswitch_id, null)
        }
      ]
      
      routes                   = try(v.routes, [])
      expose_routes_to_vswitch = try(v.expose_routes_to_vswitch, false)
      labels                   = try(v.labels, {})
    }
  }
}

# 4. HYBRID MERGE LOGIC (The Core)
#    - Auto: Use Auto only.
#    - Manual: Use Manual only.
#    - Hybrid: Merge Manual ON TOP of Auto (Override + Append).
locals {
  final_config = (
    var.mode == "auto"   ? local.auto_config :
    var.mode == "manual" ? local.manual_config_norm :
    merge(local.auto_config, local.manual_config_norm)
  )
}

# 5. Routing Logic
#    Derive Gateway IPs (Auto-calculated even in Hybrid for auto-generated parts)
locals {
  # Get Gateway IP for the FIRST subnet of any network
  gateway_ip_by_name = {
    for name, net in local.final_config :
    name => try(cidrhost(net.subnets[0].ip_range, var.auto_gateway_host_index), null)
  }

  # Strategy: Peer (Mesh)
  auto_routes_peer = flatten([
    for src_name, src_cfg in local.final_config : [
      for dst_name, dst_cfg in local.final_config : {
        net_name    = src_name
        destination = dst_cfg.network_cidr
        gateway     = local.gateway_ip_by_name[src_name]
      } if dst_name != src_name
    ]
  ])

  # Strategy: Hub-Spoke
  auto_routes_hub_spoke = flatten([
    for name, net in local.final_config : name != var.auto_hub_name ? [
      {
        net_name    = name
        destination = var.auto_default_destination
        gateway     = local.gateway_ip_by_name[name]
      }
    ] : []
  ])

  # Select Strategy
  # (Only apply auto-routes if enabled. Works in Hybrid too!)
  auto_routes_selected = (
    !var.auto_routes_enabled || var.auto_route_strategy == "none" ? [] :
    var.auto_route_strategy == "peer" ? local.auto_routes_peer :
    var.auto_route_strategy == "hub_spoke" ? local.auto_routes_hub_spoke :
    []
  )
}

# 6. Final Effective Configuration
#    Merge Base Config + Extra Routes + Auto Routes
locals {
  final_config_effective = {
    for name, cfg in local.final_config : name => merge(
      cfg,
      {
        routes = concat(
          try(cfg.routes, []),            # Existing routes (from Manual or Empty Auto)
          try(var.extra_routes[name], []), # Manual Extra Routes
          [
            for r in local.auto_routes_selected : r
            if r != null && r.net_name == name
          ]
        )
      }
    )
  }
}

# 7. Flatteners for Resources
locals {
  subnets_flat = flatten([
    for net_name, net in local.final_config_effective : [
      for s in net.subnets : {
        key        = "${net_name}::${s.ip_range}"
        net_name   = net_name
        ip_range   = s.ip_range
        type       = s.type
        zone       = s.zone
        vswitch_id = s.vswitch_id
      }
    ]
  ])

  routes_flat = flatten([
    for net_name, net in local.final_config_effective : [
      for r in net.routes : {
        key         = "${net_name}::${r.destination}"
        net_name    = net_name
        destination = r.destination
        gateway     = r.gateway
      }
    ]
  ])
}

# 8. Diagnostics
locals {
  # In Hybrid, extra keys are allowed. In Manual, they are warnings.
  manual_extra_keys = var.mode == "manual" ? setsubtract(toset(keys(var.manual_config)), toset(local.names)) : toset([])
  
  invalid_networks = [
    for name, cfg in local.final_config_effective :
    cfg.network_cidr if !can(cidrnetmask(cfg.network_cidr))
  ]
}