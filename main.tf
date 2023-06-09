terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }

    aws={
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "jafsilvaremotestate"
    container_name       = "remotestate"
    key                  = "pipeline-github-actions/terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "jafsilvaremotestate"
    container_name       = "remotestate"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "Jose Aparecido"
      managed-by = "terraform"
    }
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jafsilva-02021990-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}