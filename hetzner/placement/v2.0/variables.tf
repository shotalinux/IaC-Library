variable "namepref" {
  description = "Prefix for naming placement groups. Ignored if nameslist is set."
  type        = string
  default     = null
}

variable "nameslist" {
  description = "Explicit list of placement group names. Overrides namepref/replicas if provided."
  type        = list(string)
  default     = []
}

variable "replicas" {
  description = "Number of placement groups to create (used with namepref)."
  type        = number
  default     = 1
}

variable "suffix_style" {
  description = "Style of suffix for replica naming: 'numeric' or 'alpha'."
  type        = string
  default     = "numeric"
}

variable "zero_padding" {
  description = "Zero-padding width for numeric suffixes (e.g., 2 -> 01, 02)."
  type        = number
  default     = 0
}

variable "type" {
  description = "Type of placement group. Currently only 'spread' is supported."
  type        = string
  default     = "spread"
}

variable "labels" {
  description = "Labels for the placement group."
  type        = map(string)
  default     = {}
}