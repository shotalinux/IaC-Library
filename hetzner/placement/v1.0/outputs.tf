output "id" {
  value       = hcloud_placement_group.this.id
  description = "ID of the placement group."
}

output "name" {
  value       = hcloud_placement_group.this.name
}

output "type" {
  value       = hcloud_placement_group.this.type
}