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
| [google_compute_address.nat_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_network.composer_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.nat_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat_gw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.composer_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CIDR_RANGE"></a> [CIDR\_RANGE](#input\_CIDR\_RANGE) | The CIDR range of the subnetwork | `string` | n/a | yes |
| <a name="input_NAT_IP_ADDRESS"></a> [NAT\_IP\_ADDRESS](#input\_NAT\_IP\_ADDRESS) | The IP address of the NAT gateway | `string` | n/a | yes |
| <a name="input_NETWORK_NAME"></a> [NETWORK\_NAME](#input\_NETWORK\_NAME) | The name of the network | `string` | n/a | yes |
| <a name="input_PROJECT_ID"></a> [PROJECT\_ID](#input\_PROJECT\_ID) | The ID of the GCP project | `string` | n/a | yes |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | The region where resources will be created | `string` | n/a | yes |
| <a name="input_SUBNET_NAME"></a> [SUBNET\_NAME](#input\_SUBNET\_NAME) | The name of the subnetwork | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network-name"></a> [network-name](#output\_network-name) | n/a |
| <a name="output_subnet-name"></a> [subnet-name](#output\_subnet-name) | n/a |
<!-- END_TF_DOCS -->
