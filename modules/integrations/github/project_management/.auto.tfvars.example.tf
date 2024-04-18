milestones = {
  "infra" = {
    title       = "Infra"
    due_date    = "2024-05-19"
    description = <<EOT
All the deliverables related to infrastructure, such as, building the application 
(e.g Dockerfile) provisioning AWS, the local environment and the base AMI with Packer.
EOT
  },
  "ci-cd" = {
    title       = "CI/CD"
    due_date    = "2024-05-19"
    description = <<EOT
All deliverables that have to do with GitHub Action workflows that will 
perform the basic checks for an Elixir application. It will also build the 
Docker image and pull the latest images in production.
EOT
  },
  "bellybot-mvp" = {
    title       = "BellyBot MVP"
    due_date    = "2024-05-24"
    description = <<EOT
All deliverables that have to do with delivering an MVP for the BellyBot App.
EOT
  },
  "instrumentation" = {
    title       = "Instrumentation"
    due_date    = "2024-06-19"
    description = <<EOT
All deliverables that have to do with the addition of basic instrumentation 
and BEAM specific metrics for your application. Any task(s) related to 
instrumentation (independently of which part of the stack they relate to) 
will be included in this milestone.
EOT
  },
  "docs" = {
    title       = "Documentation"
    due_date    = "2024-06-28"
    description = <<EOT
All documentation for Terraform, Elixir, Packer and others and will 
converge with CI when needed.
EOT
  },
  "other" = {
    title       = "Other"
    due_date    = ""
    description = <<EOT
All issues that do not fit in any of the other milestones - a way to track any 
uncategorized tasks.
EOT
  }
}

labels = {
  "milestone-infra"= {
    name="Milestone:Infra"
    color="F20089"
    url=""
  },
  "milestone-ci-cd"= {
    name="Milestone:CI-CD"
    color="FAFF00"
    url=""
  },
  "milestone-bellybot"= {
    name="Milestone:BellyBot"
    color="04e762"
    url=""
  },
  "milestone-instruments"= {
    name="Milestone:Instruments"
    color="89fc00"
    url=""
  },
  "milestone-docs"= {
    name="Milestone:Docs"
    color="ffb800"
    url=""
  },
  "milestone-other"= {
    name="Milestone:Other"
    color="dc0073"
    url=""
  },
  "tech-asdf"= {
    name="Tech:ASDF"
    color="3e1f47"
    url=""
  },
  "tech-pg"= {
    name="Tech:Postgres"
    color="0466c8"
    url=""
  },
  "tech-postgis"= {
    name="Tech:PostGIS"
    color="42a5f5"
    url=""
  },
  "tech-docker"= {
    name="Tech:Docker"
    color="4895EF"
    url=""
  },
  "dockerfile"= {
    name="Dockerfile"
    color="4CC9F0"
    url=""
  },
  "tech-elixir"= {
    name="Tech:Elixir"
    color="560BAD"
    url=""
  },
  "tech-gha"= {
    name="Tech:GHA"
    color="66FE68"
    url=""
  },
  "tech-docker-compose"= {
    name="Tech:Docker-Compose"
    color="2cc99a"
    url=""
  },
  "tech-packer"= {
    name="Tech:Packer"
    color="3F37C9"
    url=""
  },
  "tech-terraform"= {
    name="Tech:Terraform"
    color="3A0CA3"
    url=""
  },
  "tech-sops"= {
    name="Tech:SOPS"
    color="ff0a54"
    url="https://github.com/getsops/sops"
  },
  "tech-vault"= {
    name="Tech:VAULT"
    color="ffd814"
    url="https://www.vaultproject.io/"
  },
  "bug" = {
    name="Bug"
    color="e01e37"
    url=""
  },
  "secrets"= {
    name="Secrets"
    color="F9D0C4"
    url=""
  },
  "env-aws"= {
    name="Env:AWS"
    color="f9b939"
    url=""
  },
  "env-local"= {
    name="Env:Local"
    color="FFFEFF"
    url=""
  }
}

issues = [
  {
    title     = "Implement the Builder Stage in Dockerfile"
    body      = <<EOT
The builder stage packages all the tools and compile-time dependencies for
your application. A mix release will be copied in the
running stage.
EOT
    labels    = ["milestone-infra", "dockerfile"]
    milestone = "infra"
  },
  {
    title     = "Implement the Runner Stage Dockerfile"
    body      = <<EOT
This stage copies the release built in the builder stage and uses it as the
entrypoint of your Docker image with the minimum system requirement to run
it.
EOT
    labels    = ["milestone-infra", "dockerfile"]
    milestone = "infra"
  },
  {
    title     = "Implement the BellyBot Phoenix Live View MVP App"
    body      = <<EOT
Build out an MVP Phoenix Live View App.
EOT
    labels    = ["milestone-bellybot", "tech-elixir", "tech-pg", "tech-postgis"]
    milestone = "bellybot-mvp"
  },
  {
    title     = "Install Postgis for the M1 ARM Architecture"
    body      = <<EOT
The PostGIS adds storing, indexing, and querying geospatial data support to Postgres. 
Currently, there is a blocker on ARM chips which is preventing an asdf Postgres installation 
from creating a PostGIS extention.
EOT
    labels    = ["milestone-infra", "env-local", "bug", "tech-pg", "tech-postgis", "tech-asdf"]
    milestone = "infra"
  },
  {
    title     = "Elixir Integration Pipelines"
    body      = <<EOT
Implement a CI pipeline that includes all of the necessary steps when
delivering an Elixir application: code compilation, dependency caching,
testing, code formatting, an unused dependency check.
EOT
    labels    = ["milestone-ci-cd", "tech-elixir"]
    milestone = "ci-cd"
  },
  {
    title     = "Push Docker Image to GitHub Registry for CI/CD Pipeline"
    body      = <<EOT
Automate the pushing of your Docker image to the GitHub Docker registry if
your CI pipeline passes. Authentication with the registry is required before 
being able to push. You should create three tags for your Docker image: one 
matching the commit it refers to, one matching the PR number (if present), 
and other that is "latest".
EOT
    labels    = ["milestone-ci-cd", "tech-docker"]
    milestone = "ci-cd"
  },
  {
    title     = "Create a Continuous Deployment Pipeline"
    body      = <<EOT
Add a new GitHub action to your CI/CD pipeline that automatically deploys
your Phoenix Live View application any time any code is merged into the main
branch of your repository. This action should use the build tags that are
created in the CI pipeline.
EOT
    labels    = ["milestone-ci-cd", "tech-gha", "secrets", "tech-sops"]
    milestone = "ci-cd"
  },
  {
    title     = "Create a Docker Compose file"
    body      = <<EOT
Create a Docker Compose file that includes a PostgreSQL database and your
Phoenix Live View application.
EOT
    labels    = ["milestone-infra", "tech-docker-compose", "env-local"]
    milestone = "infra"
  },
  {
    title     = "Hide Sensitive Data Using Docker Secrets"
    body      = <<EOT
Use Docker secrets to hide the values to the following variables in your
Docker Compose file: DATABASE_URL, POSTGRES_PASSWORD, and SECRET_KEY_BASE.
EOT
    labels    = ["milestone-ci-cd", "tech-gha", "secrets", "tech-sops", "tech-vault"]
    milestone = "ci-cd"
  },
  {
    title     = "Create Production ENV in AWS for a single-node"
    body      = <<EOT
Add all of the AWS resources that will allow you to deploy your application
to a remote single-node to your Terraform configuration. (Making the
resources support a multi-node will be in another task). Required: an EC2 
instance, a VPC, a security group, and an SSH key pair.
EOT
    labels    = ["milestone-infra", "tech-terraform", "env-aws"]
    milestone = "infra"
  },
  {
    title     = "Create the EC2 AMI (Amazon Machine Image)"
    body      = <<EOT
Use Packer to create a custom AMI for your EC2 instances and then link it 
to your existing AWS Terraform infrastructure. This AMI should pre-install 
Docker and netcat.
EOT
    labels    = ["milestone-infra", "tech-packer", "env-aws"]
    milestone = "infra"
  },
  {
    title     = "Implement Automatic Rollback upon Failed Deployments"
    body      = <<EOT
Update the deployment keys of your Phoenix Live View application so that
it automatically rolls back to a previous version if the image you want
to deploy does not start properly.
EOT
    labels    = ["milestone-infra", "tech-docker"]
    milestone = "infra"
  },
  {
    title     = "Update Terraform Configuration for a multi-node swarm"
    body      = <<EOT
Revise your Terraform configuration so that it can support a multi-node
swarm. To do this, create more than one EC2 instance and distribute it
across 3 availibility zones.
EOT
    labels    = ["milestone-infra", "tech-terraform", "env-aws"]
    milestone = "infra"
  },
  {
    title     = "Make Elixir App Part of a Distributed Erlang Cluster"
    body      = <<EOT
Make the different instances of your Phoenix Live View Application form part
of a distributed Erlang cluster. Do this using the libcluster library after
you start the application as an Erlang node.
EOT
    labels    = ["milestone-infra", "tech-elixir"]
    milestone = "infra"
  },
  {
    title     = "Make the Elixir App Autoscale"
    body      = <<EOT
Adapt your AWS Terraform configuration to use an Auto Scaling Group so that
your Elixir application scales up/down depending on the average CPU usage of
the EC2 intances in that group.
EOT
    labels    = ["milestone-infra", "tech-terraform", "env-aws"]
    milestone = "infra"
  },
  {
    title     = "Implement Basic Instrumentation"
    body      = <<EOT
Use Loki, Promtail agent to collect the logs for your Docker containers and
Grafana to display them. Then use Prometheus/PromEx to collect the
metrics exposed by the main libraries used in an Elixir application.
EOT
    labels    = ["milestone-instruments", "tech-docker", "tech-elixir"]
    milestone = "instrumentation"
  },
  {
    title     = "Create A CPU Alert For Your Application"
    body      = <<EOT
Create an alert so that you are notified any time the average CPU of your
Elixir applications reaches above 50%.
EOT
    labels    = ["milestone-instruments", "tech-elixir"]
    milestone = "instrumentation"
  }
]