output "resource_group_id" {
  description = "The ID of the Resource Group."
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the Resource Group."
  value       = azurerm_resource_group.rg.location
}

output "resource_group_tags" {
  description = "The tags assigned to the Resource Group."
  value       = azurerm_resource_group.rg.tags
}
