data "azurerm_mssql_server" "sql-server" {
  name = "mademisqlserver"
  resource_group_name = "todo-rg"
}

data "azurerm_mssql_database" "test-database" {
  name = "mdm-db"
  server_id = data.azurerm_mssql_server.sql-server.id
}

data "azurerm_network_interface" "todo-interface" {
  name = "backend-interface"
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

data "azurerm_key_vault_secret" "sqluser" {
  name = "sqluser"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}
data "azurerm_key_vault_secret" "sqlpasswd" {
  name = "sqlpasswd"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}


locals {
    odbc_connection_string = "Driver={ODBC Driver 17 for SQL Server};Server=tcp:${data.azurerm_mssql_server.sql-server.fully_qualified_domain_name};Database=${data.azurerm_mssql_database.test-database.name};Uid=${data.azurerm_key_vault_secret.sqluser.value};Pwd=${data.azurerm_key_vault_secret.sqlpasswd.value};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
}



output "odbc_connection_string" {
  value = local.odbc_connection_string
  sensitive = true
}






