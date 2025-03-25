resource "kubernetes_namespace" "traefik" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "traefik" {
  depends_on = [
    kubernetes_namespace.traefik
  ]
  name       = "traefik"
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  namespace  = "traefik"
  version    = var.chart_version

  # Use the values.yaml file, and allow for overrides.
  values = [
    yamlencode(merge(
      yamldecode(file("${path.module}/values.yaml")),
      var.traefik_values
    ))
  ]

  set {
    name  = "ingressClass.enabled"
    value = "true"
  }
  set {
    name  = "ingressClass.isDefaultClass"
    value = "true"
  }
}

module "traefik" {
  source        = "./traefik"
  chart_version = "34.4.1" # ALWAYS specify a version
  traefik_values = {       #Any additional helm value overrides can go here, or be specified in the values.yaml
    #  key = "value"
  }
}
