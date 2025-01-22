variable "stackscript_label" {
  description = "Label for the StackScript"
  type        = string
  default     = "example-stackscript"
}

variable "stackscript_description" {
  description = "Description for the StackScript"
  type        = string
  default     = "An example StackScript"
}

variable "stackscript_script" {
  description = "The script content of the StackScript"
  type        = string
  default     = <<EOF
#!/bin/bash
echo "Hello, World!" > /root/hello.txt
EOF
}

variable "imgs" {
  description = "List of supported images"
  type        = list(string)
  default     = [
    "linode/debian11",
    "linode/ubuntu24.04"
  ]
}
