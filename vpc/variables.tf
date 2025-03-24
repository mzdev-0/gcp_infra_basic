variable "project_id" {
  type        = string
  description = "The ID of the project."
}

variable "region" {
  type        = string
  description = "The Region"
  default     = "us-central1"
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

