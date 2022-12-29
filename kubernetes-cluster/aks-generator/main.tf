resource "azurerm_kubernetes_cluster" "cluster" {
    name = "${var.name}-${var.environment}"
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "${replace(var.environment, "-", "")}"
    http_application_routing_enabled = false
    node_resource_group = "${var.name}-nodes"

    network_profile {
      network_plugin = "azure"
      service_cidr = var.service_cidr
      dns_service_ip = var.dns_service_ip
      docker_bridge_cidr = var.docker_bridge_cidr
    }

    default_node_pool {
      name = "npdefault"
      vm_size = var.default_node_pool.vm_size
      enable_auto_scaling = true
      min_count = var.default_node_pool.min_nodes
      max_count = var.default_node_pool.max_nodes
      node_count = var.default_node_pool.initial_node_count
      vnet_subnet_id = var.default_node_pool.vnet_subnet_id
    }

    azure_policy_enabled = true
    identity {
      type = "SystemAssigned"
    }

    tags = var.required_tags
}
resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
    depends_on = [
      azurerm_kubernetes_cluster.cluster
    ]
    kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
    count = length(var.additional_node_pool)
    name = replace("${var.name}${count.index + 1}", "-", "")
    node_count = var.additional_node_pool[count.index].initial_node_count
    min_count = var.additional_node_pool[count.index].min_nodes
    max_count = var.additional_node_pool[count.index].max_nodes
    vm_size = var.additional_node_pool[count.index].vm_size
    vnet_subnet_id = var.default_node_pool.vnet_subnet_id
    enable_auto_scaling = true
    tags = {
        cluster = "${var.name}-${var.environment}"
    }
}
output "cluster_data" {
  value = azurerm_kubernetes_cluster.cluster
}