variable "PROJECT_ID" {
  description = "The ID of the GCP project"
  type        = string
}

variable "REGION" {
  description = "The region where resources will be created"
  type        = string
}

variable "NETWORK" {
  description = "The name of the network to use for Composer"
  type        = string
}

variable "SUBNET" {
  description = "The name of the subnetwork to use for Composer"
  type        = string
}

variable "COMPOSER_ENVIRONMENT_NAME" {
  description = "The name of the Composer environment"
  type        = string
}

variable "PROJECT_NUMBER" {
  description = "The number of the GCP project"
  type        = number
}

variable "PYPI_PACKAGES" {
  description = "A map of PyPI packages to install in the Composer environment"
  type        = map(string)
}
