output "vnet_out" {
    value = azurerm_virtual_network.virtual_network.name
}

output "vnet_id" {
  value = azurerm_virtual_network.virtual_network.id
}