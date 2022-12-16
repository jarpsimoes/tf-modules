resource "azurerm_virtual_network" "vnet_linux" {
    name = "${var.name}-${var.env}-vnet"
    resource_group_name = var.resource_group_name
    location = var.location

    address_space = [
        var.addr_linux,
        var.addr_windows
    ]

    subnet {
        name = "${var.name}-${var.env}-linux-subnet"
        address_prefix = var.addr_linux
        security_group = var.linux_nsg_id
    }
    subnet {
        name = "${var.name}-${var.env}-windows-subnet"
        address_prefix = var.addr_windows
        security_group = var.windows_nsg_id
    }

    tags = {
        environment = var.env
        product = var.name
        provisioner = "terraform"
    }
}