variable "name" {
    type = string
}
variable "location" {
    type = string
}
variable "resource_group_name" {
    type = string
}
variable "environment" {
    type = string

    validation {
      condition = anytrue([
        var.environment == "dev",
        var.environment == "shr",
        var.environment == "prd"
      ])
      error_message = "Only can be dev, shr or prd"
    }
}

variable "vm_size" {
    type = string
}
variable "network" {
    type = object({
        subnet_id = string
        private_ip_address = string
        internal_address_allocation = string
        public_ip = bool
    })
}
variable "image" {
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
    })
}
variable "authentication" {
    type = object({
        admin_username = string
        pub_key_path = string
    })
}
variable "vm_disk" {
    type = string
    default = "Standard_LRS"
}