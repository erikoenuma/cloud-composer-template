# secret managerでJSON形式でairflowの変数を管理しています
# このtfファイルでは、secret managerからairflowの変数を取得し、airflowで読み込めるようprefixをつけた変数を作成しています
# 参考: https://cloud.google.com/composer/docs/composer-2/configure-secret-manager?hl=ja

# get secrets from secret manager
resource "google_secret_manager_secret" "composer_airflow_variables" {
  project   = var.PROJECT_ID
  secret_id = "composer-airflow-variables"
  replication {
    auto {}
  }
}

data "google_secret_manager_secret_version" "composer_airflow_variables_version" {
  secret  = google_secret_manager_secret.composer_airflow_variables.id
  version = "latest"
}

locals {
  airflow_variables = jsondecode(data.google_secret_manager_secret_version.composer_airflow_variables_version.secret_data)
}

# create airflow variables
resource "google_secret_manager_secret" "airflow_variables" {
  project   = var.PROJECT_ID
  for_each  = nonsensitive(local.airflow_variables)
  secret_id = "airflow-variables-${each.key}"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "airflow_variables_version" {
  for_each    = nonsensitive(local.airflow_variables)
  secret      = google_secret_manager_secret.airflow_variables[each.key].id
  secret_data = each.value
}
