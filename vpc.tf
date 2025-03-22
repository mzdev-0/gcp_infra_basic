module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = var.project_id
  network_name = "gke-network"

  subnets = [
    {
      subnet_name   = "gke-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    gke-subnet = [
      {
        range_name    = "k8s-pod-range"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "k8s-service-range"
        ip_cidr_range = "192.168.64.0/18"
      }
    ]
  }
}
