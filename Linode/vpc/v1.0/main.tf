resource "linode_vpc" "thevpc" {
  label       = var.vpc_label
  region      = var.region
  description = var.vpc_description
}
