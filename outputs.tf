output "baseline_id" {
  description = "Stable baseline ID for comparison across test runs."
  value       = null_resource.baseline.id
}

output "instance_ids" {
  description = "Indexed null resource IDs, in index order."
  value       = null_resource.instance[*].id
}

output "optional_ids" {
  description = "One optional resource ID when enabled, or an empty list when disabled."
  value       = null_resource.optional[*].id
}

output "output_note" {
  description = "Note for testing output-only state changes."
  value       = var.output_note
}

output "resource_count" {
  description = "Total managed null resources after Apply."
  value       = 1 + length(null_resource.instance) + length(null_resource.optional)
}

output "resource_ids_by_address" {
  description = "Terraform resource addresses mapped to their current IDs."
  value = merge(
    { "null_resource.baseline" = null_resource.baseline.id },
    { for index, instance in null_resource.instance : "null_resource.instance[${index}]" => instance.id },
    { for index, instance in null_resource.optional : "null_resource.optional[${index}]" => instance.id }
  )
}
