variable "name" {
  description = "Base name of the placement group(s)."
  type        = string
}

variable "type" {
  description = "Type of placement group. Options: spread."
  type        = string
  default     = "spread"
}

variable "labels" {
  description = "Labels for the placement group(s)."
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "Number of placement groups to create."
  type        = number
  default     = 1
}