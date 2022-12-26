# Virtual Network Laboratory

This module will create the following resources:

- NSG Windows
- NSG Linux
- NSG K8S
- VNET Development
- VNET Production
- VNET Shared

Tutorial:

### Required Fields

- **name**: Network structure name
- **resource_group_name**: Resource group to host resources
- **location**: Location to host resources
- **subnets**: Network configurations:
  _subnets.[ENV].windows_vm_.addr: Address space
  _subnets.[ENV].linux_vm_.addr: Address space
  _subnets.[ENV].k8s_vm_.addr: Address space
  _subnets.shr.linux_vm_.addr: Address space
  _subnets.shr.winodws_vm_.addr: Address space

### Example

```
module "virtual_network" {
  source = "../../tf-modules/virtual-network"

  name = "operator-net"
  resource_group_name = "operator-lab-rg"
  location = "West Europe"

  subnets = {
    dev = {
      k8s = {
        addr = "10.1.0.0/16"
      }
      linux_vm = {
        addr = "10.0.0.0/24"
      }
      windows_vm = {
        addr = "10.0.1.0/24"
      }
    }
    prd = {
      k8s = {
        addr = "10.3.0.0/16"
      }
      linux_vm = {
        addr = "10.2.0.0/24"
      }
      windows_vm = {
        addr = "10.2.1.0/24"
      }
    }
    shr = {
      linux_vm = {
        addr = "10.4.0.0/24"
      }
      windows_vm = {
        addr = "10.4.1.0/24"
      }
    }
  }
}
```