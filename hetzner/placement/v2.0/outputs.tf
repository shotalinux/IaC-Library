output "ids" {
  value       = [for pg in hcloud_placement_group.this : pg.id]
  description = "IDs of the placement groups."
}

output "names" {
  value       = [for pg in hcloud_placement_group.this : pg.name]
  description = "Names of the placement groups."
}

output "types" {
  value       = [for pg in hcloud_placement_group.this : pg.type]
  description = "Types of the placement groups."
}