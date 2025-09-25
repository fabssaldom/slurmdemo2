# This file configures the GCS backend for storing the Terraform state file.
# The GCS bucket specified here must exist before you run `terraform init`.
#
# IMPORTANT: Replace "your-globally-unique-bucket-name" with the actual name
# of your GCS bucket. Bucket names must be globally unique.

terraform {
  backend "gcs" {
    bucket = "slurmdemo1statefiles"
    prefix = "terraform/state/hpc-slurm"
  }
}