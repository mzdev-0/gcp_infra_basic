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
