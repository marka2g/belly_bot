variable "repository" {
  description = "Name of the GitHub repository."
  type        = string
}

variable "github_owner" {
  description = "GH Owner/Org"
  type        = string
}

variable "status_checks" {
  description = "List of required status checks that must pass."
  type        = list(string)
  default     = []
}