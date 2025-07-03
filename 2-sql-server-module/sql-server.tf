resource "azurerm_mssql_server" "mademisql" {
    name = "mademisqlserver"
    resource_group_name = "todo-rg"
    location = "centralindia"
    version = "12.0"
    administrator_login = data.azurerm_key_vault_secret.username.value
    administrator_login_password = data.azurerm_key_vault_secret.password.value
}

resource "azurerm_mssql_firewall_rule" "allow_all_ips" {
  depends_on = [ azurerm_mssql_server.mademisql ]
  name                = "AllowAllIPs"
  server_id           = azurerm_mssql_server.mademisql.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}