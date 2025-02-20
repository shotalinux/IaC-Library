output "subnet_id" {
  description = "The ID of the created VPC Subnet"
  value       = linode_vpc_subnet.sbnt.id
}

output "subnet_linodes" {
  description = "A list of Linode IDs that are added to this subnet"
  value       = linode_vpc_subnet.sbnt.linodes
}

output "subnet_created" {
  description = "The date and time when the VPC Subnet was created"
  value       = linode_vpc_subnet.sbnt.created
}

output "subnet_updated" {
  description = "The date and time when the VPC Subnet was last updated"
  value       = linode_vpc_subnet.sbnt.updated
}
