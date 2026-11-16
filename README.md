# terraform-azurerm-network

Terraform module that creates one Azure virtual network, a set of subnets, and one network security group per subnet.

Training module published by Solisys SRL. It is used in [Lab 03 - Module Versioning](https://github.com/Solisys-Cloud/azure-terraform-devops-lab) of the Azure Terraform & DevOps Labs.

The module does **not** create the resource group and does **not** configure the provider. The caller does both.

## Usage

Always pin a version with `ref`. Without it, Terraform takes the latest commit of the default branch, and your infrastructure can change without any change in your own code.

```hcl
module "network" {
  source = "git::https://github.com/Solisys-Cloud/terraform-azurerm-network.git?ref=v1.0.0"

  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  virtual_network_name = "vnet-lab03-network-dev-weu-001"
  address_space        = ["10.30.0.0/16"]

  subnets = {
    "snet-app-dev-weu-001"  = { address_prefixes = ["10.30.1.0/24"] }
    "snet-mgmt-dev-weu-001" = { address_prefixes = ["10.30.2.0/24"] }
  }

  tags = { environment = "dev" }
}
```

## Requirements

| Name | Version |
| --- | --- |
| Terraform | `>= 1.9.0, < 2.0.0` |
| `hashicorp/azurerm` | `~> 5.13` |

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `resource_group_name` | `string` | Yes | Existing resource group for the network. |
| `location` | `string` | Yes | Azure region. |
| `virtual_network_name` | `string` | Yes | Name of the virtual network. |
| `address_space` | `list(string)` | Yes | CIDR blocks of the virtual network. |
| `subnets` | `map(object)` | Yes | Subnet name mapped to `address_prefixes`. Names must start with `snet-`. |
| `tags` | `map(string)` | No | Tags for resources that support them. Default: `{}`. |

## Outputs

| Name | Description |
| --- | --- |
| `virtual_network_id` | Resource ID of the virtual network. |
| `virtual_network_name` | Name of the virtual network. |
| `subnet_ids` | Map of subnet names to subnet IDs. |
| `network_security_group_ids` | Map of subnet names to NSG IDs. |

## Resources created

For a call with **N** subnets: 1 virtual network, N subnets, N network security groups, N associations.

## Versions

See [CHANGELOG.md](CHANGELOG.md). Published versions are Git tags such as `v1.0.0`. A tag is never moved or reused: a fix is a new version.

## Notes

- NSG names are derived from subnet names: `snet-app-dev-weu-001` gives `nsg-app-dev-weu-001`.
- The NSGs contain only the default Azure rules. Default rules allow traffic inside a virtual network, so separate subnets are not network isolation.
- Training material. Not a production-ready reference module.

## Local check

```sh
terraform fmt -check -recursive
cd examples/basic
terraform init -backend=false
terraform validate
```
