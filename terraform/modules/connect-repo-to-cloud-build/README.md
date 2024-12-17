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
| [google_cloudbuild_trigger.trigger-deploy-composer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_cloudbuild_trigger.trigger-terraform-plan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_cloudbuild_trigger.trigger-test-dags](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_cloudbuildv2_connection.my_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuildv2_connection) | resource |
| [google_cloudbuildv2_repository.my_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuildv2_repository) | resource |
| [google_project_iam_binding.cloud_build_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.cloud_build_iam_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudbuild_secretAccessor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudbuild_storageAdmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.secret_manager_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_secret_manager_secret.github_token_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_policy) | resource |
| [google_secret_manager_secret_version.github_token_secret_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_iam_policy.serviceagent_secretAccessor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CONNECTION_NAME"></a> [CONNECTION\_NAME](#input\_CONNECTION\_NAME) | Name of the Cloud Build Connection | `string` | n/a | yes |
| <a name="input_ENV"></a> [ENV](#input\_ENV) | Environment | `string` | `"development"` | no |
| <a name="input_GITHUB_OWNER_NAME"></a> [GITHUB\_OWNER\_NAME](#input\_GITHUB\_OWNER\_NAME) | GitHub Owner Name | `string` | n/a | yes |
| <a name="input_GITHUB_PAT"></a> [GITHUB\_PAT](#input\_GITHUB\_PAT) | Personal Access Token for GitHub | `string` | n/a | yes |
| <a name="input_GIT_REMOTE_URI"></a> [GIT\_REMOTE\_URI](#input\_GIT\_REMOTE\_URI) | URI of the repository | `string` | n/a | yes |
| <a name="input_INSTALLATION_ID"></a> [INSTALLATION\_ID](#input\_INSTALLATION\_ID) | GitHub App Installation ID | `number` | n/a | yes |
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | n/a | `string` | n/a | yes |
| <a name="input_PROJECT_NUMBER"></a> [PROJECT\_NUMBER](#input\_PROJECT\_NUMBER) | Project Number | `number` | n/a | yes |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | n/a | `string` | `"asia-northeast1"` | no |
| <a name="input_REPO_NAME"></a> [REPO\_NAME](#input\_REPO\_NAME) | Name of the repository | `string` | n/a | yes |
| <a name="input_SECRET_ID"></a> [SECRET\_ID](#input\_SECRET\_ID) | Secret ID for the GitHub Personal Access | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->