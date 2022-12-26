resource "azurerm_virtual_network" "vnet" {
    name = "${var.name}-${var.env}-vnet"
    resource_group_name = var.resource_group_name
    location = var.location

    address_space = [
        var.addr_linux,
        var.addr_windows,
        var.addr_k8s
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
    subnet {
        name = "${var.name}-${var.env}-k8s-subnet"
        address_prefix = var.addr_k8s
        security_group = var.k8s_nsg_id
    }

    tags = {
        environment = var.env
        product = var.name
        provisioner = "terraform"
    }
}

output "vnet" {
    value = azurerm_virtual_network.vnet
}