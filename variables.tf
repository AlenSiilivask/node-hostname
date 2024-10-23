variable "project_id" {
  type        = string
  default     = "quickstart-1606751952587"
}

variable "region" {
  type        = string
  default     = "europe-north1"
}

variable "zone" {
  type        = string
  default     = "europe-north1-a"
}

variable "cluster_name" {
  type        = string
  default     = "node-hostname-cluster"
}

variable "machine_type" {
  description = "The machine type for the cluster nodes"
  type        = string
  default     = "e2-micro"
}

variable "app_name" {
  description = "The name of the Kubernetes deployment"
  type        = string
  default     = "node-hostname-app"
}

variable "app_label" {
  description = "The label for the app"
  type        = string
  default     = "node-hostname-app"
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "node-hostname-container"
}

variable "container_image" {
  description = "The Docker image for the container"
  type        = string
  default     = "thealestguy/node-hostname:latest"
}

variable "service_name" {
  description = "The name of the Kubernetes service"
  type        = string
  default     = "node-hostname-service"
}
