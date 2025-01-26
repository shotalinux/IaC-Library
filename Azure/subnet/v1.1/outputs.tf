output "subnet_id" {
    value = azurerm_subnet.example[count.index].id  // Accessing the id using count.index
}

output "subnet_cidr" {
    value = azurerm_subnet.example[count.index].address_prefixes[0]  // Accessing the address_prefixes using count.index
}