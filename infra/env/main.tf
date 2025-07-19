

module "gcp_project" {
    source = "../../modules/gcp_project"
    
    org_id      = var.org_id
    project     = var.project
    environment = "dev"
}