variable "namespace" {
  type    = string
  default = "traefik"
}

variable "chart_version" {
  type    = string
  default = "34.4.1" # Use a SPECIFIC version!
}

variable "traefik_values" {
  type        = any
  default     = {}
  description = "Custom values to override in the Traefik Helm chart"
}
