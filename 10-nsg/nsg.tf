data "azurerm_network_interface" "todo-backend-interface" {
  name = "backend-interface"
  resource_group_name = "todo-rg"
}
resource "azurerm_network_security_group" "todo-nsg" {
  name                = "todo-nsg"
  location            = "centralindia"
  resource_group_name = "todo-rg"
  security_rule {
    name                       = "8000"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "22"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "3306"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "link_nsg" {
  network_interface_id = data.azurerm_network_interface.todo-backend-interface.id
  network_security_group_id = azurerm_network_security_group.todo-nsg.id
}