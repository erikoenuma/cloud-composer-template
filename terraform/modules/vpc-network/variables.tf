variable "PROJECT_ID" {
  description = "The ID of the GCP project"
  type        = string
}

variable "REGION" {
  description = "The region where resources will be created"
  type        = string
}

variable "NETWORK_NAME" {
  description = "The name of the network"
  type        = string
}

variable "SUBNET_NAME" {
  description = "The name of the subnetwork"
  type        = string
}

variable "CIDR_RANGE" {
  description = "The CIDR range of the subnetwork"
  type        = string
}

variable "NAT_IP_ADDRESS" {
  description = "The IP address of the NAT gateway"
  type        = string
}
