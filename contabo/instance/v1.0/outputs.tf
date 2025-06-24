output "instance_id" {
  description = "ID of the created instance"
  value       = contabo_instance.custom_instance.id
}

output "custom_instance_output" {
  description = "Our first custom instance"
  value = contabo_instance.custom_instance
}