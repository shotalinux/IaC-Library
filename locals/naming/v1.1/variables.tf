variable "namepref" {
  description = "Prefix for names when replicas are used."
  type        = string
  default     = null
}

variable "replicas" {
  description = "Number of replicas when using namepref."
  type        = number
  default     = 0
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
}

variable "zero_padding" {
  description = "Number of digits for zero padding in numeric suffix. E.g., 2 -> 01, 02."
  type        = number
  default     = 1
}

variable "start_index" {
  description = "Starting index for numeric suffix (default 1)."
  type        = number
  default     = 1
}