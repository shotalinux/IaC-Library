output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_address_prefix" {
  value = tolist(azurerm_virtual_network.this.subnet)[0].address_prefix
}