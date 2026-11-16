# Basic example: one resource group and one network with two subnets.
#
# This example calls the module from the local checkout (source = "../..").
# Consumers of a published version use a Git source with an explicit tag:
#   source = "git::https://github.com/Solisys-Cloud/terraform-azurerm-network.git?ref=v1.0.0"

terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.13"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-network-dev-weu-001"
  location = "westeurope"
}

module "network" {
  source = "../.."

  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  virtual_network_name = "vnet-example-network-dev-weu-001"
  address_space        = ["10.50.0.0/16"]

  subnets = {
    "snet-app-dev-weu-001"  = { address_prefixes = ["10.50.1.0/24"] }
    "snet-mgmt-dev-weu-001" = { address_prefixes = ["10.50.2.0/24"] }
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

output "subnet_ids" {
  description = "Subnet IDs created by the module."
  value       = module.network.subnet_ids
}
