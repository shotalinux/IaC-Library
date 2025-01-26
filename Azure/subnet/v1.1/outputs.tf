output "subnet_id" {
  value = azurerm_subnet.example.id
  description = "The ID of the created subnet"
}

output "subnet_cidr" {
  value = azurerm_subnet.example.address_prefixes[0]
  description = "The CIDR of the first address prefix of the subnet"
}