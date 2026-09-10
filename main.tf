# A stable resource for comparing IDs across changes to the test inputs.
resource "null_resource" "baseline" {
  triggers = {
    purpose = "stack-state-test"
  }
}

# Count is intentional: this fixture exercises indexed state addresses.
resource "null_resource" "instance" {
  count = var.instance_count

  triggers = {
    index             = tostring(count.index)
    replacement_token = var.replacement_token
  }
}

resource "null_resource" "optional" {
  count = var.enable_optional ? 1 : 0

  triggers = {
    purpose = "optional-state-entry"
  }
}
