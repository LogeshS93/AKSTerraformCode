variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "container_registry_name" {
  type = string
}

variable "aks_cluster_name" {
  type = string
}

variable "client_id" {}
variable "client_secret" {
  type = string
  sensitive = true
}

variable "service_principal_object_id" {
  
}