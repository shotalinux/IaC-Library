output "subnet_id" {
  value = azurerm_subnet.example.id
}

output "subnet_cidr" {
  value = azurerm_subnet.example.address_prefix
}