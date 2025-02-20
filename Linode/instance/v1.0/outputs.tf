output "linode_instance_ip" {
  description = "The public IP address of the Linode instance."
  value       = linode_instance.LinstanceV1.ip_address
}

output "linode_instance_id" {
  description = "The ID of the Linode instance."
  value       = linode_instance.LinstanceV1.id
}

output "linode_instance_label" {
  description = "The label of the Linode instance."
  value       = linode_instance.LinstanceV1.label
}

output "generated_password" {
  value      = local.root_password
  sensitive  = true
}
