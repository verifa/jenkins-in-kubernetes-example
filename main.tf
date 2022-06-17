provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
}

# Resource Group
resource "azurerm_resource_group" "jenkinsk8sexample" {
  name     = "rg-jenkinsk8sexample"
  location = "West Europe"
}