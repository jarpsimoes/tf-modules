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
variable "docker_bridge_cidr" {
  type = string
  default = "172.17.0.1/16"
}
variable "default_node_pool" {
  type = object({
    vm_size = string
    vnet_subnet_id = string
    initial_node_count = number
    min_nodes = number
    max_nodes = number
  })
}
variable "required_tags" {
  type = map(string)
}
variable "additional_node_pool" {
  type = list(object({
    name = string
    initial_node_count = number
    min_nodes = number
    max_nodes = number
    vm_size = string
    vnet_subnet_id = string
  }))
}