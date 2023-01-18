resource "azurerm_public_ip" "public_ip" {
    
    name = "${var.name}PubIp"
    location = var.location
    resource_group_name = var.resource_group_name
    allocation_method = "Dynamic"
}
resource "azurerm_network_interface" "vm_nic" {
    depends_on = [
      azurerm_public_ip.public_ip
    ]
    name = "${var.name}-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "${var.name}-internal"
        subnet_id = var.network.subnet_id
        private_ip_address_allocation = var.network.private_ip_address != null ? "Static" : "Dynamic"
        private_ip_address = var.network.private_ip_address != null ? var.network.private_ip_address : null
        public_ip_address_id = var.network.public_ip ? azurerm_public_ip.public_ip.id : null
    }
  
}

output "vm_public_ip" {
  depends_on = [
    azurerm_public_ip.public_ip,
    azurerm_network_interface.vm_nic
  ]
  value = azurerm_public_ip.public_ip.ip_address
}
output "nic" {
  depends_on = [
    azurerm_public_ip.public_ip,
    azurerm_network_interface.vm_nic
  ]
  value = azurerm_network_interface.vm_nic
}