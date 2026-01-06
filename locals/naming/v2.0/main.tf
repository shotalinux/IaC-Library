# Preconditions (Terraform >= 1.3)
resource "terraform_data" "preconditions" {
  lifecycle {
    ignore_changes = all

    # Ensure at least one naming method is provided
    precondition {
      condition     = length(local.final_names) > 0
      error_message = "Either provide non-empty name components (namepref, environment_string, custom_string) with 'replicas' > 0, or a non-empty 'nameslist'."
    }

    # Validate alpha suffix limit
    precondition {
      condition     = !(var.suffix_style == "alpha" && var.replicas > length(local.alpha_pool))
      error_message = "alpha suffix_style supports up to 676 replicas (AA..ZZ). Increase limit or use numeric."
    }
  }
}