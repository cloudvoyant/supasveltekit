data "google_project" "project" {}

resource "google_cloud_run_v2_service" "default" {
  name     = "custom-domain" # Replace with your service name
  location = "us-central1"

  deletion_protection = false # set to true to prevent destruction of the resource

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello" # Replace with your container image
    }
  }
}

resource "google_cloud_run_domain_mapping" "default" {
  name     = "verified-domain.com"
  location = google_cloud_run_v2_service.default.location
  metadata {
    namespace = data.google_project.project.project_id
  }
  spec {
    route_name = google_cloud_run_v2_service.default.name
  }
}