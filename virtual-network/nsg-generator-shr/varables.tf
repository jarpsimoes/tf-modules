variable "name" {
    type = string
}
variable "dev_addr" {
    type = list(string)
}
variable "prd_addr" {
    type = list(string)
}
variable "shared_addr" {
    type = list(string)
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