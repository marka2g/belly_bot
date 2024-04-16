terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

locals {
  repository_name = "belly_bot"
  github_owner = "marka2g"
}

resource "github_repository" "belly_bot" {
  name                   = local.repository_name
  description            = "Engineering Challenge - The BellyBot Food Truck App"
  visibility             = "private"
  has_issues             = true
  auto_init              = true
  gitignore_template     = "Terraform"
  delete_branch_on_merge = true
}

variable "milestones" {
  type = map(object({
    title       = string
    due_date    = string
    description = string
  }))
  description = "Milestones, the biggest unit of deliverable."
}

resource "github_repository_milestone" "epics" {
  for_each    = var.milestones
  owner       = local.github_owner
  repository  = local.repository_name
  title       = each.value.title
  description = replace(each.value.description, "\n", " ")
  due_date    = each.value.due_date
  depends_on = [github_repository.belly_bot]
}

variable "labels" {
  type = map(object({
    name  = string
    color = string
    url = string
  }))
  description = "The labels to tag the issues."
}

resource "github_issue_label" "issues_labels" {
  for_each   = var.labels
  repository = local.repository_name
  name       = each.value.name
  color      = each.value.color
  depends_on = [github_repository.belly_bot]
}

variable "issues" {
  type = list(object({
    title     = string
    body      = string
    labels    = list(string)
    milestone = string
  }))
}

resource "github_issue" "tasks" {
  count      = length(var.issues)
  repository = github_repository.belly_bot.name
  title      = var.issues[count.index].title
  body       = var.issues[count.index].body
  milestone_number = github_repository_milestone.epics[
    var.issues[count.index].milestone
  ].number
  labels = [for lbl in var.issues[count.index].labels :
    github_issue_label.issues_labels[lbl].name
  ]
}

provider "github" {
  owner = local.github_owner
}