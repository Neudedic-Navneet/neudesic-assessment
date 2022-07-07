  resource "azurerm_subnet" subnet1 {
    name           = var.subnet
  address_prefixes     = ["10.0.1.0/24"]
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet_name
  }