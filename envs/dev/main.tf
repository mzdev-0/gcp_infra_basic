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
        range_name    = var.k8s_pod_range_name
        ip_cidr_range = var.k8s_pod_range
      },
      {
        range_name    = var.k8s_svc_range_name
        ip_cidr_range = var.k8s_svc_range
      }
    ]
  }
}

module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google"
  version                  = "~> 29.0"
  project_id               = var.project_id
  name                     = var.cluster_name
  network                  = var.network_name
  subnetwork               = var.subnet_name
  ip_range_pods            = var.k8s_pod_range_name
  ip_range_services        = var.k8s_svc_range_name
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
