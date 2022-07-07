resource "azurerm_resource_group" "resource_group" {
  name     = "${var.basename}-RG"
  location = var.location
}