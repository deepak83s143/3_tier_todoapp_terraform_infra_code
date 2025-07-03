terraform {
  required_version = "1.12.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "mademi-rg"
    storage_account_name = "mademisa"
    container_name       = "mademistatefiles"
    key                  = "sqldb.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "171c73ab-6be7-46a1-8601-e56a64c29e2d"
}