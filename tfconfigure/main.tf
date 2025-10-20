
/*
 * @file: main.tf
 * @author: Fabs Salamanca <fsalaman@google.com>
 * @date: 2025-09-25
 * @description: Main TF code
 */


resource "google_project_service" "cloudresourcemanager_services" {
  project            = var.project
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "project_services" {
  project = var.project
  count   = length(var.services)
  service = var.services[count.index]

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}

module "project-iam-bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 8.0"

  projects = [var.project]
  mode     = "additive"

  bindings = {
    "roles/compute.admin" = [
      "serviceAccount:${var.clustersa}",
    ]
    "roles/storage.admin" = [
      "serviceAccount:${var.clustersa}",
    ]
  }
}

module "allow_images" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "~> 7.0"

  policy_root      = "project"         # either of organization, folder or project
  policy_root_id   = var.project       # either of org id, folder id or project id
  constraint       = var.constrains[0] # constraint identifier without constraints/ prefix. Example "compute.requireOsLogin"
  policy_type      = "list"            # either of list or boolean
  exclude_folders  = []
  exclude_projects = []

  rules = [
    # Rule 1
    {
      enforcement = false
      //dry_run     = true
    },
  ]

  depends_on = [google_project_service.project_services]
}

module "disable_shielded_vm" {
  source  = "terraform-google-modules/org-policy/google//modules/org_policy_v2"
  version = "~> 7.0"

  policy_root      = "project"         # either of organization, folder or project
  policy_root_id   = var.project       # either of org id, folder id or project id
  constraint       = var.constrains[1] # constraint identifier without constraints/ prefix. Example "compute.requireOsLogin"
  policy_type      = "boolean"         # either of list or boolean
  exclude_folders  = []
  exclude_projects = []

  rules = [
    # Rule 1
    {
      enforcement = false
      //dry_run     = true
    },
  ]

  depends_on = [google_project_service.project_services]
}
