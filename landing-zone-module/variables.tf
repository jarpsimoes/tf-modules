variable "name" {
  type = string
}
variable "location" {
  type = string

  default = "West Europe"
}
variable "default_tags" {
    type = map

    default = {
        scope = "laboratory"
        user = "jarpsimoes"
        provisioner = "terraform"
    }
}
variable "service_account_level" {
    type = object({
        tier = string
        replication_type = string 
    })
    default = {
      replication_type = "LRS"
      tier = "Standard"
    }
}