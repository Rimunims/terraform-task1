variable "project" {
  description = "the gcp project id"
  type = string
  default = "aws-to-gcp-infra"
}

variable "region" {
  description = "region where the resources will be deployed"
  type = string
  default = "us-central1-c"
}

variable "zone" {
  description = "the gcp zone where compute engine instances will be created"
  type = string
  default = "us-central1-c"
}

variable "network" {
  description = "the network to deploy resources into"
  type = string
  default = "default"
}

variable "subnetwork" {
    description = "the subnetwork containing resources"
    type = string
    default = "default"
}

variable "resolver_instance_count" {
  description = "The number of compute engine instances to deploy for the universal resolver"
  type = number
  default = 2
}
