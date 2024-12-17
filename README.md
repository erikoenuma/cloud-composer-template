# Cloud Composer Workflow

## これは何？

- 自分用の Cloud Composer 構築用テンプレートです
- バージョンや変数名など適宜変更して使用してください

## 使用技術

- Google Cloud 上に cloud composer 環境を作成
- terraform を使ってデプロイしています

## 構築済み環境

- ローカル環境構築済み（下記参照）

## 開発環境作成方法

1. gcloud 認証情報をローカルに保存する ([参考](https://github.com/GoogleCloudPlatform/composer-local-dev?tab=readme-ov-file#configure-credentials))

   ```bash
   make gcloud-set-credentials
   ```

2. スクリプトを実行

   ```bash
   make setup-local-env
   ```

3. `http://localhost:8080`にアクセス

   1. admin として airflow UI にアクセス・DAG ファイルの実行が可能です
   2. コンソール上で起動してからアクセスできるまでに少しラグがあります（~ 30 秒）

4. 環境変数・接続情報を設定する

   1. 以下の secret に dev 環境用の variables があります。適宜 airflow web ui から import してください。

      1. [リンクを入れる]()
      2. 一応 make コマンドあります

         ```make
         make get_airflow_variables_dev  # dev環境用のvariablesを取得
         ```

   2. airflow-connections の prefix がついているものが接続情報です。適宜 airflow web ui から import してください。
      1. [リンクを入れる]()

## ローカル開発方法

- [dags](./dags/)ディレクトリ内に DAG ファイルを作成し、開発環境で確認してください。
- 依存パッケージは`./composer-local-dev/composer/localdev-${VERSION}/requirements.txt`に記載後、コンテナを起動し直すと反映されます

  ```bash
  make stop-composer
  make start-composer
  ```

## デプロイ方法

- 以下、[公式に記載のデプロイフロー](https://cloud.google.com/composer/docs/composer-2/dag-cicd-github?hl=ja)を参考に実装しています。
  - PR が作成されると[test-dags.cloudbuild.yaml](./cloud-build/test-dags.cloudbuild.yaml)がクラウドビルドで実行され、dag ファイルのテストが実行されます。
  - PR が develop ブランチにマージされると[deploy-composer.cloudbuild.yaml](./cloud-build/deploy-composer.cloudbuild.yaml)がクラウドビルドで実行され、`composer-dev`という名前で dev 環境の cloud composer 環境が作成されます。
    - terraform で`envs/development/main.tf`を apply しています
  - main ブランチに push されると[deploy-composer.cloudbuild.yaml](./cloud-build/deploy-composer.cloudbuild.yaml)がクラウドビルドで実行され、dag ファイルが本番環境にアップロードされます。
    - 同時に、dev 環境の cloud composer 環境が削除されます（節約のためこのようなフローにしています）

### Dag ファイルで使用する環境変数・接続情報追加方法

> [!NOTE]
> 公式ドキュメント: https://cloud.google.com/composer/docs/composer-2/configure-secret-manager?hl=ja

#### 環境変数

1. secret manager に JSON 形式で追加してください。

   - [dev 環境のリンクを入れる]()

2. `terraform apply`が実行されると自動的に指定の prefix 付きの secrets が作成されます。（マージ時に実行されます）

- 該当ファイル:
  - [terraform/modules/cloud-composer/airflow-variables.tf](./terraform/modules/cloud-composer/airflow-variables.tf)

#### 接続情報

1. [terraform/modules/cloud-composer/airflow-connections.tf](./terraform/modules/cloud-composer/airflow-connections.tf)内 locals に追加してください。

   ```.tf
   locals {
      variables = jsondecode(data.google_secret_manager_secret_version.dx_composer_airflow_variables_for_connections_version.secret_data)
      airflow_connections = {
         slack = {
            conn_type = "slack",
            password  = local.variables["SLACK_OAUTH_TOKEN"],
         },
         <!-- ここに追加 -->
         connection_id = {
            conn_type = ""
            password  = local.variables["YOUR_SECRET_KEY"]
            account   = ""
         }
      }
   }
   ```

1. 接続情報内で環境変数を使いたい場合、secret manager に JSON 形式で追加してください。
   1. [リンクを入れる]()
1. `terraform apply`を実行すると自動的に指定の prefix 付きの secrets が作成されます。（マージ時に実行されます）

## Troubleshooting

### `Error: Error acquiring the state lock`が発生した時の対処法

このエラーは Terraform 状態ロックを取得しようとしたが、すでに別のプロセスがロックを保持しているため失敗した時に発生します。

#### case: cloud build で`deploy-composer.cloudbuild.yaml`を実行中に発生

- `.github/workflows/terraform.yaml`で terraform apply を行っており、競合が発生している可能性があります。
- 片方が終わってからもう片方を再度実行するようにしてください。

#### case: `terraform apply`を途中でキャンセルした時

- ロックファイルが残っている可能性があります。
- cloud storage のバケット内にある tfstate の`default.tflock`を削除してください。
  - dev: [リンクを入れる]()

### `make start-composer`もしくは`make setup-local-dev`が失敗する

```bash
2024-06-12 11:47:41 + echo Adding user username(502)
2024-06-12 11:47:41 + sudo useradd -m -r -g airflow -G airflow --home-dir /home/airflow -u 502 -o username
2024-06-12 11:47:41 useradd: user 'username' already exists
```

- github で PR が作成されていたので、マージ待ち(@2024/06/12 現在)
  - https://github.com/GoogleCloudPlatform/composer-local-dev/pull/49
- 短期的な対処法:

  1. docker container 削除
  2. composer-local-dev ディレクトリを削除して`make setup-local-env`を実行

## リンク集

- [DX プロジェクト ドキュメント]()
- [本番環境 composer]()
- [dev 環境 composer]()
- [業務フロー図]()
- [datamart ER 図]()
