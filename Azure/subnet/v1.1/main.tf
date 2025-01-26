resource "azurerm_subnet" "example" {
  count                 = length(var.address_prefixes)
  name                  = format("%s-%d", var.subnet_name, count.index)
  resource_group_name   = var.rg_name
  virtual_network_name  = var.virtual_network_name
  address_prefixes      = [var.address_prefixes[count.index]] # Wrap in a list

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