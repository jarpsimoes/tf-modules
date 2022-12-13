resource "azurerm_resource_group" "rg" {
    name = "${var.name}-rg"
    location = var.location

    tags = var.default_tags
}
resource "azurerm_storage_account" "sa_landing" {
    depends_on = [
      azurerm_resource_group.rg
    ]

    name = replace("${var.name}sa", "-", "")
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    account_tier = var.service_account_level.tier
    account_replication_type = var.service_account_level.replication_type

    tags = var.default_tags
}
resource "azurerm_storage_container" "state_container" {
    depends_on = [
      azurerm_storage_account.sa_landing
    ]
    name = "${var.name}-state-container"
    storage_account_name = azurerm_storage_account.sa_landing.name
    container_access_type = "private"
}
output "landing-zone-data" {
    value = {
        container_state_name = azurerm_storage_container.state_container.name
        resource_group_name = azurerm_resource_group.rg.name
        resource_group_id = azurerm_resource_group.rg.id
        resources_base_location = azurerm_resource_group.rg.location
    }
}