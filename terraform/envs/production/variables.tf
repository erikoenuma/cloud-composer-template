variable "PROJECT_ID" {
  type        = string
  description = "The Google Cloud project ID."
  default     = ""
}

variable "PROJECT_NUMBER" {
  type        = string
  description = "The Google Cloud project number."
  default     = ""
}

variable "REGION" {
  type        = string
  description = "The region where resources will be created."
  default     = "asia-northeast1"
}

variable "NETWORK_NAME" {
  type        = string
  description = "The name of the network."
  default     = ""
}

variable "SUBNET_NAME" {
  type        = string
  description = "The name of the subnetwork."
  default     = ""
}

variable "CIDR_RANGE" {
  type        = string
  description = "The CIDR range of the subnetwork."
  default     = ""
}

variable "NAT_IP_ADDRESS" {
  type        = string
  description = "The IP address of the NAT gateway. Using fixed IP address to avoid IP address change on Rakuraku Hanbai."
  default     = ""
}

variable "COMPOSER_ENVIRONMENT_NAME" {
  type        = string
  description = "The name of the Composer environment."
  default     = ""
}

variable "GITHUB_PAT" {
  type        = string
  description = "The GitHub Personal Access Token."
  default     = ""
}

variable "GITHUB_TOKEN_SECRET_ID" {
  type        = string
  description = "The Secret ID for the GitHub Personal Access Token."
  default     = ""
}

variable "CONNECTION_NAME" {
  type        = string
  description = "The name of the Cloud Build Connection."
  default     = ""
}

variable "INSTALLATION_ID" {
  type        = string
  description = "The GitHub App Installation ID."
  default     = ""
}

variable "REPO_NAME" {
  type        = string
  description = "The name of the repository."
  default     = ""
}

variable "URI" {
  type        = string
  description = "The URI of the repository."
  default     = ""
}

variable "GITHUB_OWNER_NAME" {
  type        = string
  description = "The GitHub Owner Name."
  default     = ""
}

variable "ENV" {
  type    = string
  default = "production"
}

variable "PYPI_PACKAGES" {
  description = "A map of PyPI packages to install"
  type        = map(string)
  default     = {}
}
