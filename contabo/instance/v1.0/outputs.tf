output "instance_id" {
  description = "ID of the created instance"
  value       = contabo_instance.default_instance.id
}

output "instance_ip" {
  description = "Public IP of the instance"
  value       = contabo_instance.default_instance.public_ip
}