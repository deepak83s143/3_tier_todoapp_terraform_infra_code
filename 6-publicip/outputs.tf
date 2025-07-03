output "backend_ip_address" {
  value = azurerm_public_ip.todo-pip.ip_address
}

output "frontend_ip_address" {
  value = azurerm_public_ip.todo-pip-frontend.ip_address
}