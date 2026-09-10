variable "enable_optional" {
  description = "Create an optional null resource. Disable to remove its state entry on Apply."
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of indexed null resources. Increase or decrease to test state additions and removals."
  type        = number
  default     = 3

  validation {
    condition     = var.instance_count >= 0 && var.instance_count <= 20 && floor(var.instance_count) == var.instance_count
    error_message = "instance_count must be a whole number between 0 and 20."
  }
}

variable "output_note" {
  description = "A non-sensitive note stored only in outputs; changing it does not replace resources."
  type        = string
  default     = "initial-state"
}

variable "replacement_token" {
  description = "Change this value to replace all indexed null resources while retaining the baseline and optional resource."
  type        = string
  default     = "v1"
}
