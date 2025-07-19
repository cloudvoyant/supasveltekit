resource "google_project" "my_project" {
  name       = "${var.project}-${var.environment}"
  project_id = "${var.project}-${var.environment}"
  org_id     = var.org_id
}