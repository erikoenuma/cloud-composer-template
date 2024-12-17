resource "google_project_service" "composer_api" {
  project            = var.PROJECT_ID
  service            = "composer.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_iam_member" "composer_api_service_agent_role" {
  project = var.PROJECT_ID
  role    = "roles/composer.ServiceAgentV2Ext"
  member  = "serviceAccount:service-${var.PROJECT_NUMBER}@cloudcomposer-accounts.iam.gserviceaccount.com"
}

resource "google_storage_bucket" "composer_dags_bucket" {
  name          = "${var.PROJECT_ID}-composer-dags"
  location      = var.REGION
  project       = var.PROJECT_ID
  force_destroy = false
}

resource "google_composer_environment" "composer_env" {
  name    = var.COMPOSER_ENVIRONMENT_NAME
  project = var.PROJECT_ID
  region  = var.REGION
  storage_config {
    bucket = google_storage_bucket.composer_dags_bucket.name
  }

  config {
    node_config {
      service_account = google_service_account.composer_env_account.email
      network         = "projects/${var.PROJECT_ID}/global/networks/${var.NETWORK}"
      subnetwork      = "projects/${var.PROJECT_ID}/regions/${var.REGION}/subnetworks/${var.SUBNET}"
    }

    private_environment_config {
      cloud_composer_connection_subnetwork = "projects/${var.PROJECT_ID}/regions/${var.REGION}/subnetworks/${var.SUBNET}"
      connection_type                      = "PRIVATE_SERVICE_CONNECT"
      enable_private_endpoint              = false
      enable_privately_used_public_ips     = false
    }

    web_server_network_access_control {
      allowed_ip_range {
        value       = "0.0.0.0/0"
        description = "Allows access from all IPv4 addresses"
      }

      allowed_ip_range {
        value       = "::0/0"
        description = "Allows access from all IPv6 addresses"
      }
    }

    software_config {
      airflow_config_overrides = {
        core-dags_are_paused_at_creation = "False"
        secrets-backend : "airflow.providers.google.cloud.secrets.secret_manager.CloudSecretManagerBackend"
        core-default_timezone : "Asia/Tokyo"
        core-max_active_runs_per_dag : "1"
        celery-sync_parallelism : "10"
      }
      pypi_packages = var.PYPI_PACKAGES
      image_version = "composer-2.9.10-airflow-2.9.3"
    }

    workloads_config {
      scheduler {
        cpu        = 2
        memory_gb  = 2
        storage_gb = 1
        count      = 1
      }
      web_server {
        cpu        = 1
        memory_gb  = 2
        storage_gb = 1
      }
      worker {
        cpu        = 2
        memory_gb  = 6
        storage_gb = 1
        min_count  = 1
        max_count  = 3
      }
    }

    environment_size = "ENVIRONMENT_SIZE_SMALL"
  }
}

output "composer_environment_name" {
  value = google_composer_environment.composer_env.name
}
