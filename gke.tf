module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 29.0"

  #Required
  project_id        = var.project_id
  name              = var.cluster_name
  network           = module.vpc.network_name
  subnetwork        = module.vpc.subnets_names[0]
  ip_range_pods     = "k8s-pod-range"
  ip_range_services = "k8s-service-range"

  #Optional
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
      preemptible  = false
      disk_size_gb = var.disk_size_gb
      disk_type    = "pd-standard"
      image_type   = "COS_CONTAINERD"

    }
  ]
}
