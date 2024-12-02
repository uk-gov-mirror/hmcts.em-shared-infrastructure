provider "azurerm" {
  features {}
}

locals {
  tags = merge(
    var.common_tags,
    tomap({
      "Team Contact"        = var.team_contact
      "Destroy Me"          = var.destroy_me
      "application"         = "evidence-management"
      "managedBy"           = "Evidence Management"
      "businessArea"        = "CFT"
      "contactSlackChannel" = var.team_contact
    })
  )
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}"
  location = var.location
  tags     = local.tags
}

resource "azurerm_key_vault_secret" "slack_monitoring_address" {   
  name         = "slack_monitoring_address"   
  value        = var.email_address   
  key_vault_id = data.azurerm_key_vault.rd_key_vault.id 
}