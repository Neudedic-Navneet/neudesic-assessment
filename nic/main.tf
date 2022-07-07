resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetID
    private_ip_address_allocation = "Dynamic"
  }
}

output "nic_name" {
  value = azurerm_network_interface.nic.name
}