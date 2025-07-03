

resource "azurerm_linux_virtual_machine" "todo-frontend" {
  name                = "todo-frontend-vm"
  resource_group_name = "todo-rg"
  location            = "centralindia"
  size                = "Standard_D2s_v3"
  network_interface_ids = [data.azurerm_network_interface.todo-interface-frontend.id]

  admin_username = data.azurerm_key_vault_secret.vm-username.value
  admin_password = data.azurerm_key_vault_secret.vm-password.value

  disable_password_authentication = false

  os_disk {
    name                 = "frontend-disk"
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

  computer_name = "frontend-vm"

  custom_data = base64encode(<<EOF
#!/bin/bash
set -e

# Update and install prerequisites
apt update
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
apt install nodejs git -y

cd /opt
git clone https://github.com/deepak83s143/ReactTodoUIMonolith.git
cd ReactTodoUIMonolith

touch .env
echo "REACT_APP_API_BASE_URL=http://${local.backend_ip_address}:8000/api" > .env

npm install
npm run build
apt install -y nginx
cp -r build/* /var/www/html
cat > /etc/nginx/sites-available/default <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location /api {
        proxy_pass http://${local.backend_ip_address}:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL
systemctl restart nginx
EOF
)

}

