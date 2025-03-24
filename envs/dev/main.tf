terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 6.0"
    }
  }
}

provider "google" {
    project = var.project_id
}

# Optional: If using a backend like GCS, configure it here.
#  backend "gcs" {
#    bucket  = "your-tfstate-bucket"
#    prefix  = "terraform/state"
#  }
