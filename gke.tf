module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 29.0"

  project_id          = var.project_id
  name                = var.cluster_name
  region              = var.region
  zones               = [var.zone]
  deletion_protection = false
  # network and subnetwork must preexist before you call the kubernetes-engine module
  network    = module.vpc.network_name
  subnetwork = module.vpc.subnets_names[0]

  ip_range_pods            = "k8s-pod-range"
  ip_range_services        = "k8s-service-range"
  remove_default_node_pool = true
  initial_node_count       = 1

  node_pools = [
    {
      name         = var.node_pool_name
      machine_type = var.machine_type
      min_count    = var.min_nodes
      max_count    = var.max_nodes
      preemptible  = false
      disk_size_gb = var.disk_size_gb
      disk_type    = "pd-standard"
      image_type   = "COS_CONTAINERD"

    }
  ]
}
