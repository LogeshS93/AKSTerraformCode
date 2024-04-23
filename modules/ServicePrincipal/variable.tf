variable "service_principal_name" {
  type = string
  description = "name of the service principal"
}

locals {
  multi_roles=["Contributor","Key Vault Administrator"]
}
