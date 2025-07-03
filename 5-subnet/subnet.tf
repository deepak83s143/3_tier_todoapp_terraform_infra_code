resource "azurerm_subnet" "todo-subnet" {
  name = "todo-subnet"
  resource_group_name = "todo-rg"
  virtual_network_name = "todo-vnet"
  address_prefixes = [ "192.168.1.0/24" ]
}