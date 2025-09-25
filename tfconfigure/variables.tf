variable "project" {
  description = "The GCP project ID to deploy the Lustre instance in."
  type        = string
}

variable "region" {
  description = "The GCP region where the Lustre instance will be created."
  type        = string
}

variable "zone" {
  description = "The GCP zone where the Lustre instance will be created."
  type        = string
}

variable "services" {
  description = "Services to be enabled in the project"
  type        = list(string)
}

variable "constrains" {
  description = "Disable Argolis policies on the project"
  type        = list(string)
}