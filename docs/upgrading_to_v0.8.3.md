## Upgrade to v0.8.3

### ⚠️ Breaking change: output variable renames

The following output variables have been renamed:

| Old name | New name |
|--------|---------|
| `artifact_id` | `repository_id` |
| `repository_name` | `repository_name` |

#### Why
The new names better reflect the resource structure and improve consistency.

#### Migration
Update all references to the renamed outputs in your Terraform configuration:

```hcl
# Before
module.repo.artifact_id
module.repo.repository_name

# After
module.repo.repository_id
module.repo.repository_name

# Then run

terraform init -upgrade
terraform plan
```
