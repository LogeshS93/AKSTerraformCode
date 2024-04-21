terraform {
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "backendSaLab01"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}