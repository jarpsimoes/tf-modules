variable "name" {
    type = string
}
variable "resource_group_name" {
    type = string
}
variable "location" {
    type = string
}
variable "env" {
    type = string
}
variable "addr_linux" {
    type = string
}
variable "linux_nsg_id" {
    type = string
}
variable "addr_windows" {
    type = string
}
variable "windows_nsg_id" {
    type = string
}
variable "addr_k8s" {
    type = string
}
variable "k8s_nsg_id" {
    type = string
}