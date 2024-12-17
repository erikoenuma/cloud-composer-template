# Purpose: Connect the GitHub repository to Cloud Build to make use of the CI/CD pipeline
# developブランチ / mainブランチへのPR作成時: terraform-plan.cloudbuild.yaml, test-dags.cloudbuild.yamlを実行
# developブランチ / mainブランチへのpush時: deploy-composer.cloudbuild.yamlを実行 

# Enable Secret Manager API
resource "google_project_service" "secret_manager_api" {
  project = var.PROJECT_ID
  service = "secretmanager.googleapis.com"
}

# Create a secret containing the personal access token and grant permissions to the Service Agent
resource "google_secret_manager_secret" "github_token_secret" {
  project   = var.PROJECT_ID
  secret_id = var.SECRET_ID

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github_token_secret_version" {
  secret      = google_secret_manager_secret.github_token_secret.id
  secret_data = var.GITHUB_PAT
}

data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = [
      "serviceAccount:service-${var.PROJECT_NUMBER}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
    ]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project     = google_secret_manager_secret.github_token_secret.project
  secret_id   = google_secret_manager_secret.github_token_secret.secret_id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}


# Create the GitHub connection
resource "google_cloudbuildv2_connection" "my_connection" {
  project  = var.PROJECT_ID
  location = var.REGION
  name     = var.CONNECTION_NAME

  github_config {
    app_installation_id = var.INSTALLATION_ID
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
    }
  }
  depends_on = [google_secret_manager_secret_iam_policy.policy]
}

# Connect the repository to the connection
resource "google_cloudbuildv2_repository" "my_repository" {
  project           = var.PROJECT_ID
  location          = var.REGION
  name              = var.REPO_NAME
  parent_connection = google_cloudbuildv2_connection.my_connection.name
  remote_uri        = var.GIT_REMOTE_URI
}

# -----------------------------------------------------------
# Create a trigger for cloud composer
# -----------------------------------------------------------

# ブランチへのPR作成時にDAGのテストを実行するトリガー
# see: https://cloud.google.com/composer/docs/composer-2/dag-cicd-github?hl=ja
resource "google_cloudbuild_trigger" "trigger-test-dags" {
  project     = var.PROJECT_ID
  name        = "test-dags"
  description = "Trigger for pull requests to test DAGs"

  github {
    owner = var.GITHUB_OWNER_NAME
    name  = var.REPO_NAME
    pull_request {
      branch = var.ENV == "development" ? "develop" : "main"
    }
  }

  included_files = ["dags/**"]
  filename       = "cloud-build/test-dags.cloudbuild.yaml"
}

# ブランチへのpush時にComposerをデプロイするトリガー
# terraformの変更・dagの追加・requirement.txtの変更があった場合の反映を行う
# https://cloud.google.com/composer/docs/composer-2/dag-cicd-github?hl=ja#builder-trigger-sync
resource "google_cloudbuild_trigger" "trigger-deploy-composer" {
  project     = var.PROJECT_ID
  name        = "deploy-composer-${var.ENV}"
  description = "Trigger for push to deploy Composer ${var.ENV}"

  github {
    owner = var.GITHUB_OWNER_NAME
    name  = var.REPO_NAME
    push {
      branch = var.ENV == "development" ? "develop" : "main"
    }
  }

  included_files = ["dags/**", "requirements.txt", "terraform/**"]
  filename       = "cloud-build/deploy-composer.cloudbuild.yaml"
  substitutions = {
    _ENV = var.ENV
  }
}

# ブランチへのPR作成時にterraformのplanを実行するトリガー
resource "google_cloudbuild_trigger" "trigger-terraform-plan" {
  project     = var.PROJECT_ID
  name        = "terraform-plan"
  description = "Trigger for pull requests to run terraform plan"

  github {
    owner = var.GITHUB_OWNER_NAME
    name  = var.REPO_NAME
    pull_request {
      branch = var.ENV == "development" ? "develop" : "main"
    }
  }

  included_files = ["dags/**", "requirements.txt", "terraform/**"]
  filename       = "cloud-build/terraform-plan.cloudbuild.yaml"
  substitutions = {
    _ENV = var.ENV
  }
}

# -----------------------------------------------------------
# Grant permissions to Cloud Build  
# -----------------------------------------------------------

# Cloud Buildのサービスアカウントにroles/iam.serviceAccountTokenCreatorの権限を付与
# ローカルで実行する場合はローカル実行者にも同様の権限を付与
# terraform実行のため
resource "google_project_iam_binding" "cloud_build_token_creator" {
  project = var.PROJECT_ID

  role = "roles/iam.serviceAccountTokenCreator"
  members = [
    "serviceAccount:${var.PROJECT_NUMBER}@cloudbuild.gserviceaccount.com",
    "serviceAccount:terraform-composer@${var.PROJECT_ID}.iam.gserviceaccount.com"
  ]

  lifecycle {
    ignore_changes = [members]
  }
}

# setup/create-terraform-impersonate-account/main.tf 実行のための権限付与 
resource "google_project_iam_member" "cloud_build_iam_admin" {
  project = var.PROJECT_ID
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${var.PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"
}

# github access token取得のための権限付与
resource "google_project_iam_member" "cloudbuild_secretAccessor" {
  project = var.PROJECT_ID
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${var.PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"
}

# terraform backendを参照するための権限付与
resource "google_project_iam_member" "cloudbuild_storageAdmin" {
  project = var.PROJECT_ID
  role    = "roles/storage.admin"
  member  = "serviceAccount:${var.PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"
}
