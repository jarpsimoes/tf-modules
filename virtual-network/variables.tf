variable "name" {
    type = string
}
variable "resource_group_name" {
    type = string
}
variable "location" {
    type = string
}
variable "subnets" {
    type = object({
        dev = object({
            linux_vm = object({
                addr = string
            })
            windows_vm = object({
                addr = string
            })
            k8s = object({
                addr = string
            })
        })
        prd = object({
            linux_vm = object({
                addr = string
            })
            windows_vm = object({
                addr = string
            })
            k8s = object({
                addr = string
            })
        })
        shr = object({
            linux_vm = object({
                addr = string
            })
            windows_vm = object({
                addr = string
            })
        })
    })
}