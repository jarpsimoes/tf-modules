# Kubernetes Cluster (AKS) Laboratory

This module will create the following resources:

- AKS - Azure Kubernetes as Service

Tutorial:

### Required Fields

- **name**: Kubernetes Cluster name
- **resource_group_name**: Resource group to host resources
- **environment**: Environment name
- **service_cidr**: CIDR to the kubernetes service
- **location**: Location to host resources
- **dns_sercice_ip**: Code DNS ip
- **default_node_pool**:
    - **initial_node_count**: Number of start nodes
    - **max_nodes**: Number of max nodes
    - **min_nodes**: Number of min nodes
    - **vm_size**: Virtual machine size
    - **vnet_subnet_id**: Subnet id to be host default node pool
- **additional_node_pool**:
    - **name**: Name of node pool
    - **initial_node_count**: Number of start nodes
    - **max_nodes**: Number of max nodes
    - **min_nodes**: Number of min nodes
    - **vm_size**: Virtual machine size
    - **vnet_subnet_id**: Subnet id to be host default node pool
- **required_tags**: Tags of cluster
- **helm**: List of helm charts to be installed on cluster

### Example

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.35.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

data "azurerm_subnet" "subnet" {
    name = "operator-net-dev-k8s-subnet"
    virtual_network_name = "operator-net-dev-vnet"
    resource_group_name = "operator-lab-rg"
}
module "aks" {
    
    source = "github.com/jarpsimoes/tf-modules/kubernetes-cluster"

    name = "test-aks"
    location = "West Europe"
    resource_group_name = "operator-lab-rg"
    environment = "test"
    service_cidr = "10.2.0.0/16"
    dns_service_ip = "10.2.0.10"
    
    default_node_pool = {
      initial_node_count = 1
      max_nodes = 1
      min_nodes = 1
      vm_size = "Standard_B2s"
      vnet_subnet_id = data.azurerm_subnet.subnet.id
    }

    additional_node_pool = [{
      name = "tnpool"
      initial_node_count = 1
      max_nodes = 1
      min_nodes = 1
      vm_size = "Standard_B2s"
      vnet_subnet_id = data.azurerm_subnet.subnet.id
    }]

    required_tags = {
      "name": "test"
    }

    helm = [ {
      chart = "ingress-nginx"
      create_namespace = true
      name = "nginx-ingress"
      repository = "https://kubernetes.github.io/ingress-nginx"
      values_file = ""
    } ]
}
```