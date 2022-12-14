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
}
variable "service_cidr" {
  type = string
}
variable "dns_service_ip" {
  type = string
}
variable "required_tags" {
  type = map(string)
}

variable "default_node_pool" {
  type = object({
    initial_node_count = number
    max_nodes = number
    min_nodes = number
    vm_size = string
    vnet_subnet_id = string
  })
}
variable "additional_node_pool" {
  type = list(object({
    name = string
    initial_node_count = number
    max_nodes = number
    min_nodes = number
    vm_size = string
    vnet_subnet_id = string
  }))
}

variable "helm" {
  type = list(object({
    values_file = string
    name = string
    repository = string
    chart = string
    create_namespace = bool
  }))
}