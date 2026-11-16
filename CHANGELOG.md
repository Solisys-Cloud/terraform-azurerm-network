# Changelog

All notable changes to this module are documented in this file.

The module follows [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`.

| Part | Increase it when... | Effect on callers |
| --- | --- | --- |
| MAJOR | An input or output is removed or renamed, or a resource address changes | Callers must change their code |
| MINOR | A feature is added in a compatible way | Callers change nothing unless they want the feature |
| PATCH | A bug is fixed without changing inputs or outputs | Callers change nothing |

## 1.0.0

Initial release.

- One virtual network.
- One subnet per entry of `subnets`.
- One network security group per subnet, with its association.
- Outputs: `virtual_network_id`, `virtual_network_name`, `subnet_ids`, `network_security_group_ids`.
