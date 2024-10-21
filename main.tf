provider "google" {
  project = var.project_id
  region  = "europe-north1"
}

resource "google_container_cluster" "primary" {
  name               = "node-hostname-cluster"
  location           = "europe-north1-a"
  initial_node_count = 1

  node_config {
    machine_type = "e2-micro"
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
    name = "node-hostname-app"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "node-hostname-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "node-hostname-app"
        }
      }
      spec {
        container {
          name  = "node-hostname-container"
          image = "thealestguy/node-hostname:0.0.1"
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
    name = "node-hostname-service"
  }

  spec {
    selector = {
      app = "node-hostname-app"
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
