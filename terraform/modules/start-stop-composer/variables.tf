variable "PROJECT_ID" {
  description = "The ID of the GCP project"
  type        = string
}

variable "REGION" {
  description = "The region where the bucket will be created"
  type        = string
}

variable "URI" {
    description = "The URI of the bucket to store Terraform state"
    type        = string
}
