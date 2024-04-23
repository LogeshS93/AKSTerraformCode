variable "rg_name" {
   type = string
   description = "resource group name variable"
}

variable "rg_location" {
  type = string
  default = "uksouth"
}

variable "service_principal_name" {
  type = string
  description = "name of the service principal"
}

variable "key_vault_name" {
  type = string
}


variable "container_registry_name" {
  type = string
}

variable "aks_cluster_name" {
  type = string
}

