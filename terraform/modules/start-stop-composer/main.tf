# 料金節約のため、平日の朝7時にComposerを起動し、夜23時にComposerを削除するスケジューラを作成しています
# 実行内容は composer/scripts/start-stop-composer.cloudbuild.yaml

resource "google_pubsub_topic" "cloud_build_topic" {
  name = "cloud-build-topic"
}

resource "google_project_service" "cloud_scheduler" {
  project = var.PROJECT_ID
  service = "cloudscheduler.googleapis.com"
}

# Cloud Scheduler ジョブの作成 (朝7時にComposerを起動)
resource "google_cloud_scheduler_job" "start_composer_job" {
  name      = "start-composer-job"
  description = "cloud composer環境を作成します"
  schedule  = "0 7 * * 1-5"
  time_zone = "Asia/Tokyo"
  pubsub_target {
    topic_name = google_pubsub_topic.cloud_build_topic.id
    data       = base64encode(jsonencode({ "action" : "start" }))
  }

  depends_on = [google_project_service.cloud_scheduler]
}

# Cloud Scheduler ジョブの作成 (夜23時にComposerを停止)
resource "google_cloud_scheduler_job" "stop_composer_job" {
  name      = "stop-composer-job"
  description = "cloud composer環境を削除します"
  schedule  = "0 23 * * 1-5"
  time_zone = "Asia/Tokyo"
  pubsub_target {
    topic_name = google_pubsub_topic.cloud_build_topic.id
    data       = base64encode(jsonencode({ "action" : "stop" }))
  }

  depends_on = [google_project_service.cloud_scheduler]
}

resource "google_cloudbuild_trigger" "composer_scheduler_trigger" {
  name = "composer-scheduler-trigger"

  source_to_build {
    uri       = var.URI
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "cloud-build/start-stop-composer.cloudbuild.yaml"
    uri       = var.URI
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }

  pubsub_config {
    topic        = google_pubsub_topic.cloud_build_topic.id
  }

  substitutions = {
    _ENV    = "production"
    _ACTION = "$(body.message.data.action)"
  }
}
