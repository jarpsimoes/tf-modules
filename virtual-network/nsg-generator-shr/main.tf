resource "azurerm_network_security_group" "vnet_nsg_shared" {
    location = var.location
    resource_group_name = var.resource_group_name
    name = "${var.name}-nsg-shared"

    # Inbound
    security_rule = [
        {
            access = "Allow"
            description = "Allow RDP and SSH connections from anywhere"
            destination_address_prefix = null
            destination_address_prefixes = var.shared_addr
            destination_application_security_group_ids = null
            destination_port_range = null
            destination_port_ranges = [ "3389", "22" ]
            direction = "Inbound"
            name = "i-rdp-ssh-port-rule-${var.env}"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = "*"
            source_address_prefixes = null
            source_application_security_group_ids = null
            source_port_range = null
            source_port_ranges = [ "3389", "22" ]
        },
        {
            access = "Allow"
            description = "Allow all networks connections"
            destination_address_prefix = null
            destination_address_prefixes = var.shared_addr
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnet-network-trafic-${var.env}"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = setunion( 
                    var.dev_addr,
                    var.prd_addr,
                    var.shared_addr
            )
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Deny"
            description = "Deny connections"
            destination_address_prefix = null
            destination_address_prefixes = var.shared_addr
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Inbound"
            name = "i-subnets-network-trafic-${var.env}"
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
            name = "o-allow-external-https-connections-${var.env}"
            priority = 100
            protocol = "Tcp"
            source_address_prefix = null
            source_address_prefixes = var.shared_addr
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null
        },
        {
            access = "Allow"
            description = "Allow internal connections"
            destination_address_prefix = null
            destination_address_prefixes = setunion( 
                var.dev_addr,
                var.prd_addr,
                var.shared_addr
            )
            destination_application_security_group_ids = null
            destination_port_range = "*"
            destination_port_ranges = null
            direction = "Outbound"
            name = "o-allow-internal-connections-${var.env}"
            priority = 110
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = var.shared_addr
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
            name = "o-deny-connections-${var.env}"
            priority = 120
            protocol = "*"
            source_address_prefix = null
            source_address_prefixes = var.shared_addr
            source_application_security_group_ids = null
            source_port_range = "*"
            source_port_ranges = null

        }
        
    ]
}

output "shared_nsg" {
    value = azurerm_network_security_group.vnet_nsg_shared
}