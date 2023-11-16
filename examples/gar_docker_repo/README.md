# Docker Repo

This example illustrates how to use the `artifact-registry` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| repo\_location | The location of this Artifact Registry Repo | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| artifact\_id | An identifier for the docker repo |
| create\_time | The time when the repository was created |
| project\_id | Project ID |
| repo\_location | Location of the Artifat Registry |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
