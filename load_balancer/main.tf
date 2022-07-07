resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.publicipId_out
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id     = azurerm_lb.load_balancer.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "probe" {
 loadbalancer_id     = azurerm_lb.load_balancer.id
 name                = "probe"
 port                = 80
}

resource "azurerm_lb_rule" "lbnatrule" {
   loadbalancer_id                = azurerm_lb.load_balancer.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = 80
   backend_port                   = 80
   backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bpepool.id]
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.probe.id
}

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
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }
  
}

data "azurerm_image" "image" {
  name = "myPackerImage"
  resource_group_name = "navneet-packer-rg"
}