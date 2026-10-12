terraform { 
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-cicd"
    storage_account_name = "sttfcicd675931944"
    container_name       = "tfstate"
    key                  = "cicd-demo.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  # Subscription and login come from ARM_* environment variables
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-cicd-demo"
  location = "centralindia"

  tags = {
    ManagedBy = "terraform"
    Version   = "v1"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.demo.name
}
