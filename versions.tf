terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.10.0"
        }
    }
    backend "azurerm" {
        resource_group_name  = "rg-terraformStorage"
        storage_account_name = "terraformstorage"
        container_name       = "jenkinskubernetesexampletfstate"
        key                  = "terraform.tfstate"
    }

    required_version = ">= 0.14"
}