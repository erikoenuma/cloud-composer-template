resource "google_secret_manager_secret" "terraform_secrets" {
  project   = var.PROJECT_ID
  secret_id = "composer-terraform-secrets"
  replication {
    auto {}
  }
}

data "google_secret_manager_secret_version" "terraform_secrets_version" {
  secret  = google_secret_manager_secret.terraform_secrets.id
  version = "latest"
}

locals {
  secrets = jsondecode(data.google_secret_manager_secret_version.terraform_secrets_version.secret_data)
}

output "project-number" {
  value = local.secrets["project-number"]
}

output "network-name" {
  value = local.secrets["network-name"]
}

output "subnet-name" {
  value = local.secrets["subnet-name"]
}

output "cidr-range" {
  value = local.secrets["cidr-range"]
}

output "nat-ip-address" {
  value = local.secrets["nat-ip-address"]
}

output "composer-environment_name" {
  value = local.secrets["composer-environment-name"]
}

output "github-pat" {
  value = local.secrets["github-pat"]
}

output "github-token-secret-id" {
  value = local.secrets["github-token-secret-id"]
}

output "installation-id" {
  value = local.secrets["installation-id"]
}

output "connection-name" {
  value = local.secrets["connection-name"]
}

output "repo-name" {
  value = local.secrets["repo-name"]
}

output "git-remote-uri" {
  value = local.secrets["git-remote-uri"]
}

output "github-owner-name" {
  value = local.secrets["github-owner-name"]
}

output "prod-project-number" {
  value = local.secrets["prod-project-number"]
}
