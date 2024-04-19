output "private_key" {
  value = local_sensitive_file.private_key.content 
  sensitive = true
  description = "The SSH private key to connect to the instance."
}