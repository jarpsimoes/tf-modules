

module "vm_with_public_ip" {
    count = var.network.public_ip == true ? 1 : 0
    source = "./vm-generator"

    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    vm_size = var.vm_size
    environment = var.environment
    network = var.network
    image = var.image
    authentication = var.authentication
}

module "vm_without_public_ip" {
    count = var.network.public_ip == true ? 0 : 1
    source = "./vm-generator-wo-pub-ip"

    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    vm_size = var.vm_size
    environment = var.environment
    network = var.network
    image = var.image
    authentication = var.authentication
}

resource "azurerm_virtual_machine" "vm_machine" {
    depends_on = [
      module.vm_with_public_ip,
      module.vm_without_public_ip
    ]
    name = "${var.name}-vm"
    location = var.location
    resource_group_name = var.resource_group_name
    network_interface_ids = var.network.public_ip ? [ module.vm_with_public_ip[0].nic.id ] : [ module.vm_without_public_ip[0].nic.id ]
    vm_size = "${var.vm_size}"

    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = var.image.publisher
        offer = var.image.offer
        sku = var.image.sku
        version = var.image.version
    }

    os_profile {
        computer_name = "${var.name}"
        admin_username = var.authentication.admin_username
    }

    storage_os_disk {
        name              = "${var.name}-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "${var.vm_disk}"
    }
    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
                path = "/home/${var.authentication.admin_username}/.ssh/authorized_keys"
                key_data = file(var.authentication.pub_key_path)
        }
    }

    tags = {
      "vm-type" = "linux",
      "scope" = var.environment,
      "external" = "${var.network.public_ip}"
    }
}

output "public_ip" {
  value =  var.network.public_ip == true ? module.vm_with_public_ip[0].vm_public_ip : ""
}