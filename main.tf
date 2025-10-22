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

resource "google_artifact_registry_repository" "repo" {
  provider = google-beta

  repository_id = var.repository_id
  location      = var.location
  format        = var.format
  project       = var.project_id
  mode          = var.mode
  description   = var.description
  labels        = var.labels

  kms_key_name = var.kms_key_name

  dynamic "docker_config" {
    for_each = var.docker_config[*]
    content {
      immutable_tags = docker_config.value.immutable_tags
    }
  }

  dynamic "maven_config" {
    for_each = var.maven_config[*]
    content {
      allow_snapshot_overwrites = maven_config.value.allow_snapshot_overwrites
      version_policy            = maven_config.value.version_policy
    }
  }

  dynamic "virtual_repository_config" {
    for_each = var.virtual_repository_config[*]
    content {
      dynamic "upstream_policies" {
        for_each = virtual_repository_config.value.upstream_policies[*]
        content {
          id         = upstream_policies.value.id
          repository = upstream_policies.value.repository
          priority   = upstream_policies.value.priority
        }
      }
    }
  }

  dynamic "remote_repository_config" {
    for_each = var.remote_repository_config[*]
    content {
      description = remote_repository_config.value.description

      disable_upstream_validation = remote_repository_config.value.disable_upstream_validation

      dynamic "upstream_credentials" {
        for_each = remote_repository_config.value.upstream_credentials[*]
        content {
          username_password_credentials {
            username                = upstream_credentials.value.username
            password_secret_version = upstream_credentials.value.password_secret_version
          }
        }
      }

      dynamic "apt_repository" {
        for_each = remote_repository_config.value.apt_repository[*]
        content {
          dynamic "public_repository" {
            for_each = apt_repository.value.public_repository[*]
            content {
              repository_base = public_repository.value.repository_base
              repository_path = public_repository.value.repository_path
            }
          }
        }
      }

      dynamic "docker_repository" {
        for_each = remote_repository_config.value.docker_repository[*]
        content {
          public_repository = docker_repository.value.public_repository
          dynamic "custom_repository" {
            for_each = docker_repository.value.custom_repository[*]
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "maven_repository" {
        for_each = remote_repository_config.value.maven_repository[*]
        content {
          public_repository = maven_repository.value.public_repository
          dynamic "custom_repository" {
            for_each = maven_repository.value.custom_repository[*]
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "npm_repository" {
        for_each = remote_repository_config.value.npm_repository[*]
        content {
          public_repository = npm_repository.value.public_repository
          dynamic "custom_repository" {
            for_each = npm_repository.value.custom_repository[*]
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "python_repository" {
        for_each = remote_repository_config.value.python_repository[*]
        content {
          public_repository = python_repository.value.public_repository
          dynamic "custom_repository" {
            for_each = python_repository.value.custom_repository[*]
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "yum_repository" {
        for_each = remote_repository_config.value.yum_repository[*]
        content {
          dynamic "public_repository" {
            for_each = yum_repository.value.public_repository[*]
            content {
              repository_base = public_repository.value.repository_base
              repository_path = public_repository.value.repository_path
            }
          }
        }
      }

      dynamic "common_repository" {
        for_each = remote_repository_config.value.common_repository[*]
        content {
          uri = common_repository.value.uri
        }
      }
    }
  }

  cleanup_policy_dry_run = var.cleanup_policy_dry_run

  dynamic "cleanup_policies" {
    for_each = var.cleanup_policies
    content {
      id     = cleanup_policies.key
      action = cleanup_policies.value.action

      dynamic "condition" {
        for_each = cleanup_policies.value.condition[*]
        content {
          tag_state             = condition.value.tag_state
          tag_prefixes          = condition.value.tag_prefixes
          older_than            = condition.value.older_than
          newer_than            = condition.value.newer_than
          version_name_prefixes = condition.value.version_name_prefixes
          package_name_prefixes = condition.value.package_name_prefixes
        }
      }

      dynamic "most_recent_versions" {
        for_each = cleanup_policies.value.most_recent_versions[*]
        content {
          keep_count            = most_recent_versions.value.keep_count
          package_name_prefixes = most_recent_versions.value.package_name_prefixes
        }
      }
    }
  }
}

resource "google_artifact_registry_vpcsc_config" "repo_vpc_sc" {
  count = var.enable_vpcsc_policy ? 1 : 0

  provider     = google-beta
  vpcsc_policy = var.vpcsc_policy
  location     = google_artifact_registry_repository.repo.location
  project      = google_artifact_registry_repository.repo.project
}

resource "google_artifact_registry_repository_iam_member" "readers" {
  for_each   = toset(contains(keys(var.members), "readers") ? var.members["readers"] : [])
  project    = google_artifact_registry_repository.repo.project
  location   = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name

  role   = "roles/artifactregistry.reader"
  member = each.value

  depends_on = [
    google_artifact_registry_repository.repo
  ]
}

resource "google_artifact_registry_repository_iam_member" "writers" {
  for_each   = toset(contains(keys(var.members), "writers") ? var.members["writers"] : [])
  project    = google_artifact_registry_repository.repo.project
  location   = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name

  role   = "roles/artifactregistry.writer"
  member = each.value

  depends_on = [
    google_artifact_registry_repository.repo
  ]
}
