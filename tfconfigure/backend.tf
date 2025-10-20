/*
 * @file: backend.tf
 * @author: Fabs Salamanca <fsalaman@google.com>
 * @date: 2025-09-25
 * @description: Backend configuration, typically a GCS Bucket
 */


terraform {
  backend "gcs" {
    bucket = "slurmdemo2statefiles"
    prefix = "terraform/state/hpc-slurm"
  }
}