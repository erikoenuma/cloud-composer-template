# secret managerでJSON形式でairflow-connectionsに使用する環境変数を管理しています
# このtfファイルでは、secret managerから環境変数を取得し、airflowで読み込めるようprefixをつけた接続情報を作成しています
# 参考: https://cloud.google.com/composer/docs/composer-2/configure-secret-manager?hl=ja

# get variables from secret manager
resource "google_secret_manager_secret" "composer_airflow_variables_for_connections" {
  project   = var.PROJECT_ID
  secret_id = "composer-airflow-variables-for-connections"
  replication {
    auto {}
  }
}

data "google_secret_manager_secret_version" "composer_airflow_variables_for_connections_version" {
  secret  = google_secret_manager_secret.composer_airflow_variables_for_connections.id
  version = "latest"
}

locals {
  variables = jsondecode(data.google_secret_manager_secret_version.composer_airflow_variables_for_connections_version.secret_data)
  airflow_connections = {
    slack = {
      conn_type = "slack",
      password  = local.variables["SLACK_OAUTH_TOKEN"],
    },
    cloud_function = {
      conn_type = "http",
      host      = "https://asia-northeast1-${var.PROJECT_ID}.cloudfunctions.net",
    },
    google_cloud = {
      conn_type = "google_cloud_platform",
      extra={"scope": "https://www.googleapis.com/auth/cloud-platform, https://www.googleapis.com/auth/drive"}
    }
    # 他の接続情報を追加する場合はここに追加してください
  }
}

resource "google_secret_manager_secret" "airflow_connections" {
  for_each = local.airflow_connections

  secret_id = "airflow-connections-${each.key}"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "airflow_connections_version" {
  for_each    = local.airflow_connections
  secret      = google_secret_manager_secret.airflow_connections[each.key].id
  secret_data = jsonencode(each.value)
}
