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
    address_prefix = var.addr_linux
    security_group = var.linux_nsg_id
}

resource "azurerm_subnet" "subnet_windows" {
    name = "${var.name}-${var.env}-windows-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix = var.addr_windows
    security_group = var.windows_nsg_id
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}

resource "azurerm_subnet" "subnet_k8s" {
    name = "${var.name}-${var.env}-k8s-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix = var.addr_k8s
    security_group = var.k8s_nsg_id
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}

resource "azurerm_subnet" "subnet_container_apps" {
    name = "${var.name}-${var.env}-container-apps-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix = var.addr_container_apps
    security_group = var.container_apps_nsg_id
    service_endpoints = [ "Microsoft.Sql", "Microsoft.Web", "Microsoft.ContainerRegistry" ]
}
 
output "vnet" {
    value = azurerm_virtual_network.vnet
}