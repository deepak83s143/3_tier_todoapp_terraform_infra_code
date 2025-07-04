terraform {
  required_version = "1.12.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "mademi-rg"     ##### RG Name  
    storage_account_name = "mademisa"      #### Storage Account Group
    container_name       = "mademistatefiles"   ###### Container Name
    key                  = "sqldb.terraform.tfstate"   ###### Key/File name.
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<Subscription ID>"
}
