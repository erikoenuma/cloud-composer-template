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
| [google_cloud_scheduler_job.start_composer_job](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_cloud_scheduler_job.stop_composer_job](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_cloudbuild_trigger.composer_scheduler_trigger](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_project_service.cloud_scheduler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_pubsub_topic.cloud_build_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The ID of the GCP project | `string` | n/a | yes |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | The region where the bucket will be created | `string` | n/a | yes |
| <a name="input_URI"></a> [URI](#input\_URI) | The URI of the bucket to store Terraform state | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
