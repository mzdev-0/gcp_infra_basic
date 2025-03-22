variable "project_id" {
  type        = string
  description = "The ID of the project."
}

variable "region" {
  type        = string
  description = "The region to deploy resources in."
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The zone to deploy GKE in."
  default     = "us-central1-a"
}

variable "billing_account" {
  type        = string
  description = "The ID of the billing account to associate this project with"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "my-cluster"
}

variable "machine_type" {
  type        = string
  description = "The machine type"
  default     = "e2-medium"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the node pool"
  default     = "my-node-pool"
}

variable "min_nodes" {
  type        = number
  description = "the minimum number of nodes"
  default     = 1
}

variable "max_nodes" {
  type        = number
  description = "the minimum number of nodes"
  default     = 2
}

variable "disk_size_gb" {
  type        = number
  description = "the size of the disk in gb"
  default     = 30
}
