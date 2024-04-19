resource "github_actions_secret" "main" {
  repository      = var.repository
  for_each        = var.secrets
  secret_name     = each.key
  plaintext_value = each.value
}

provider "github" {
  owner = var.github_owner
}