data "azurerm_mssql_server" "mademisqlserver" {
  name = "mademisqlserver"
  resource_group_name = "todo-rg"
}