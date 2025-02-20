resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}