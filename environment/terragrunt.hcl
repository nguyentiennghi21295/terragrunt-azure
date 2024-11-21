locals {
  # Get Current Environment
  env_vars    = read_terragrunt_config(find_in_parent_folders("env_specific.hcl"))
  environment = local.env_vars.locals.environment

  # Get Current Region
  region_vars = read_terragrunt_config(find_in_parent_folders("region_specific.hcl"))
  region_conf = local.region_vars.locals.region
  region_real = (local.region_vars.locals.region == "francecentral" ? "France Central" :
          local.region_vars.locals.region == "eastus2" ? "East US 2" : "Unknown region")
          


  # Create prefix for resources and backend
  prefix  = "${local.environment}${local.region_conf}"
  rg_name = "${local.prefix}-rg"
  vnet_name = "${local.prefix}-vnet"
  sa_name = "${local.prefix}2024"
  sc_name = "${local.prefix}-sc"
}


# Values for module(s) for all projects
inputs = {
  environment = local.environment
  vnet_name   = local.vnet_name
  prefix      = local.prefix
  sa_name     = local.sa_name
  sc_name     = local.sc_name
  #app_name    = "${local.prefix}-myapp"
  rg_name     = local.rg_name
  rg_location = local.region_real
  rg_location_conf = local.region_conf
}


# Generate a backend (one per project)
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name = "${local.rg_name}"
    storage_account_name = "${local.sa_name}"
    container_name       = "${local.sc_name}"
    key                  = "${path_relative_to_include()}.tfstate"
  }
}
EOF
}

# Providers used by projects
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
    terraform {
  required_version = ">=1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.51, < 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# DO NOT DO THIS IN PRODUCTION ENVIRONMENT
provider "kubernetes" {
  host                   = module.aks.admin_host
  client_certificate     = base64decode(module.aks.admin_client_certificate)
  client_key             = base64decode(module.aks.admin_client_key)
  cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
}

provider "random" {}
EOF
}
