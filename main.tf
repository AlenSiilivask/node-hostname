provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.zone
  initial_node_count = 1

  node_config {
    machine_type = var.machine_type
  }

  deletion_protection = false
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name = var.app_name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_label
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_label
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app_service" {
  metadata {
    name = var.service_name
  }

  spec {
    selector = {
      app = var.app_label
    }
    port {
      port        = 80
      target_port = 3000
      protocol    = "TCP"
    }
    type = "LoadBalancer"
  }
}

data "google_client_config" "default" {}
