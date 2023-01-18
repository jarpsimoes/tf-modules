variable "name" {
    type = string
}
variable "location" {
    type = string
}
variable "resource_group_name" {
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