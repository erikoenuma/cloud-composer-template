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
| [google_secret_manager_secret.terraform_secrets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.terraform_secrets_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/secret_manager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The ID of the GCP project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr-range"></a> [cidr-range](#output\_cidr-range) | n/a |
| <a name="output_composer-environment_name"></a> [composer-environment\_name](#output\_composer-environment\_name) | n/a |
| <a name="output_connection-name"></a> [connection-name](#output\_connection-name) | n/a |
| <a name="output_git-remote-uri"></a> [git-remote-uri](#output\_git-remote-uri) | n/a |
| <a name="output_github-owner-name"></a> [github-owner-name](#output\_github-owner-name) | n/a |
| <a name="output_github-pat"></a> [github-pat](#output\_github-pat) | n/a |
| <a name="output_github-token-secret-id"></a> [github-token-secret-id](#output\_github-token-secret-id) | n/a |
| <a name="output_installation-id"></a> [installation-id](#output\_installation-id) | n/a |
| <a name="output_nat-ip-address"></a> [nat-ip-address](#output\_nat-ip-address) | n/a |
| <a name="output_network-name"></a> [network-name](#output\_network-name) | n/a |
| <a name="output_prod-project-number"></a> [prod-project-number](#output\_prod-project-number) | n/a |
| <a name="output_project-number"></a> [project-number](#output\_project-number) | n/a |
| <a name="output_repo-name"></a> [repo-name](#output\_repo-name) | n/a |
| <a name="output_subnet-name"></a> [subnet-name](#output\_subnet-name) | n/a |
<!-- END_TF_DOCS -->