/**
  * Copyright 2023 Google LLC
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
  * You may obtain a copy of the License at
  *
  *      http://www.apache.org/licenses/LICENSE-2.0
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  */

module "hpc-nodeset" {
  source                  = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v6-nodeset"
  allow_automatic_updates = false
  bandwidth_tier          = "gvnic_enabled"
  labels                  = var.labels
  machine_type            = var.compute_node_machine_type
  name                    = "hpc-nodeset"
  network_storage         = flatten([var.network_storage_sharedstg])
  node_count_dynamic_max  = 3
  project_id              = var.project_id
  region                  = var.region
  subnetwork_self_link    = var.subnetwork_self_link_network
  zone                    = var.zone
}

module "hpc_partition" {
  source         = "./modules/embedded/community/modules/compute/schedmd-slurm-gcp-v6-partition"
  is_default     = true
  nodeset        = flatten([module.hpc-nodeset.nodeset])
  partition_name = "hpcpartition"
}

module "slurm_login" {
  source                  = "./modules/embedded/community/modules/scheduler/schedmd-slurm-gcp-v6-login"
  enable_login_public_ips = false
  labels                  = var.labels
  machine_type            = "n2-standard-4"
  name_prefix             = "slurm_login"
  project_id              = var.project_id
  region                  = var.region
  subnetwork_self_link    = var.subnetwork_self_link_network
  zone                    = var.zone
}

module "slurm_controller" {
  source                       = "./modules/embedded/community/modules/scheduler/schedmd-slurm-gcp-v6-controller"
  deployment_name              = var.deployment_name
  enable_controller_public_ips = false
  labels                       = var.labels
  login_nodes                  = flatten([module.slurm_login.login_nodes])
  machine_type                 = "n2-standard-4"
  network_storage              = flatten([var.network_storage_sharedstg])
  nodeset                      = flatten([module.hpc_partition.nodeset])
  nodeset_dyn                  = flatten([module.hpc_partition.nodeset_dyn])
  nodeset_tpu                  = flatten([module.hpc_partition.nodeset_tpu])
  partitions                   = flatten([module.hpc_partition.partitions])
  project_id                   = var.project_id
  region                       = var.region
  subnetwork_self_link         = var.subnetwork_self_link_network
  zone                         = var.zone
}
