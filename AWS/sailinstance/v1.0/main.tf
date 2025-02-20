# main.tf

resource "aws_lightsail_instance" "lightinstance" {
  name              = var.instance_name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.size_id
  tags = var.tags

  # Specify SSH key pair for authentication
  key_pair_name = var.keypair

  # Provision part
  user_data         = var.script
}
