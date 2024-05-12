/**
 * Copyright 2021 Google LLC
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

output "artifact_id" {
  description = "An identifier for the docker repo"
  value       = module.artifact_registry.artifact_id
}

output "create_time" {
  description = "The time when the repository was created"
  value       = module.artifact_registry.create_time
}

output "project_id" {
  description = "Project ID"
  value       = var.project_id
}

output "repo_location" {
  description = "Location of the Artifact Registry"
  value       = var.repo_location
}
