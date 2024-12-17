terraform {
  backend "gcs" {
    bucket = "tfstate-composer-prod"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

provider "google" {
  project                     = var.PROJECT_ID
  region                      = var.REGION
  impersonate_service_account = module.impersonation.terraform_service_account
  scopes                      = ["https://www.googleapis.com/auth/cloud-platform"]
}

module "impersonation" {
  source     = "../../modules/impersonation"
  PROJECT_ID = var.PROJECT_ID
}

module "secret-manager" {
  source     = "../../modules/secret-manager"
  PROJECT_ID = var.PROJECT_ID
}

module "vpc-network" {
  source         = "../../modules/vpc-network"
  PROJECT_ID     = var.PROJECT_ID
  REGION         = var.REGION
  NETWORK_NAME   = module.secret-manager.network-name
  SUBNET_NAME    = module.secret-manager.subnet-name
  CIDR_RANGE     = module.secret-manager.cidr-range
  NAT_IP_ADDRESS = module.secret-manager.nat-ip-address
}

module "cloud-composer" {
  source                    = "../../modules/cloud-composer"
  PROJECT_ID                = var.PROJECT_ID
  PROJECT_NUMBER            = module.secret-manager.project-number
  COMPOSER_ENVIRONMENT_NAME = module.secret-manager.composer-environment_name
  REGION                    = var.REGION
  NETWORK                   = module.vpc-network.network-name
  SUBNET                    = module.vpc-network.subnet-name
  PYPI_PACKAGES             = var.PYPI_PACKAGES
}

module "pubsub" {
  source = "../../modules/pubsub"
}

module "connect-repo-to-cloud-build" {
  source            = "../../modules/connect-repo-to-cloud-build"
  PROJECT_ID        = var.PROJECT_ID
  PROJECT_NUMBER    = module.secret-manager.project-number
  REGION            = var.REGION
  GITHUB_PAT        = module.secret-manager.github-pat
  SECRET_ID         = module.secret-manager.github-token-secret-id
  INSTALLATION_ID   = module.secret-manager.installation-id
  CONNECTION_NAME   = module.secret-manager.connection-name
  REPO_NAME         = module.secret-manager.repo-name
  GIT_REMOTE_URI    = module.secret-manager.git-remote-uri
  GITHUB_OWNER_NAME = module.secret-manager.github-owner-name
  ENV               = "production"
}


module "start-stop-composer" {
  source     = "../../modules/start-stop-composer"
  PROJECT_ID = var.PROJECT_ID
  REGION     = var.REGION
  URI        = module.secret-manager.git-remote-uri
}

module "cloud-scheduler" {
  source    = "../../modules/cloud-scheduler"
  PROJECT_ID = var.PROJECT_ID
}
