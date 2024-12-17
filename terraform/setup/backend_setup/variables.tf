variable "PROJECT_ID" {
  description = "The ID of the GCP project"
  type        = string
  default     = ""
}

variable "REGION" {
  description = "The region where the bucket will be created"
  type        = string
  default     = "asia-northeast1"
}

variable "ENV" {
  description = "The environment"
  type        = string
  default     = "dev"
}
