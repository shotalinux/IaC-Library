variable "name" {
  description = "Name of the placement group."
  type        = string
}

variable "type" {
  description = "Type of placement group. Options: spread."
  type        = string
  default     = "spread"
}

variable "labels" {
  description = "Labels for the placement group."
  type        = map(string)
  default     = {}
}