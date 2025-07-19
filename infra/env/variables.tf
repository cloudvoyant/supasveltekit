# Required ---------------------------------------------------------------------

variable "org_id" {
    type = string
    description = "GCP org id."
}   

variable "project" {
    type = string
    description = "Project name."
}

variable "environment" {
    type = string
    description = "Infra environment."
    validation {
        condition = contains(["dev", "prod"], var.environment)
        error_message = "Environment must be either 'dev' or 'prod'."
    }
}