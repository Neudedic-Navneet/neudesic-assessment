output "vnet_out" {
    value = azurerm_subnet.subnet1.name
}

output "subnetId_out" {
  value = azurerm_subnet.subnet1.id
}