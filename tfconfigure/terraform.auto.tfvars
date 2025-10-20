project    = "slurmdemo2"
region     = "us-west1"
zone       = "us-west1-a"
services   = ["serviceusage.googleapis.com", "storage.googleapis.com", "orgpolicy.googleapis.com", "file.googleapis.com", "lustre.googleapis.com", "compute.googleapis.com", "iam.googleapis.com", "logging.googleapis.com", "servicenetworking.googleapis.com"]
constrains = ["compute.trustedImageProjects", "compute.requireShieldedVm"]
clustersa  = "1047573080277-compute@developer.gserviceaccount.com"
