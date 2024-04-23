data "azuread_client_config" "current" {}

resource "azuread_application" "spn" {
  display_name = var.service_principal_name
  owners = [ data.azuread_client_config.current.object_id ]
}

resource "azuread_service_principal" "spn" {
  client_id = azuread_application.spn.client_id
}

resource "azuread_application_password" "spn" {
  application_id = azuread_application.spn.id
}

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "spn" {
}

resource "azurerm_role_assignment" "spn" {
  for_each             = toset(local.multi_roles)
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = each.value
  principal_id         = azuread_service_principal.spn.object_id
}
