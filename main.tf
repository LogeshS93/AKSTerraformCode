data "azurerm_subscription" "primary" {
}

resource "azurerm_resource_group" "rg1" {
  name     = var.rg_name
  location = var.rg_location
}

module "service_principal" {
  source                 = "./modules/ServicePrincipal"
  service_principal_name = var.service_principal_name

  depends_on = [
    azurerm_resource_group.rg1
  ]
}

module "key_vault" {
  source                 = "./modules/KeyVault"
  key_vault_name = var.key_vault_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  service_principal_name = var.service_principal_name
  service_principal_object_id = module.service_principal.service_principal_object_id
  service_principal_tenant_id = module.service_principal.service_principal_tenant_id
  
  depends_on = [
    module.service_principal
  ]
}

resource "azurerm_key_vault_secret" "kvtsec" {
  name         = module.service_principal.client_id
  value        = module.service_principal.client_secret
  key_vault_id = module.key_vault.keyvault_id

  depends_on = [
    module.key_vault
  ]
}

module "AKS" {
  source = "./modules/AKS"
  container_registry_name = var.container_registry_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  aks_cluster_name = var.aks_cluster_name
  client_id = module.service_principal.client_id
  client_secret = module.service_principal.client_secret
  service_principal_object_id = module.service_principal.service_principal_object_id

  depends_on = [
    module.service_principal
  ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.AKS]
  filename     = "./kubeconfig"
  content      = module.AKS.config
  
}

