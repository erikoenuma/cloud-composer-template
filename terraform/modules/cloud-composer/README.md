<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_composer_environment.composer_env](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/composer_environment) | resource |
| [google_project_iam_member.composer_api_service_agent_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.composer_env_account_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.composer_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.airflow_connections](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.airflow_variables](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.dx_composer_airflow_variables](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.dx_composer_airflow_variables_for_connections](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.airflow_connections_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.airflow_variables_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.composer_env_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.composer_dags_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_secret_manager_secret_version.dx_composer_airflow_variables_for_connections_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/secret_manager_secret_version) | data source |
| [google_secret_manager_secret_version.dx_composer_airflow_variables_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/secret_manager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_COMPOSER_ENVIRONMENT_NAME"></a> [COMPOSER\_ENVIRONMENT\_NAME](#input\_COMPOSER\_ENVIRONMENT\_NAME) | The name of the Composer environment | `string` | n/a | yes |
| <a name="input_NETWORK"></a> [NETWORK](#input\_NETWORK) | The name of the network to use for Composer | `string` | n/a | yes |
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The ID of the GCP project | `string` | n/a | yes |
| <a name="input_PROJECT_NUMBER"></a> [PROJECT\_NUMBER](#input\_PROJECT\_NUMBER) | The number of the GCP project | `number` | n/a | yes |
| <a name="input_PYPI_PACKAGES"></a> [PYPI\_PACKAGES](#input\_PYPI\_PACKAGES) | A map of PyPI packages to install in the Composer environment | `map(string)` | n/a | yes |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | The region where resources will be created | `string` | n/a | yes |
| <a name="input_SUBNET"></a> [SUBNET](#input\_SUBNET) | The name of the subnetwork to use for Composer | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_composer_environment_name"></a> [composer\_environment\_name](#output\_composer\_environment\_name) | n/a |
<!-- END_TF_DOCS -->
