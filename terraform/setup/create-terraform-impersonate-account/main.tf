terraform {
  backend "gcs" {
    bucket = "tfstate-create-terraform-impersonate-account-prod"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.PROJECT_ID
  region  = "asia-northeast1"
}

resource "google_service_account" "terraform_composer" {
  project      = var.PROJECT_ID
  account_id   = "terraform-composer"
  display_name = "cloud composer構築terraformを実行するアカウント"
}

locals {
  roles = [
    "roles/composer.admin",
    "roles/cloudsql.admin",
    "roles/compute.networkAdmin",
    "roles/pubsub.admin",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountAdmin",
    "roles/storage.admin",
    "roles/iam.securityReviewer",
    "roles/iam.securityAdmin",
    "roles/secretmanager.admin",
    "roles/cloudbuild.connectionAdmin",
    "roles/cloudbuild.builds.editor",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/cloudscheduler.admin",
    "roles/cloudfunctions.invoker"
  ]
}

resource "google_project_iam_member" "terraform_composer_roles" {
  for_each = toset(local.roles)
  project  = var.PROJECT_ID
  member   = "serviceAccount:${google_service_account.terraform_composer.email}"
  role     = each.value
}
