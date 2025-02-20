# outputs.tf

output "instance_id" {
  value = aws_lightsail_instance.lightinstance.id
}

output "public_ip_address" {
  value = aws_lightsail_instance.lightinstance.public_ip_address
}

output "private_ip_address" {
  value = aws_lightsail_instance.lightinstance.private_ip_address
}

output "tags_all" {
  value = aws_lightsail_instance.lightinstance.tags_all
}

output "username" {
  value = aws_lightsail_instance.lightinstance.username
}
