locals {
  # Alphabet for alpha suffix style
  alphabet = [
    "A","B","C","D","E","F","G","H","I","J","K","L","M",
    "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
  ]

  # Generate suffixes (numeric padded or alphabetic)
  suffixes = (
    var.suffix_style == "numeric"
    ? [for i in range(var.replicas) : format("%0${var.zero_padding}d", i + var.start_index)]
    : (
      var.suffix_style == "alpha"
      ? [for i in range(var.replicas) : element(local.alphabet, i)]
      : []
    )
  )

  # Create replica names if prefix is given
  replica_names = (
    var.namepref != null && var.namepref != "" && var.replicas > 0
    ? [for i in range(var.replicas) : "${var.namepref}${local.suffixes[i]}"]
    : []
  )

  # Combine replica names with explicit names list
  final_names = concat(local.replica_names, var.nameslist)

  # Validation: at least one naming method provided
  invalid_input = length(local.final_names) == 0
}

# Validation: at least one naming method
resource "null_resource" "validate" {
  count = local.invalid_input ? 1 : 0
  provisioner "local-exec" {
    command = "echo 'ERROR: Either namepref or nameslist must be provided!' && exit 1"
  }
}

output "names" {
  value = local.final_names
}