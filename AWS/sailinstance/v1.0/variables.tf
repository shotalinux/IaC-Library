# variables.tf

variable "instance_name" {
  description = "Name of the Lightsail instance"
}

variable "availability_zone" {
  description = "Availability zone for the Lightsail instance"
}

variable "blueprint_id" {
  description = "Blueprint ID for the Lightsail instance"
}

variable "size_id" {
  description = "Bundle - size of the instance - ID for the Lightsail instance"
}

variable "tags" {
  description = "Tags for the Lightsail instance"
  type        = map(string)
}

variable "keypair" {
  description = "Public key file name in the aws custom keys for ssh connection"
}

variable "script" {
  description = "Provision commands or other one line bash script"
  default = "echo Hello"
}
