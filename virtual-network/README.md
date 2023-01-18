# Virtual Machine Linux Laboratory

This module will create the following resources:

- Virtual Machine

Tutorial:

### Required Fields

- **name**: Virtual Mahine name
- **resource_group_name**: Resource group to host resources
- **location**: Location to host resources
- **network**: Network configurations:
  _network.subnet_id: Subnet ID
  _network.private_ip_address: Private IP Address when not Dynamic
  _network.internal_address_allocation: Private IP Address allocation method (Dynamic or Static)
  _network.public_ip: Public IP (true or false)

### Example

```
module "vm" {
    source = "github.com/jarpsimoes/tf-modules/tf-modules/virtual-machine-linux"

    name = "test-vm"
    resource_group_name = "operator-lab-rg"
    location = "West Europe"

    environment = "dev"

    vm_size = "Standard_b2s"

    network = {
        internal_address_allocation = "Dynamic"
        private_ip_address = null
        public_ip = true
        subnet_id = data.azurerm_subnet.subnet.id
    }

    image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    authentication = {
        admin_username = "admin_vm"
        pub_key_path = "/Users/username/.ssh/id_rsa.pub"
    }
}
```