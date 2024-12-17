# composerを実行しているサービスアカウントの設定

resource "google_service_account" "composer_env_account" {
  account_id   = var.COMPOSER_ENVIRONMENT_NAME
  display_name = "Service Account for Composer Environment ${var.COMPOSER_ENVIRONMENT_NAME}"
}

locals {
  roles = [
    "roles/composer.worker",
    "roles/bigquery.admin",
    "roles/secretmanager.secretAccessor",
    "roles/composer.ServiceAgentV2Ext",
    "roles/secretmanager.secretAccessor",
    "roles/storage.objectViewer"
  ]
}

resource "google_project_iam_member" "composer_env_account_roles" {
  for_each = toset(local.roles)
  project  = var.PROJECT_ID
  member   = "serviceAccount:${google_service_account.composer_env_account.email}"
  role     = each.value
}
