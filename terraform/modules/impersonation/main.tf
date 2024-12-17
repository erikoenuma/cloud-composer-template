locals {
  terraform_service_account = "terraform-composer@${var.PROJECT_ID}.iam.gserviceaccount.com"
}

provider "google" {
  project                     = var.PROJECT_ID
  impersonate_service_account = local.terraform_service_account
  scopes                      = ["https://www.googleapis.com/auth/cloud-platform"]
}

output "terraform_service_account" {
  value = local.terraform_service_account
}
