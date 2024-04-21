data "azurerm_kubernetes_service_versions" "current" {
  location = var.rg_location
}

resource "azurerm_container_registry" "acrlab" {
  name                = var.container_registry_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Premium"
}

resource "azurerm_kubernetes_cluster" "akslab" {
  name                = var.aks_cluster_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix            = "${var.rg_name}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.rg_name}-nrg"

  default_node_pool {
    name       = "defaultpool"
    vm_size    = "Standard_DS2_v2"
    zones   = [1, 2, 3]
    node_count = 2
    enable_auto_scaling  = true
    max_count            = 5
    min_count            = 2
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "user"
      "environment"      = "lab"
      "nodepoolos"       = "linux"
     } 
   tags = {
      "nodepool-type"    = "user"
      "environment"      = "lab"
      "nodepoolos"       = "linux"
   } 
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Lab"
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

}

resource "azurerm_role_assignment" "akslab" {
  principal_id                     = var.service_principal_object_id
  role_definition_name             = "AcrPush"
  scope                            = azurerm_container_registry.acrlab.id
  skip_service_principal_aad_check = true
}