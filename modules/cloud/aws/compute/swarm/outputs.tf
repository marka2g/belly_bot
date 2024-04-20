output "ssh_command" { 
  value = "ssh -i ${var.private_key_path} ec2-user@${aws_instance.belly_swarm.public_ip}"
  description = "The SSH command to connect to the instance." 
}