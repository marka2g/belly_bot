output "ssh_command" { 
  value = "ssh -i ${var.private_key_path} ec2-user@${aws_instance.belly_swarm.public_ip}"
  description = "The SSH command to connect to the instance." 
}

output "private_key" {
  value = local_sensitive_file.private_key.content 
  sensitive = true
  description = "The SSH private key to connect to the instance."
}