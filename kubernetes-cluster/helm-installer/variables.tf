variable "cluster" {
  type = object({
    host = string
    client_certificate = string
    client_key = string
    cluster_ca_certificate = string
  })
}

variable "helm" {
  type = list(object({
    values_file = string
    name = string
    repository = string
    chart = string
    create_namespace = bool
  }))
}