output "load_balancer_name" {
  value = azurerm_lb.load_balancer.name
}

output "load_balancer_backend_address_pool_ids_out" {
  value = [azurerm_lb_backend_address_pool.bpepool.id]
}