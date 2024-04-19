# BellyBot
## [Engineering Assessment](https://github.com/peck/engineering-assessment) - The BellyBot Food Truck App

![CI/CD](https://github.com/marka2g/belly_bot/actions/workflows/ci_cd.yml/badge.svg)

This app answers the question, "what's for lunch today?" by listing SF food trucks, their known street location, and the types of foods they serve. The goal is to showcases variety and allow the user to discover new places to eat.

comment on:
> SOPS - symmetric key encryption to allow the sharing of secrets among team members
>
>"confidence" and "ownership" ch 7. "empowering yourself to take responsibility for the code you submit"

### Getting Started Steps

### About The Project
In the last few years, Terraform has become the first tool that I reach for when starting a greenfield project. Although it may seem like more than a few days was spent on this project by viewing the project's [Issues](https://github.com/marka2g/belly_bot/issues) page, I have Terraform to thank for a massive reduction on initial time-consuming tasks.

#### Project Management
I used Terraform to create a [project management scaffold](https://github.com/marka2g/belly_bot/tree/main/modules/integrations/github/project_management) that initializes the project with reasonable [Issues](https://github.com/marka2g/belly_bot/issues), [Labels](https://github.com/marka2g/belly_bot/labels), and [Milestones](https://github.com/marka2g/belly_bot/milestones). I love this because it removes the daunting writers block associated with getting started.

#### CI

#### CD & Production

> ch 7. “Fail early, fail often, but always fail forward.” Using a CD pipeline is crucial for achieving this because the fact that any piece of code will be automatically delivered to production means that you’ll be more careful about what you ship and how you ship it. This will foster your confidence and make you more resilient. It will also encourage you to submit smaller features and babysit a deployment to ensure that it works as expected. Then if a bug arises, you’ll submit a new PR to fix the concrete issue.


#### Production
Terraform was also used to provision a single-node AWS/EC2 Instance/Security Group/VPC/Subnet/AMI production environment that is backed by a [Docker container](https://github.com/users/marka2g/packages/container/package/belly_bot) which is hosted at `ghcr.io`. Yikes, what a mouthful, however, I hope a patterns are obviously stated - building out a version controlled backed infrastructure allows us to replicate an environment that can be repeated and adequately maintained. Infrastructure-as-code has really changed my perspective on the Development and DevOps process. I don't yet claim expertise but am certain that a production-ready solution requires a consistent and dependable foundation of patterns.

#### The BellyBot App
Overall, I spent the least amount of time on the actual `belly_bot` Phoenix app. I did this for a few reasons. First, building an app wth Phoenix Live View and app development in general is the most enjoyable part of the process for me. However, over the years, I've learned that planning ahead and tackling the less fun tasks pay dividends toward the longevity and momentum a the project. When taking time to plan out a path forward, development becomes much more focused and prioritizing issues via milestones allows the team to build more efficiently. In the github repo, you'll notice that about half of the initial issues created have been completed. There are more issues and milestones to add and complete as the project progresses.

> example of team consideration
> in the dockerfile, `ENV ERL_FLAGS="+JPperf true"`
> 


~~#### The Tech Stack~~
