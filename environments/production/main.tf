# in environments/production/main.tf

module "swarm" {
  source = "../../modules/cloud/aws/compute/swarm"
  # instantiate the variable pem key var so that 
  # SSH key is saved inside environments/production
  private_key_path = "${path.module}/dynamic_private_key.pem"
}

# can also run terraform output
output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}