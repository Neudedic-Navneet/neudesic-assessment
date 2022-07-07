resource "azurerm_windows_virtual_machine_scale_set" "Vmss" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard_B1s"
  instances           = 2
  admin_password      = "password@123"
  admin_username      = "demouser"

  source_image_id = data.azurerm_image.image.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = var.nic_name
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnetID
      load_balancer_backend_address_pool_ids = [var.backendPoolID]
    }
  }
  
}