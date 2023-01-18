resource "azurerm_network_security_group" "vnet_nsg_linux" {
    location = var.location
    resource_group_name = var.resource_group_name
    name = "${var.name}-${var.env}-nsg-vm-linux"

    security_rule = [ 
        # Inbound
        {
            access = "Allow"
            description = "Allow ssh connections from anywhere"
            destination_address_prefix = null
            destination_address_prefixes = [ var.linux_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "22" ]
            direction = "Inbound"
            name = "i-ssh-port-rule-${var.env}-linux"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow subnet connections from subnet and shared"
            destination_address_prefix = null
            destination_address_prefixes = [ var.linux_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnet-network-trafic-${var.env}-linux"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ 
                    var.linux_vm_addr,
                    var.shared_addr
                ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow subnets connections on ports 22, 80, 443, 3306 and 5432"
            destination_address_prefix = null
            destination_address_prefixes = [ var.linux_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = ["80", "443", "3306", "5432"]
            direction = "Inbound"
            name = "i-subnets-network-trafic-${var.env}-linux"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ 
                    var.windows_vm_addr,
                    var.k8s_addr,
                    var.shared_addr 
                ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        },
        {
            access = "Deny"
            description = "Deny connections"
            destination_address_prefix = null
            destination_address_prefixes = [ var.linux_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-deny-trafic-${var.env}-linux"
            priority = 200
            protocol = "*"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },

        # Outbound
        
        {
            access = "Allow"
            description = "Allow external https connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "443", "5000" ]
            direction = "Outbound"
            name = "o-allow-external-https-connections-${var.env}-linux"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = null
            source_address_prefixes = [ var.linux_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow internal connections"
            destination_address_prefix = null
            destination_address_prefixes = [ 
                var.windows_vm_addr,
                var.k8s_addr,
                var.shared_addr
             ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-allow-internal-connections-${var.env}-linux"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.linux_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Deny"
            description = "Deny other connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-deny-connections-${var.env}-linux"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.linux_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        }
        
    ]
}
resource "azurerm_network_security_group" "vnet_nsg_windows" {
    location = var.location
    resource_group_name = var.resource_group_name
    name = "${var.name}-${var.env}-nsg-vm-windows"

    # Inbound
    security_rule = [
        {
            access = "Allow"
            description = "Allow RDP connections from anywhere"
            destination_address_prefix = null
            destination_address_prefixes = [ var.windows_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "3389" ]
            direction = "Inbound"
            name = "i-rdp-port-rule-${var.env}-windows"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow subnet connections from subnet and shared"
            destination_address_prefix = null
            destination_address_prefixes = [ var.windows_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnet-network-trafic-${var.env}-windows"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ 
                    var.windows_vm_addr,
                    var.shared_addr
                ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow subnets connections on ports 3389, 80, 443, 3306 and 5432"
            destination_address_prefix = null
            destination_address_prefixes = [ var.windows_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = ["3389", "80", "443", "3306", "5432"]
            direction = "Inbound"
            name = "i-subnets-network-trafic-${var.env}-windows"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ 
                    var.linux_vm_addr,
                    var.k8s_addr,
                    var.shared_addr 
                ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        },
        {
            access = "Deny"
            description = "Deny connections"
            destination_address_prefix = null
            destination_address_prefixes = [ var.windows_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-deny-trafic-${var.env}-windows"
            priority = 200
            protocol = "*"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },

        # Outbound
        
        {
            access = "Allow"
            description = "Allow external https connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "443", "5000" ]
            direction = "Outbound"
            name = "o-allow-external-https-connections-${var.env}-windows"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow internal connections"
            destination_address_prefix = null
            destination_address_prefixes = [ 
                var.linux_vm_addr,
                var.k8s_addr,
                var.shared_addr
             ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-allow-internal-connections-${var.env}-windows"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Deny"
            description = "Deny other connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-deny-connections-${var.env}-linux"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        }
        
    ]
}
resource "azurerm_network_security_group" "vnet_nsg_k8s" {
    location = var.location
    resource_group_name = var.resource_group_name
    name = "${var.name}-${var.env}-nsg-vm-k8s"

    # Inbound
    security_rule = [
        {
            access = "Allow"
            description = "Allow external access https"
            destination_address_prefix = null
            destination_address_prefixes = [ var.k8s_addr ]
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "443" ]
            direction = "Inbound"
            name = "i-https-trafic-${var.env}-k8s"
            priority = 110
            protocol = "*"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow subnet connections from subnets windows, linux and shared"
            destination_address_prefix = null
            destination_address_prefixes = [ var.k8s_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnet-network-trafic-${var.env}-k8s"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ 
                    var.windows_vm_addr,
                    var.linux_vm_addr,
                    var.shared_addr
                ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Deny"
            description = "Deny connections"
            destination_address_prefix = null
            destination_address_prefixes = [ var.windows_vm_addr ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnets-network-trafic-${var.env}-k8s"
            priority = 200
            protocol = "*"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },

        # Outbound
        
        {
            access = "Allow"
            description = "Allow external https connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "443", "5000", "80" ]
            direction = "Outbound"
            name = "o-allow-external-https-connections-${var.env}-k8s"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow internal connections"
            destination_address_prefix = null
            destination_address_prefixes = [ 
                var.linux_vm_addr,
                var.windows_vm_addr,
                var.shared_addr
             ]
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-allow-internal-connections-${var.env}-k8s"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Deny"
            description = "Deny other connections"
            destination_address_prefix = "*"
            destination_address_prefixes = null
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-deny-connections-${var.env}-k8s"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = [ var.windows_vm_addr ]
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        }
        
    ]
}

output "linux_nsg" {
    value = azurerm_network_security_group.vnet_nsg_linux
}
output "windows_nsg" {
    value = azurerm_network_security_group.vnet_nsg_windows
}
output "k8s_nsg" {
    value = azurerm_network_security_group.vnet_nsg_k8s
}