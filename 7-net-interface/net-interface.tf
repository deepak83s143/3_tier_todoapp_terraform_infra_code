data "azurerm_public_ip" "todo-pip" {
  name = "todo-pip"
  resource_group_name = "todo-rg"
}
data "azurerm_public_ip" "todo-pip-frontend" {
  name = "todo-pip-frontend"
  resource_group_name = "todo-rg"
}
data "azurerm_subnet" "todo-subnet"{
  name = "todo-subnet"
  virtual_network_name = "todo-vnet"
  resource_group_name = "todo-rg"
}

resource "azurerm_network_interface" "todo-interface-backend" {
  name = "backend-interface"
  resource_group_name = "todo-rg"
  location = "centralindia"
  ip_configuration {
    name = "backend"
    private_ip_address_allocation = "Dynamic"
    subnet_id = data.azurerm_subnet.todo-subnet.id
    public_ip_address_id = data.azurerm_public_ip.todo-pip.id
  }
  
}

resource "azurerm_network_interface" "todo-interface-frontend" {
  name = "frontend-interface"
  resource_group_name = "todo-rg"
  location = "centralindia"
  ip_configuration {
    name = "frontend"
    private_ip_address_allocation = "Dynamic"
    subnet_id = data.azurerm_subnet.todo-subnet.id
    public_ip_address_id = data.azurerm_public_ip.todo-pip-frontend.id
  }
  
}

