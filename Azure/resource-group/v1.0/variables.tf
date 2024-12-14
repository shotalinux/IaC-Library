variable "name" {
  description = "Specifies the name of the Resource Group. Must be unique on your Azure subscription."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
