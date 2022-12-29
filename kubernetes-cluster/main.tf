
module "kubernetes_cluster" {
    source = "./aks-generator"

    name = var.name
    environment = var.environment
    location = var.location
    resource_group_name = var.resource_group_name
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip

    default_node_pool = {
      initial_node_count = var.default_node_pool.initial_node_count
      max_nodes = var.default_node_pool.max_nodes
      min_nodes = var.default_node_pool.min_nodes
      vm_size = var.default_node_pool.vm_size
      vnet_subnet_id = var.default_node_pool.vnet_subnet_id
    }

    additional_node_pool = var.additional_node_pool
    required_tags = var.required_tags
}

module "helm_installer" {
    
    source = "./helm-installer"

    cluster = {
      host                   = "${module.kubernetes_cluster.cluster_data.kube_config.0.host}"
      client_certificate     = "${base64decode(module.kubernetes_cluster.cluster_data.kube_config.0.client_certificate)}"
      client_key             = "${base64decode(module.kubernetes_cluster.cluster_data.kube_config.0.client_key)}"
      cluster_ca_certificate = "${base64decode(module.kubernetes_cluster.cluster_data.kube_config.0.cluster_ca_certificate)}"
    }

    helm = var.helm

}