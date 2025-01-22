output "vpc_id" {
  description = "The ID of the created VPC"
  value       = linode_vpc.thevpc.id
}

output "vpc_created" {
  description = "The date and time when the VPC was created"
  value       = linode_vpc.thevpc.created
}

output "vpc_updated" {
  description = "The date and time when the VPC was last updated"
  value       = linode_vpc.thevpc.updated
}
