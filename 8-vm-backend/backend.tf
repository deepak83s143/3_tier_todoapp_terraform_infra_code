resource "azurerm_linux_virtual_machine" "todo-backend" {
  name                = "todo-backend-vm"
  resource_group_name = "todo-rg"
  location            = "centralindia"
  size                = "Standard_D2s_v3"
  network_interface_ids = [data.azurerm_network_interface.todo-interface.id]

  admin_username = data.azurerm_key_vault_secret.vm-username.value
  admin_password = data.azurerm_key_vault_secret.vm-password.value

  disable_password_authentication = false

  os_disk {
    name                 = "backend-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    # create_option        = "FromImage"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  computer_name = "backend-vm"

  custom_data = base64encode(<<EOF
#!/bin/bash
set -e
echo '${local.odbc_connection_string}' > /home/mademi/odbc_connection_string.txt
# Update and install prerequisites
apt update
apt install -y software-properties-common curl gnupg2 ca-certificates

# Add deadsnakes PPA and install Python 3.10
add-apt-repository -y ppa:deadsnakes/ppa
apt update
apt install -y python3.10
apt install -y python3.10-distutils curl
curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.10 get-pip.py

# Clone your app
cd /opt
git clone https://github.com/deepak83s143/PyTodoBackendMonolith.git
cd PyTodoBackendMonolith
touch .env
echo -n "CONNECTION_STRING=" > .env
cat /home/mademi/odbc_connection_string.txt >> .env
# Optional: Set python3.10 as default
#update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
#update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install pip requirements
python3.10 -m pip install -r requirements.txt

# Install ODBC driver
apt-get install -y unixodbc unixodbc-dev
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Start FastAPI app using uvicorn in background
nohup uvicorn app:app --host 0.0.0.0 --port 8000 &

EOF
)

}

