module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    gke-subnet = [
      {
        range_name    = var.k8s-pod-range-name
        ip_cidr_range = var.k8s-pod-range
      },
      {
        range_name    = var.k8s-svc-range-name
        ip_cidr_range = var.k8s-svc-range
      }
    ]
  }
}

module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google"
  version                  = "~> 29.0"
  project_id               = var.project_id
  name                     = var.cluster_name
  network                  = module.vpc.network_name
  subnetwork               = var.subnet_name
  ip_range_pods            = var.k8s-pod-range-name
  ip_range_services        = var.k8s-svc-range-name
  zones                    = [var.zone]
  regional                 = var.is_regional
  deletion_protection      = false
  remove_default_node_pool = true

  node_pools = [
    {
      name         = var.node_pool_name
      machine_type = var.machine_type
      min_count    = var.min_nodes
      max_count    = var.max_nodes
      disk_size_gb = var.disk_size_gb
      disk_type    = "pd-standard"
      image_type   = "COS_CONTAINERD"
    }
  ]

}

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

  #  # Use the values.yaml file, and allow for overrides.
  #  values = [
  #    yamlencode(merge(
  #      yamldecode(file("${path.module}/values.yaml")),
  #      var.traefik_values
  #    ))
  #  ]

  set {
    name  = "ingressClass.enabled"
    value = "true"
  }
  set {
    name  = "ingressClass.isDefaultClass"
    value = "true"
  }
}

#module "traefik" {
#  source        = "./traefik"
#  chart_version = "34.4.1" # ALWAYS specify a version
#  traefik_values = {       #Any additional helm value overrides can go here, or be specified in the values.yaml
#    #  key = "value"
#  }
#}

resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "certmanager"
  }
}

resource "helm_release" "certmanager" {
  depends_on = [
    kubernetes_namespace.certmanager
  ]
  name      = "certmanager"
  namespace = "certmanager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "time_sleep" "wait_for_certmanager" {
  depends_on = [
    helm_release.certmanager
  ]
  create_duration = "10s"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace.argocd]
  name       = "argocd"
  namespace  = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
}
