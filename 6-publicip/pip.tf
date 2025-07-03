resource "azurerm_public_ip" "todo-pip" {
  name = "todo-pip"
  resource_group_name = "todo-rg"
  location = "centralindia"
  allocation_method = "Dynamic"
  sku = "Basic"
}

resource "azurerm_public_ip" "todo-pip-frontend" {
  name = "todo-pip-frontend"
  resource_group_name = "todo-rg"
  location = "centralindia"
  allocation_method = "Dynamic"
  sku = "Basic"
}

