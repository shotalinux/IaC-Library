output "linode_instance_ip" {
  description = "The public IP addresses of the Linode instances."
  value       = [for instance in linode_instance.LinstanceV2 : instance.ip_address]
}

output "linode_instance_ids" {
  description = "The IDs of the Linode instances."
  value       = linode_instance.LinstanceV2[*].id
}

output "linode_instance_labels" {
  description = "The labels of the Linode instances."
  value       = linode_instance.LinstanceV2[*].label
}

output "generated_password" {
  description = "The generated root password for the Linode instances."
  value       = local.root_password
  sensitive   = true
}
