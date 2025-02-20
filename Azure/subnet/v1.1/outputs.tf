output "subnet_id" {
    value = azurerm_subnet.example[*].id  // Outputting a list of all subnet IDs
}

output "subnet_cidr" {
    value = azurerm_subnet.example[*].address_prefixes[0]  // Outputting a list of all subnet CIDR blocks
}