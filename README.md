# terraform-google-artifact-registry

## Description
### Tagline
This is an auto-generated module.

### Detailed
This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/), which by default generates a module that simply creates a GCS bucket. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided name

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Architecture
![alt text for diagram](https://www.link-to-architecture-diagram.com)
1. Architecture description step no. 1
2. Architecture description step no. 2
3. Architecture description step no. N

## Documentation
- [Hosting a Static Website](https://cloud.google.com/storage/docs/hosting-static-website)

## Deployment Duration
Configuration: X mins
Deployment: Y mins

## Cost
[Blueprint cost details](https://cloud.google.com/products/calculator?id=02fb0c45-cc29-4567-8cc6-f72ac9024add)

## Usage

Basic usage of this module is as follows:

```hcl
module "artifact_registry" {
  source  = "terraform-google-modules/artifact-registry/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cleanup\_policies | Cleanup policies for this repository. Cleanup policies indicate when certain package versions can be automatically deleted. Map keys are policy IDs supplied by users during policy creation. They must unique within a repository and be under 128 characters in length. | <pre>map(object({<br>    action = optional(string)<br>    condition = optional(object({<br>      tag_state             = optional(string)<br>      tag_prefixes          = optional(list(string))<br>      version_name_prefixes = optional(list(string))<br>      package_name_prefixes = optional(list(string))<br>      older_than            = optional(string)<br>      newer_than            = optional(string)<br>    }), null)<br>    most_recent_versions = optional(object({<br>      package_name_prefixes = optional(list(string))<br>      keep_count            = optional(number)<br>    }), null)<br>  }))</pre> | `{}` | no |
| cleanup\_policy\_dry\_run | If true, the cleanup pipeline is prevented from deleting versions in this repository | `bool` | `false` | no |
| description | The user-provided description of the repository | `string` | `null` | no |
| docker\_config | Docker repository config contains repository level configuration for the repositories of docker type | <pre>object({<br>    immutable_tags = optional(bool)<br>  })</pre> | `null` | no |
| format | The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group. | `string` | n/a | yes |
| kms\_key\_name | The Cloud KMS resource name of the customer managed encryption key that’s used to encrypt the contents of the Repository. Has the form: projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key. This value may not be changed after the Repository has been created | `string` | `null` | no |
| labels | Lables for the repository | `map(string)` | `{}` | no |
| location | The name of the location this repository is located in | `string` | n/a | yes |
| maven\_config | MavenRepositoryConfig is maven related repository details. Provides additional configuration details for repositories of the maven format type. | <pre>object({<br>    allow_snapshot_overwrites = optional(bool)<br>    version_policy            = optional(string)<br>  })</pre> | `null` | no |
| mode | The mode configures the repository to serve artifacts from different sources. Default value is STANDARD\_REPOSITORY. Possible values are: STANDARD\_REPOSITORY, VIRTUAL\_REPOSITORY, REMOTE\_REPOSITORY | `string` | `"STANDARD_REPOSITORY"` | no |
| project\_id | The project ID to create the repository | `string` | n/a | yes |
| remote\_repository\_config | Configuration specific for a Remote Repository. | <pre>object({<br>    description = optional(string)<br>    apt_repository = optional(object({<br>      public_repository = optional(object({<br>        repository_base = string<br>        repository_path = string<br>      }), null)<br>    }), null)<br>    docker_repository = optional(object({<br>      public_repository = optional(string, "DOCKER_HUB")<br>    }), null)<br>    maven_repository = optional(object({<br>      public_repository = optional(string, "MAVEN_CENTRAL")<br>    }), null)<br>    npm_repository = optional(object({<br>      public_repository = optional(string, "NPMJS")<br>    }), null)<br>    python_repository = optional(object({<br>      public_repository = optional(string, "PYPI")<br>    }), null)<br>    yum_repository = optional(object({<br>      public_repository = optional(object({<br>        repository_base = string<br>        repository_path = string<br>      }), null)<br>    }), null)<br>  })</pre> | `null` | no |
| repository\_id | The repository name | `string` | n/a | yes |
| virtual\_repository\_config | Configuration specific for a Virtual Repository. | <pre>object({<br>    upstream_policies = optional(object({<br>      id         = string<br>      repository = string<br>      priority   = number<br>    }), null)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| artifact\_id | an identifier for the resource |
| artifact\_name | an identifier for the resource |
| create\_time | The time when the repository was created. |
| update\_time | The time when the repository was last updated. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
