<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud-composer"></a> [cloud-composer](#module\_cloud-composer) | ../../modules/cloud-composer | n/a |
| <a name="module_cloud-scheduler"></a> [cloud-scheduler](#module\_cloud-scheduler) | ../../modules/cloud-scheduler | n/a |
| <a name="module_connect-repo-to-cloud-build"></a> [connect-repo-to-cloud-build](#module\_connect-repo-to-cloud-build) | ../../modules/connect-repo-to-cloud-build | n/a |
| <a name="module_impersonation"></a> [impersonation](#module\_impersonation) | ../../modules/impersonation | n/a |
| <a name="module_pubsub"></a> [pubsub](#module\_pubsub) | ../../modules/pubsub | n/a |
| <a name="module_secret-manager"></a> [secret-manager](#module\_secret-manager) | ../../modules/secret-manager | n/a |
| <a name="module_start-stop-composer"></a> [start-stop-composer](#module\_start-stop-composer) | ../../modules/start-stop-composer | n/a |
| <a name="module_vpc-network"></a> [vpc-network](#module\_vpc-network) | ../../modules/vpc-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CIDR_RANGE"></a> [CIDR\_RANGE](#input\_CIDR\_RANGE) | The CIDR range of the subnetwork. | `string` | `""` | no |
| <a name="input_COMPOSER_ENVIRONMENT_NAME"></a> [COMPOSER\_ENVIRONMENT\_NAME](#input\_COMPOSER\_ENVIRONMENT\_NAME) | The name of the Composer environment. | `string` | `""` | no |
| <a name="input_CONNECTION_NAME"></a> [CONNECTION\_NAME](#input\_CONNECTION\_NAME) | The name of the Cloud Build Connection. | `string` | `""` | no |
| <a name="input_ENV"></a> [ENV](#input\_ENV) | n/a | `string` | `"production"` | no |
| <a name="input_GITHUB_OWNER_NAME"></a> [GITHUB\_OWNER\_NAME](#input\_GITHUB\_OWNER\_NAME) | The GitHub Owner Name. | `string` | `""` | no |
| <a name="input_GITHUB_PAT"></a> [GITHUB\_PAT](#input\_GITHUB\_PAT) | The GitHub Personal Access Token. | `string` | `""` | no |
| <a name="input_GITHUB_TOKEN_SECRET_ID"></a> [GITHUB\_TOKEN\_SECRET\_ID](#input\_GITHUB\_TOKEN\_SECRET\_ID) | The Secret ID for the GitHub Personal Access Token. | `string` | `""` | no |
| <a name="input_INSTALLATION_ID"></a> [INSTALLATION\_ID](#input\_INSTALLATION\_ID) | The GitHub App Installation ID. | `string` | `""` | no |
| <a name="input_NAT_IP_ADDRESS"></a> [NAT\_IP\_ADDRESS](#input\_NAT\_IP\_ADDRESS) | The IP address of the NAT gateway. Using fixed IP address to avoid IP address change on Rakuraku Hanbai. | `string` | `""` | no |
| <a name="input_NETWORK_NAME"></a> [NETWORK\_NAME](#input\_NETWORK\_NAME) | The name of the network. | `string` | `""` | no |
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The Google Cloud project ID. | `string` | `""` | no |
| <a name="input_PROJECT_NUMBER"></a> [PROJECT\_NUMBER](#input\_PROJECT\_NUMBER) | The Google Cloud project number. | `string` | `""` | no |
| <a name="input_PYPI_PACKAGES"></a> [PYPI\_PACKAGES](#input\_PYPI\_PACKAGES) | A map of PyPI packages to install | `map(string)` | `{}` | no |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | The region where resources will be created. | `string` | `"asia-northeast1"` | no |
| <a name="input_REPO_NAME"></a> [REPO\_NAME](#input\_REPO\_NAME) | The name of the repository. | `string` | `""` | no |
| <a name="input_SUBNET_NAME"></a> [SUBNET\_NAME](#input\_SUBNET\_NAME) | The name of the subnetwork. | `string` | `""` | no |
| <a name="input_URI"></a> [URI](#input\_URI) | The URI of the repository. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
