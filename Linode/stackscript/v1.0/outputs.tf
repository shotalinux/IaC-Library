output "stackscript_id" {
  description = "The ID of the created StackScript"
  value       = linode_stackscript.example.id
}

output "stackscript_label" {
  description = "The label of the created StackScript"
  value       = linode_stackscript.example.label
} 
