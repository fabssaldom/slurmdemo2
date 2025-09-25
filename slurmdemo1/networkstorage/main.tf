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

module "network" {
  source          = "./modules/embedded/modules/network/vpc"
  deployment_name = var.deployment_name
  labels          = var.labels
  network_name    = var.network_name
  project_id      = var.project_id
  region          = var.region
}

module "private_service_access" {
  source     = "./modules/embedded/community/modules/network/private-service-access"
  labels     = var.labels
  network_id = module.network.network_id
  project_id = var.project_id
}

module "sharedstg" {
  source            = "./modules/embedded/modules/file-system/filestore"
  connect_mode      = module.private_service_access.connect_mode
  deployment_name   = var.deployment_name
  filestore_tier    = "ZONAL"
  labels            = var.labels
  local_mount       = "/shared"
  network_id        = module.network.network_id
  project_id        = var.project_id
  region            = var.region
  reserved_ip_range = module.private_service_access.reserved_ip_range
  size_gb           = 1024
  zone              = var.zone
}
