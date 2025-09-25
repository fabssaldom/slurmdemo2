project    = "slurmdemo1"
region     = "us-central1"
zone       = "us-central1-a"
services   = ["orgpolicy.googleapis.com", "file.googleapis.com", "lustre.googleapis.com", "compute.googleapis.com", "iam.googleapis.com", "logging.googleapis.com", "servicenetworking.googleapis.com"]
constrains = ["compute.trustedImageProjects", "compute.requireShieldedVm"]
