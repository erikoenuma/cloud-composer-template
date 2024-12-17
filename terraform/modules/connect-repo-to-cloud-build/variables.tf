variable "PROJECT_ID" {
  type = string
}

variable "PROJECT_NUMBER" {
  type        = number
  description = "Project Number"
}

variable "REGION" {
  type    = string
  default = "asia-northeast1"
}

variable "GITHUB_PAT" {
  type        = string
  description = "Personal Access Token for GitHub"
}

variable "SECRET_ID" {
  type        = string
  description = "Secret ID for the GitHub Personal Access"
}

variable "CONNECTION_NAME" {
  type        = string
  description = "Name of the Cloud Build Connection"
}

variable "INSTALLATION_ID" {
  type        = number
  description = "GitHub App Installation ID"
}

variable "REPO_NAME" {
  type        = string
  description = "Name of the repository"
}

variable "GIT_REMOTE_URI" {
  type        = string
  description = "URI of the repository"
}

variable "GITHUB_OWNER_NAME" {
  type        = string
  description = "GitHub Owner Name"
}

variable "ENV" {
  type        = string
  description = "Environment"
  default     = "development"
}
