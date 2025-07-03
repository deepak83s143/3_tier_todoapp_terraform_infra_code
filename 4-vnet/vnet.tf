resource "azurerm_virtual_network" "todo-vet" {
  name = "todo-vnet"
  resource_group_name = "todo-rg"
  location = "centralindia"
  address_space = [ "192.168.0.0/16" ]
}