# -------------------------
# Naming inputs
# -------------------------
variable "namepref" {
  description = "Prefix for names when replicas are used."
  type        = string
  default     = "" # Changed from null
}

variable "environment_string" {
  description = "Environment string to include in the name (e.g., dev, prod)."
  type        = string
  default     = ""
}

variable "custom_string" {
  description = "Custom string to include in the name."
  type        = string
  default     = ""
}

variable "replicas" {
  description = "Number of replicas when using namepref."
  type        = number
  default     = 0
  validation {
    condition     = var.replicas >= 0
    error_message = "replicas must be >= 0."
  }
}

variable "nameslist" {
  description = "Explicit list of names."
  type        = list(string)
  default     = []
}

variable "suffix_style" {
  description = "Suffix style for replicas: 'numeric' or 'alpha'."
  type        = string
  default     = "numeric"
  validation {
    condition     = contains(["numeric", "alpha"], var.suffix_style)
    error_message = "suffix_style must be 'numeric' or 'alpha'."
  }
}

variable "zero_padding" {
  description = "Digits for zero padding in numeric suffix. 2 -> 01, 02."
  type        = number
  default     = 2
  validation {
    condition     = var.zero_padding >= 1 && var.zero_padding <= 10
    error_message = "zero_padding must be between 1 and 10."
  }
}

variable "start_index" {
  description = "Starting index for numeric suffix (default 1)."
  type        = number
  default     = 1
  validation {
    condition     = var.start_index >= 0
    error_message = "start_index must be >= 0."
  }
}

variable "separator" {
  description = "Separator between prefix and suffix."
  type        = string
  default     = "-"
}

variable "case" {
  description = "Case transform: upper, lower, or none."
  type        = string
  default     = "none"
  validation {
    condition     = contains(["upper", "lower", "none"], var.case)
    error_message = "case must be 'upper', 'lower', or 'none'."
  }
}

variable "distinct" {
  description = "If true, deduplicate the final names list."
  type        = bool
  default     = true
}

variable "max_length" {
  description = "Max length after processing."
  type        = number
  default     = 63
  validation {
    condition     = var.max_length > 0
    error_message = "max_length must be > 0."
  }
}