resource "azurerm_virtual_network" "web" {
  address_space       = [var.address_space]
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}