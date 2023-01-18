resource "azurerm_network_interface" "vm_nic" {
    name = "${var.name}-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "${var.name}-internal"
        subnet_id = var.network.subnet_id
        private_ip_address_allocation = var.network.private_ip_address != null ? "Static" : "Dynamic"
        private_ip_address = var.network.private_ip_address != null ? var.network.private_ip_address : null
    }
  
}
output "nic" {
  value = azurerm_network_interface.vm_nic
}