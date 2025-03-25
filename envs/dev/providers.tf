terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

data "google_client_config" "provider" {}

data "google_container_cluster" "primary" {
  name     = module.gke.name
  location = var.zone
}

provider "kubernetes" {
  # Configure your Kubernetes provider (connect to your GKE cluster)
  host                   = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.primary.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}
