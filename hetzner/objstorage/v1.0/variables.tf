variable "access_key" {
  description = "Access key for Hetzner Object Storage"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret key for Hetzner Object Storage"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region for Hetzner Object Storage (fsn1, nbg1, hel1)"
  type        = string
  default     = "nbg1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

variable "acl" {
  description = "Canned ACL policy for the bucket"
  type        = string
  default     = "private"
}

variable "object_locking" {
  description = "Enable object locking"
  type        = bool
  default     = false
}