# Purpose: Create a GCS bucket to store Terraform state
# 初回のみ実行

provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
}

resource "google_storage_bucket" "terraform_dx_composer_state" {
  name          = "tfstate-composer-${var.ENV}"
  location      = var.REGION
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
      with_state         = "ARCHIVED"
    }
  }
}

resource "google_storage_bucket" "terraform_connect_repo_to_cloud_build_state" {
  name          = "tfstate-connect-repo-to-cloud-build-${var.ENV}"
  location      = var.REGION
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
      with_state         = "ARCHIVED"
    }
  }
}

resource "google_storage_bucket" "terraform_create_terraform_impersonate_account_state" {
  name          = "tfstate-create-terraform-impersonate-account-${var.ENV}"
  location      = var.REGION
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
      with_state         = "ARCHIVED"
    }
  }
}
