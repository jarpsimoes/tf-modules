provider "helm" {
    kubernetes {
        host = "${var.cluster.host}"
        client_certificate = "${var.cluster.client_certificate}"
        client_key = "${var.cluster.client_key}"
        cluster_ca_certificate = "${var.cluster.cluster_ca_certificate}"
    }
}
resource "helm_release" "helm" {
    count = length(var.helm)

    name = var.helm[count.index].name
    repository = var.helm[count.index].repository
    chart = var.helm[count.index].chart
    create_namespace = var.helm[count.index].create_namespace
    
    values = var.helm[count.index].values_file != "" ? [var.helm[count.index].values_file] : []
}