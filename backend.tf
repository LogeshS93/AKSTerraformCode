terraform {
  backend "azurerm" {
    subscription_id      = "06d7b9e6-3cfd-42f4-adcd-6e53d58e3320"
    resource_group_name  = "backend-rg"
    storage_account_name = "backendsalab01"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}