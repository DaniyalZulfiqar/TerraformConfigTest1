# Stack state test

Upload `stack-state-tfconfig.zip` to OCI Resource Manager when creating a stack.
Keep the default variables and run **Plan**, then **Apply**. Creating the stack
alone does not create the resources or their state entries.

The default Apply creates five null resources:

- `null_resource.baseline`
- `null_resource.instance[0]`
- `null_resource.instance[1]`
- `null_resource.instance[2]`
- `null_resource.optional[0]`

These resources have no provisioners and create no OCI infrastructure. Terraform
must be able to install the `hashicorp/null` provider. Use a Resource Manager
Terraform version satisfying `>= 1.0.0, < 2.0.0`.

## Test sequence

After each change, run Plan and Apply, then inspect the stack's Terraform state
and job outputs. Each row continues from the preceding row.

| Change | Expected result after Apply |
| --- | --- |
| Initial defaults | Five resources and their IDs in state. |
| Run again without changes | No changes; all resource IDs stay the same. |
| Set `instance_count` to `5` | Two additions at indexes 3 and 4; seven resources total. |
| Set `instance_count` to `2` | Indexes 2, 3, and 4 removed; four resources total. |
| Set `replacement_token` to `v2` | Both remaining indexed resources replaced with new IDs; baseline and optional IDs unchanged. |
| Set `enable_optional` to `false` | Optional resource removed; three resources total. |
| Set `output_note` to `updated-state` | Output changes; all three resource IDs unchanged. |
| Run Destroy | No managed resources remain in state. |

`resource_ids_by_address` maps addresses to IDs for easy before/after comparison.
Null-resource trigger changes exercise replacement rather than in-place updates.
The baseline remains present until Destroy or a deliberate configuration change.

## Local use

```sh
terraform init
terraform plan
terraform apply
terraform state list
terraform output resource_ids_by_address
terraform destroy
```

No state, saved plans, credentials, or provider binaries are included in the ZIP.

References: [Oracle schema documentation](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/terraformconfigresourcemanager_topic-schema.htm)
and [HashiCorp null resource documentation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource.html).
