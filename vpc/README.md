## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_shared_vpc_host_project.shared_vpc_host](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_shared_vpc_host_project) | resource |
| [google_compute_address.address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_network_peering_routes_config.peering_routes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering_routes_config) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_service_networking_connection.private_service_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_enable_cloud_nat"></a> [enable\_cloud\_nat](#input\_enable\_cloud\_nat) | NAT | `bool` | `false` | no |
| <a name="input_enable_ipv6_ula"></a> [enable\_ipv6\_ula](#input\_enable\_ipv6\_ula) | Enabled IPv6 ULA, this is a permenant change and cannot be undone! (default 'false') | `bool` | `false` | no |
| <a name="input_enable_private_service_conn"></a> [enable\_private\_service\_conn](#input\_enable\_private\_service\_conn) | GOOGLE Private Service Connection | `bool` | `false` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `string` | `""` | no |
| <a name="input_internal_ipv6_range"></a> [internal\_ipv6\_range](#input\_internal\_ipv6\_range) | When enabling IPv6 ULA, optionally, specify a /48 from fd20::/20 (default null) | `string` | `null` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively. | `number` | `"1460"` | no |
| <a name="input_network_firewall_policy_enforcement_order"></a> [network\_firewall\_policy\_enforcement\_order](#input\_network\_firewall\_policy\_enforcement\_order) | Set the order that Firewall Rules and Firewall Policies are evaluated. Valid values are `BEFORE_CLASSIC_FIREWALL` and `AFTER_CLASSIC_FIREWALL`. (default null or equivalent to `AFTER_CLASSIC_FIREWALL`) | `string` | `null` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| <a name="input_shared_vpc_host"></a> [shared\_vpc\_host](#input\_shared\_vpc\_host) | Makes this project a Shared VPC host if 'true' (default 'false') | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | Nat Ips |
| <a name="output_network"></a> [network](#output\_network) | The VPC resource being created |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the VPC being created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | The URI of the VPC being created |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | VPC project id |
