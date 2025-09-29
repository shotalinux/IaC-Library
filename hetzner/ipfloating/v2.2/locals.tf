locals {
  # Ensure home_location is set only if no server_ids are given
  effective_home_location = (
    length(var.server_ids) > 0 ? null :
    (var.home_location != null ? var.home_location : "nbg1")
  )

  # Used to print a warning if fallback applied
  used_fallback = (
    var.home_location == null && length(var.server_ids) == 0
  )
}

# Validation: prevent both home_location and server_ids being set
resource "null_resource" "validate_conflict" {
  count = (var.home_location != null && length(var.server_ids) > 0) ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'ERROR: You cannot set both home_location and server_ids at the same time!' && exit 1"
  }
}

# Warn only if fallback default applied
resource "null_resource" "warn_fallback" {
  count = local.used_fallback ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'WARNING: No home_location or server_ids provided. Defaulting home_location to nbg1.'"
  }
}