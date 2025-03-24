variable "project_id" {
  type        = string
  description = "The ID of the project."
}

variable "is_regional" {
  type        = bool
  description = "Regional or Zonal Cluster"
  default     = false
}

variable "zone" {
  type        = string
  description = "The zone to provision GKE in."
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

variable "region" {
  type        = string
  description = "The Region"
  default     = "us-central1"
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

variable "network_name" {
  type        = string
  description = "The name of the network"
  default     = "default-network"
}
variable "subnet_name" {
  type        = string
  description = "The subnet name."
  default     = "default-subnet"
}
variable "subnet_ip" {
  type        = string
  description = "The subnet range of the subnet."
  default     = "10.10.10.0/24"
}

variable "k8s_pod_range" {
  type        = string
  description = "The IP range of the cluster pods"
  default     = "192.168.0.0/18"
}

variable "k8s_svc_range" {
  type        = string
  description = "the IP range of the cluster services"
  default     = "192.168.64.0/18"
}
variable "k8s_pod_range_name" {
  type        = string
  description = "The name of the IP range for the cluster pods"
  default     = "k8s-pod-range"
}

variable "k8s_svc_range_name" {
  type        = string
  description = "The name of the IP range for the cluster services"
  default     = "k8s-svc-range"
}

