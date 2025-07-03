data "azurerm_network_interface" "todo-interface-frontend" {
  name = "frontend-interface"
  resource_group_name = "todo-rg"
}

data "azurerm_key_vault" "mademikv" {
  name = "mademi-keyvault"
  resource_group_name = "mademi-rg"
}

data "azurerm_key_vault_secret" "vm-username" {
  name = "vm-admin"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}
data "azurerm_key_vault_secret" "vm-password" {
  name = "vm-pass"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}

data "azurerm_public_ip" "frontend_ip_address" {
  name = "todo-pip-frontend"
  resource_group_name = "todo-rg"
}
data "azurerm_public_ip" "backend_ip_address" {
  name = "todo-pip"
  resource_group_name = "todo-rg"
}
locals {
  frontend-vm-ip = data.azurerm_public_ip.frontend_ip_address.ip_address
}

locals {
  backend_ip_address = data.azurerm_public_ip.backend_ip_address.ip_address
}