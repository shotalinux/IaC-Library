locals {
  # Alphabet for alpha suffixes
  alphabet = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  ]

  # Generate AA..ZZ pool (26×26 = 676 combinations)
  alpha_pool = flatten([
    for i in local.alphabet : [
      for j in local.alphabet : "${i}${j}"
    ]
  ])

  # Compute alpha suffixes (supports up to 676 replicas)
  alpha_suffixes = [
    for i in range(var.replicas) : local.alpha_pool[i]
  ]

  # Compute numeric suffixes with zero padding
  numeric_suffixes = [
    for i in range(var.replicas) : format("%0${var.zero_padding}d", var.start_index + i)
  ]

  # Choose suffix style with fallback
  suffixes = (
    var.suffix_style == "numeric" ? local.numeric_suffixes :
    (var.suffix_style == "alpha" ? local.alpha_suffixes : [])
  )

  # Build the base name components
  name_components = compact([var.namepref, var.environment_string, var.custom_string])

  # Join them with separator
  base_name_prefix = join(var.separator, local.name_components)

  # Generate replica names with prefix + separator + suffix
  raw_replica_names = (
    local.base_name_prefix != "" && var.replicas > 0 ?
    [for i in range(var.replicas) : "${local.base_name_prefix}${var.separator}${local.suffixes[i]}"] :
    []
  )

  # Combine generated names and explicit names list
  combined_list = concat(local.raw_replica_names, var.nameslist)

  # Apply slugify (remove invalid characters, enforce lowercase)
  slugified_names = [
    for n in local.combined_list : lower(replace(replace(n, "/[^a-zA-Z0-9-_]/", ""), "/--+/", "-"))
  ]

  # Apply case transformation
  cased_names = (
    var.case == "lower" ? [for n in local.slugified_names : lower(n)] :
    var.case == "upper" ? [for n in local.slugified_names : upper(n)] :
    local.slugified_names
  )

  # Enforce max length
  final_capped = [for n in local.cased_names : substr(n, 0, var.max_length)]

  # Deduplicate if requested
  final_names = var.distinct ? distinct(local.final_capped) : local.final_capped
}