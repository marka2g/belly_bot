variable "secrets" {
  description = "A map of the belly_bot repo secrets" 
  type = map(string)
}
variable "github_owner" {
  description = "GH Owner: BellyBot Inc." 
  type = string
}
variable "repository" {
  description = "belly_bot repository" 
  type = string
}