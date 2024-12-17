#!/bin/bash
# https://cloud.google.com/composer/docs/composer-2/run-local-airflow-environments?hl=ja
# 参考: https://tech.classi.jp/entry/cloud-composer-local-dev-tool

# ルートディレクトリの取得
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 環境変数の設定
export REPO_URL="https://github.com/GoogleCloudPlatform/composer-local-dev.git"
export DAG_PROJECT_ROOT="${BASE_DIR}"
export DAG_PATH="dags"
export LOCAL_DEV_TOOL_PROJECT_ROOT="${DAG_PROJECT_ROOT}/composer-local-dev"
export COMPOSER_VERSION="2.9.10"
export AIRFLOW_VERSION="2.9.3"
export LOCAL_ENV_NAME="localdev-${COMPOSER_VERSION//./_}-${AIRFLOW_VERSION//./_}"

echo "DAG_PROJECT_ROOT: $DAG_PROJECT_ROOT"
echo "DAG_PATH: $DAG_PATH"
echo "LOCAL_DEV_TOOL_PROJECT_ROOT: $LOCAL_DEV_TOOL_PROJECT_ROOT"

# リポジトリをクローン
if [ ! -d "$LOCAL_DEV_TOOL_PROJECT_ROOT" ]; then
    git clone "$REPO_URL" "$LOCAL_DEV_TOOL_PROJECT_ROOT"
fi

# ローカル開発ツールのディレクトリに移動
cd "$LOCAL_DEV_TOOL_PROJECT_ROOT"

# 必要なパッケージのインストール
pip install .
# 2024.05.23現在、最新バージョンのrequestsがインストールされるとエラーが発生するため、バージョンを固定
# 参考: https://github.com/docker/docker-py/issues/3256
yes | pip uninstall requests
pip install requests==2.31.0

# Cloud Composer環境の初期設定（初回のみ）
if [ ! -d "composer/$LOCAL_ENV_NAME" ]; then
    composer-dev create \
        --from-image-version "composer-${COMPOSER_VERSION}-airflow-${AIRFLOW_VERSION}" \
        --dags-path "$DAG_PROJECT_ROOT/$DAG_PATH" \
        "$LOCAL_ENV_NAME" 
    # ローカル開発環境変数の設定（これをしないと認証情報の読み取りエラーが出ます）
    # https://github.com/GoogleCloudPlatform/composer-local-dev/blob/main/README.md#enable-the-container-user-to-access-mounted-files-and-directories-from-the-host
    echo "COMPOSER_CONTAINER_RUN_AS_HOST_USER=True" >> $LOCAL_DEV_TOOL_PROJECT_ROOT/composer/$LOCAL_ENV_NAME/variables.env
    # DAGの実行制限を1に設定(重複実行を避ける)
    echo "AIRFLOW__CORE__MAX_ACTIVE_RUNS_PER_DAG=1" >> $LOCAL_DEV_TOOL_PROJECT_ROOT/composer/$LOCAL_ENV_NAME/variables.env
    # dagを手動で実行する際にパラメータがない場合でもフォームを表示する
    echo "AIRFLOW__WEBSERVER__SHOW_TRIGGER_FORM_IF_NO_PARAMS=True" >> $LOCAL_DEV_TOOL_PROJECT_ROOT/composer/$LOCAL_ENV_NAME/variables.env
fi

# requirements.txtをコピー
cp "$DAG_PROJECT_ROOT/requirements.txt" "$LOCAL_DEV_TOOL_PROJECT_ROOT/composer/$LOCAL_ENV_NAME/requirements.txt"

# ローカル開発環境の起動
cd "$LOCAL_DEV_TOOL_PROJECT_ROOT" && composer-dev start "$LOCAL_ENV_NAME"

echo "ローカル開発環境が正常に構築されました。http://localhost:8080 でAirflowにアクセスできます。"
