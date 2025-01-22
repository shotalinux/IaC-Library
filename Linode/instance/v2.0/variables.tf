variable "names" {
  type    = list(string)
  default = []  # Example list of instance names
}

variable "root_password" {
  description = "The root password for the Linode instance."
  type        = string
  default     = ""
}

variable "img" {
  description = "The image for the Linode instance."
  type        = string
  default     = "linode/ubuntu20.04"
}

variable "region" {
  description = "The region for the Linode instance."
  type        = string
  default     = "fr-par"
}

variable "instance_type" {
  description = "The type of the Linode instance."
  type        = string
  default     = "g6-nanode-1"
}

variable "tags" {
  description = "Tags for the Linode instance."
  type        = list(string)
  default     = ["default", "example"]
}

variable "ssh_key_label" {
  description = "SSH key label for the Linode instance."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxIBT7h8KFR2u3foN15nvfEkyB8g6pU8BVysErG7PyN ubuntu@ip-172-26-0-132"
}

variable "instance_count" {
  description = "Number of instances to create."
  type        = number
  default     = 1  # Default value, adjust as needed
}
