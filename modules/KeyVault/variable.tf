variable "key_vault_name" {
    type = string
    description = "name of the key vault"
}

variable "rg_name" {
    type = string
    description = "name of the Resource group"
}

variable "rg_location" {
    type = string
    description = "Location of the Resource group"
}

variable "service_principal_name" {
    type = string
}

variable "service_principal_object_id" {}
variable "service_principal_tenant_id" {}