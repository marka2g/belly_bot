# in environments/production/main.tf

module "swarm" {
  source = "../../modules/cloud/aws/compute/swarm"
  # instantiate the variable pem key var so that 
  # SSH key is saved inside environments/production
  private_key_path = "${path.module}/dynamic_private_key.pem"
}

module "repository_secrets" {
  source = "../../modules/integrations/github/secrets" 
  secrets = {
    "PRIVATE_KEY" = module.swarm.private_key, 
    "AWS_ACCESS_KEY_ID" = var.aws_access_key_id, 
    "AWS_SECRET_ACCESS_KEY" = var.aws_secret_access_key,
    "AGE_KEY" = var.age_key,
    "GH_PAT" = var.gh_pat
  }
  repository  = "belly_bot"
  github_owner = "marka2g"
}

# can also run terraform output
output "swarm_ssh_command" {
  value = module.swarm.ssh_command
}