resource "azurerm_mssql_database" "mademidb" {
  name = "mdm-db"
  server_id = data.azurerm_mssql_server.mademisqlserver.id
  sku_name = "S0"
  license_type   = "LicenseIncluded"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  zone_redundant = false
}