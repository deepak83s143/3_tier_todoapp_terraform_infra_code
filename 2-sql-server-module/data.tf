data "azurerm_resource_group" "rg" {
  name = "mademi-rg"
}

data "azurerm_key_vault" "mademikv" {
  resource_group_name = data.azurerm_resource_group.rg.name
  name = "mademi-keyvault"
}

data "azurerm_key_vault_secret" "username" {
  name = "sqluser"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}

data "azurerm_key_vault_secret" "password" {
  name = "sqlpasswd"
  key_vault_id = data.azurerm_key_vault.mademikv.id
}