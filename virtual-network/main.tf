module "nsg_dev" {
    source = "./nsg-generator-std"
    name = var.name
    env = "dev"
    linux_vm_addr = var.subnets.dev.linux_vm.addr
    windows_vm_addr = var.subnets.dev.windows_vm.addr
    k8s_addr = var.subnets.dev.k8s.addr
    shared_addr = var.subnets.shr.linux_vm.addr
    resource_group_name = var.resource_group_name
    location = var.location
}
module "nsg_prd" {
    source = "./nsg-generator-std"
    name = var.name
    env = "prd"
    linux_vm_addr = var.subnets.prd.linux_vm.addr
    windows_vm_addr = var.subnets.prd.windows_vm.addr
    k8s_addr = var.subnets.prd.k8s.addr
    shared_addr = var.subnets.shr.linux_vm.addr
    resource_group_name = var.resource_group_name
    location = var.location
}
module "nsg_shared" {
    source = "./nsg-generator-shr"
    name = var.name
    location = var.location
    env = "shr"
    resource_group_name = var.resource_group_name
    dev_addr = [var.subnets.dev.linux_vm.addr, var.subnets.dev.windows_vm.addr, var.subnets.dev.k8s.addr]
    shared_addr = [var.subnets.shr.linux_vm.addr, var.subnets.shr.windows_vm.addr]
    prd_addr = [var.subnets.prd.linux_vm.addr, var.subnets.prd.windows_vm.addr, var.subnets.prd.k8s.addr]
}
module "vnet_dev" {
    depends_on = [
      module.nsg_dev
    ]
    source = "./vnet-generator-std"
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location
    env = "dev"
 
    addr_linux = var.subnets.dev.linux_vm.addr
    addr_windows = var.subnets.dev.windows_vm.addr
    addr_k8s = var.subnets.dev.k8s.addr

    linux_nsg_id = module.nsg_dev.linux_nsg.id
    windows_nsg_id = module.nsg_dev.windows_nsg.id
    k8s_nsg_id = module.nsg_dev.k8s_nsg.id
}
module "vnet_prd" {
    depends_on = [
      module.nsg_prd
    ]
    source = "./vnet-generator-std"
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location
    env = "prd"
 
    addr_linux = var.subnets.prd.linux_vm.addr
    addr_windows = var.subnets.prd.windows_vm.addr
    addr_k8s = var.subnets.prd.k8s.addr

    linux_nsg_id = module.nsg_prd.linux_nsg.id
    windows_nsg_id = module.nsg_prd.windows_nsg.id
    k8s_nsg_id = module.nsg_prd.k8s_nsg.id
}
module "vnet_shr" {
    depends_on = [
      module.nsg_shared
    ]
    source = "./vnet-generator-shr"
    
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location
    env = "shr"
 
    addr_linux = var.subnets.shr.linux_vm.addr
    addr_windows = var.subnets.shr.windows_vm.addr

    linux_nsg_id = module.nsg_shared.shared_nsg.id
    windows_nsg_id = module.nsg_shared.shared_nsg.id
}