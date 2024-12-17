<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.terraform_connect_repo_to_cloud_build_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.terraform_create_terraform_impersonate_account_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.terraform_dx_composer_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ENV"></a> [ENV](#input\_ENV) | The environment | `string` | `"dev"` | no |
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The ID of the GCP project | `string` | `""` | no |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | The region where the bucket will be created | `string` | `"asia-northeast1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->