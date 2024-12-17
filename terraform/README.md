# composer infrastructure

## 使用技術

- [terraform](https://www.terraform.io/)
- cloud composer
- vpn network
  - cloud composer をプライベートネットワーク上に構築しています
- CI/CD
  - cloud build

## 開発方法

- terraform を Docker で起動するためのスクリプトを用意しています: [terraform.sh](./bin/terraform.sh)

  - 実行方法(例):

    ```bash
        cd envs/production # 本番環境
        ../../bin/terraform.sh $COMMAND
    ```

  - make コマンドもあります

    - [Makefile](../Makefile)

    ```bash
        make terraform-init-production
        make terraform-plan-production
        make terraform-apply-production
    ```

- [terraform-docs](https://github.com/terraform-docs/terraform-docs)を使用しています。

  - Docker で起動するためのスクリプトを用意しています: [terraform-docs.sh](./bin/terraform-docs.sh)
  - 変更を加えた場合は必ず更新してください。
  - 実行方法(例):

    ```bash
        cd modules/cloud-composer # ドキュメントを作成したいディレクトリに移動
        ../../bin/terraform-docs.sh
    ```

## ディレクトリ構成

- 作動する github actions: [terraform.yaml](/.github/workflows/terraform.yaml)
  - development ブランチへの PR・push 時: [composer-terraform-dev](/.github/workflows/composer-terraform-dev.yaml)
  - main ブランチへの PR・push 時: [composer-terraform-prod](/.github/workflows/composer-terraform-prod.yaml)
- setup ディレクトリ内には初期構築時に使用したバックエンド・サービスアカウント・cloud build を用いた ci/cd 用の terraform が入っています

```bin/bash
.
├── README.md
├── bin
│   ├── terraform-docs.sh
│   └── terraform.sh
├── envs
│   ├── development
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── production
│       ├── README.md
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── modules
│   ├── cloud-composer
│   │   ├── README.md
│   │   ├── airflow-connections.tf
│   │   ├── airflow-variables.tf
│   │   ├── main.tf
│   │   ├── service-account.tf
│   │   └── variables.tf
│   ├── connect-repo-to-cloud-build
│   │   ├── README.md
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── impersonation
│   │   ├── README.md
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── secret-manager
│   │   ├── README.md
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── start-stop-composer
│   │   ├── README.md
│   │   ├── main.tf
│   │   └── variables.tf
│   └── vpc-network
│       ├── README.md
│       ├── main.tf
│       └── variables.tf
└── setup
    ├── backend_setup
    │   ├── README.md
    │   ├── main.tf
    │   └── variables.tf
    └── create-terraform-impersonate-account
        ├── README.md
        ├── envs
        │   ├── development
        │   │   └── config.tfbackend
        │   └── production
        │       └── config.tfbackend
        ├── main.tf
        └── variables.tf
```
