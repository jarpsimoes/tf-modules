resource "azurerm_virtual_network" "vnet" {
    name = "${var.name}-${var.env}-vnet"
    resource_group_name = var.resource_group_name
    location = var.location

    address_space = [
        var.addr_linux,
        var.addr_windows,
        var.addr_k8s,
        var.addr_container_apps
    ]

    tags = {
        environment = var.env
        product = var.name
        provisioner = "terraform"
    }
}
resource "azurerm_subnet" "subnet_linux" {
    name = "${var.name}-${var.env}-linux-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ var.addr_linux ]
}
resource "azurerm_subnet_network_security_group_association" "subnet_linux_nsg" {
    subnet_id = azurerm_subnet.subnet_linux.id
    network_security_group_id = var.linux_nsg_id
}
resource "azurerm_subnet" "subnet_windows" {
    name = "${var.name}-${var.env}-windows-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ var.addr_windows ]
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}
resource "azurerm_subnet_network_security_group_association" "subnet_windows_nsg" {
    subnet_id = azurerm_subnet.subnet_windows.id
    network_security_group_id = var.windows_nsg_id
}
resource "azurerm_subnet" "subnet_k8s" {
    name = "${var.name}-${var.env}-k8s-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ var.addr_k8s ]
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}
resource "azurerm_subnet_network_security_group_association" "subnet_k8s_nsg" {
    subnet_id = azurerm_subnet.subnet_k8s.id
    network_security_group_id = var.k8s_nsg_id
}
resource "azurerm_subnet" "subnet_container_apps" {
    name = "${var.name}-${var.env}-container-apps-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ var.addr_container_apps ]
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}
resource "azurerm_subnet_network_security_group_association" "subnet_container_apps_nsg" {
    subnet_id = azurerm_subnet.subnet_container_apps.id
    network_security_group_id = var.container_apps_nsg_id
}
output "vnet" {
    value = azurerm_virtual_network.vnet
}