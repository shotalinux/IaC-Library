resource "linode_vpc_subnet" "sbnt" {
  vpc_id = var.vpc_id
  label  = var.subnet_label
  ipv4   = var.subnet_ipv4
}
