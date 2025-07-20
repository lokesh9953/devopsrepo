resource "azurerm_subnet" "subnet" {
  name                = var.subnet
  resource_group_name = var.resource_group_name
  address_prefixes =  var.address_prefixes
  virtual_network_name = var.virtual_network_name
}