resource "linode_stackscript" "example" {
  label       = var.stackscript_label
  description = var.stackscript_description
  script      = var.stackscript_script

  images      = var.imgs
}
