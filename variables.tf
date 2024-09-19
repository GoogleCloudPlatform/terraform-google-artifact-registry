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

variable "project_id" {
  type        = string
  description = "The project ID to create the repository"
}

variable "repository_id" {
  type        = string
  description = "The repository name"
}

variable "location" {
  type        = string
  description = "The name of the location this repository is located in"
}

variable "format" {
  type        = string
  description = "The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group."
}

variable "mode" {
  type        = string
  description = "The mode configures the repository to serve artifacts from different sources. Default value is STANDARD_REPOSITORY. Possible values are: STANDARD_REPOSITORY, VIRTUAL_REPOSITORY, REMOTE_REPOSITORY"
  default     = "STANDARD_REPOSITORY"
}

variable "description" {
  type        = string
  description = "The user-provided description of the repository"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "Labels for the repository"
  default     = {}
}

variable "kms_key_name" {
  type        = string
  description = "The Cloud KMS resource name of the customer managed encryption key that’s used to encrypt the contents of the Repository. Has the form: projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key. This value may not be changed after the Repository has been created"
  default     = null
}

variable "docker_config" {
  type = object({
    immutable_tags = optional(bool)
  })
  description = "Docker repository config contains repository level configuration for the repositories of docker type"
  default     = null
}

variable "maven_config" {
  type = object({
    allow_snapshot_overwrites = optional(bool)
    version_policy            = optional(string)
  })
  description = "MavenRepositoryConfig is maven related repository details. Provides additional configuration details for repositories of the maven format type."
  default     = null
}

variable "virtual_repository_config" {
  type = object({
    upstream_policies = optional(list(object({
      id         = string
      repository = string
      priority   = number
    })), null)
  })
  description = "Configuration specific for a Virtual Repository."
  default     = null
}

variable "remote_repository_config" {
  type = object({
    description                 = optional(string)
    disable_upstream_validation = optional(bool, true)
    upstream_credentials = optional(object({
      username                = string
      password_secret_version = string
    }), null)
    apt_repository = optional(object({
      public_repository = optional(object({
        repository_base = string
        repository_path = string
      }), null)
    }), null)
    docker_repository = optional(object({
      public_repository = optional(string)
      custom_repository = optional(object({
        uri = string
      }), null)
    }), null)
    maven_repository = optional(object({
      public_repository = optional(string)
      custom_repository = optional(object({
        uri = string
      }), null)
    }), null)
    npm_repository = optional(object({
      public_repository = optional(string)
      custom_repository = optional(object({
        uri = string
      }), null)
    }), null)
    python_repository = optional(object({
      public_repository = optional(string)
      custom_repository = optional(object({
        uri = string
      }), null)
    }), null)
    yum_repository = optional(object({
      public_repository = optional(object({
        repository_base = string
        repository_path = string
      }), null)
    }), null)
  })
  description = "Configuration specific for a Remote Repository."
  default     = null
}

variable "cleanup_policy_dry_run" {
  type        = bool
  description = "If true, the cleanup pipeline is prevented from deleting versions in this repository"
  default     = false
}

variable "cleanup_policies" {
  type = map(object({
    action = optional(string)
    condition = optional(object({
      tag_state             = optional(string)
      tag_prefixes          = optional(list(string))
      version_name_prefixes = optional(list(string))
      package_name_prefixes = optional(list(string))
      older_than            = optional(string)
      newer_than            = optional(string)
    }), null)
    most_recent_versions = optional(object({
      package_name_prefixes = optional(list(string))
      keep_count            = optional(number)
    }), null)
  }))
  description = "Cleanup policies for this repository. Cleanup policies indicate when certain package versions can be automatically deleted. Map keys are policy IDs supplied by users during policy creation. They must unique within a repository and be under 128 characters in length."
  default     = {}
}

# VPC SC
variable "enable_vpcsc_policy" {
  type        = bool
  description = "Enable VPC SC policy"
  default     = false
}

variable "vpcsc_policy" {
  type        = string
  description = "The VPC SC policy for project and location. Possible values are: DENY, ALLOW"
  default     = "ALLOW"
}

// IAM
variable "members" {
  type        = map(list(string))
  description = "Artifact Registry Reader and Writer roles for Users/SAs. Key names must be readers and/or writers"
  default     = {}
  validation {
    condition = alltrue([
      for key in keys(var.members) : contains(["readers", "writers"], key)
    ])
    error_message = "The supported keys are readers and writers."
  }
}
