# The BellyBot Food Truck App ![Build Status](https://github.com/marka2g/belly_bot/actions/workflows/ci_cd.yaml/badge.svg)
## [Engineering Assessment for E.L.](https://github.com/peck/engineering-assessment)

This app answers the question, "What's for lunch today?" by providing a list of San Francisco food trucks along with their known street locations and the types of foods they serve. The goal is to showcase a variety of options and help users discover new places to eat.

---

### Running the Code
> You can pull down the repo and run it locally:
>```bash
>$ git clone git@github.com:marka2g/belly_bot.git
>$ cd belly_bot
>
># Run the server with a REPL
>$ iex -S mix phx.server
>```

> And then, seed some Food Truck data:
>```elixir
>iex> BellyBot.GlobalSetup.seed_food_trucks()
>
># check the food truck count
>iex> BellyBot.FoodTrucks.list_food_trucks() |> Enum.count()
>```

---

### Running & Deploying the App
Currently, there are two ways to deploy this app to production:

1. Continuous Delivery → Once a PR is merged into the `main` branch and CI checks run successfully, the composite `actions/deploy/action.yaml` will deploy the app to a docker swarm on AWS.
2. Manually → The `./scripts/deploy.sh` script can also be run with a key file(_available upon request_).
  - the script requires three environment variables to be passed in:
    - `PRIVATE_KEY_PATH` located in the `./environments/production` directory
    - `SOPS_AGE_KEY_FILE` key file
    - `GITHUB_USER`
> example:
>>```bash
>>$ PRIVATE_KEY_PATH=./environments/production/dynamic_private_key.pem \
>>SOPS_AGE_KEY_FILE=./environments/production/key.txt \
>>GITHUB_USER=marka2g \
>>./scripts/deploy.sh
>>```

---

### Development Status & Time Spent
Start by checking the repo's [Milestones Panel](https://github.com/marka2g/belly_bot/milestones), which serves as the perfect starting point. Here, you'll discover various [issues](https://github.com/marka2g/belly_bot/issues) that track the project's progress. 

In my overall allocation of time, the `belly_bot` Phoenix app received the least attention, and there are a few reasons for this. Firstly, I find the process of building an app with Elixir, Phoenix Live View and app development in general to be the most enjoyable. However, I've learned over the years that planning ahead and addressing less enjoyable tasks are crucial for the project's longevity and momentum. Taking the time to chart a clear path forward makes development more focused, and prioritizing issues via milestones enables the team to work and communicate more efficiently.

That said, I've grown fond of Terraform, particularly for greenfield projects. Besides its ability to magically assist with  [provisioning platform resources](https://github.com/marka2g/belly_bot/tree/main/environments/production), I deeply appreciate the [project management](https://github.com/marka2g/belly_bot/tree/main/modules/integrations/github/project_management) tools it provides. Terraform has given me the freedom and confidence to pause, think, and plan before diving into coding, ultimately enhancing the product's quality. Furthermore, it has bolstered my ability to estimate time and prioritize tasks more effectively.

As to the time I spent, the type of development proposed in this assessment, mirrors patterns and development work I've been currently engaged in. Last week was quite busy for me so I had to work when time permitted. Having a healthy set of bootstrapped issues really helped. This project was quite enjoyable; turns out, I too like too eat :-). 
I plan to keep developing on the idea for fun and add more features, such as:
1. [Geographical searching with the PostGIS Postgres extension](https://github.com/marka2g/belly_bot/issues/22)
2. Improve search by [parsing `days_hours`](https://github.com/marka2g/belly_bot/issues/21) and [food_items](https://github.com/marka2g/belly_bot/issues/20) data
3. [Instrumentation](https://github.com/marka2g/belly_bot/milestone/4) with Prometheus and a Grafana dashboard
4. and well, basically develop the UI, and design.

Thank you so much for the awesome idea and the opportunity!

---

### A Rough Sketch of the Technology Stack
### [**Project Management:**](https://github.com/marka2g/belly_bot/milestones)
> → Github Milestones & Issues, provisioned with Terraform
>> _located in this directory [`./modules/cloud/aws/compute/swarm`](https://github.com/marka2g/belly_bot/tree/main/modules/cloud/aws/compute/swarm)_

### [**Application - The BellyBot MVP:**](https://github.com/marka2g/belly_bot/milestone/6)
> → **web**: Elixir/Phoenix Live View
> 
> → **db**: Postgres 16

### [**Platform/Infrastructure:**](https://github.com/marka2g/belly_bot/milestone/2)
> → Single-node Docker Swarm manages an AWS/EC2 Instance/Security Group/VPC/Subnet, provisioned with Terraform.
>> _located in this directory [`./modules/integrations/github`](https://github.com/marka2g/belly_bot/tree/main/modules/integrations/github)_
>
> → Packer with an Amazon Machine(Linux) Instance with Docker preinstalled, provisioned with Terraform.
>> _located in this directory [`./packer`](https://github.com/marka2g/belly_bot/tree/main/packer)_

### [**Continuous Integration/ Continuous Deployment**](https://github.com/marka2g/belly_bot/milestone/1?closed=1)
> → [Encrypted Secrets with SOPS](https://github.com/marka2g/belly_bot/commit/0c25f01a605bc7bcb18bde4898ba0959219f2d66), provisioned with Terraform
>> _located in this directory [`./modules/integrations/github/secrets`](https://github.com/marka2g/belly_bot/tree/main/modules/integrations/github/secrets)_

---

### EC2 Production Status
Currently, an EC2 instance is running on AWS, and at the time of writing, it is live at this address: http://ec2-54-193-68-139.us-west-1.compute.amazonaws.com:4000. I submitted an [issue here](https://github.com/marka2g/belly_bot/issues/36) to investigate why the Docker Swarm EC2 instance and volume are not communicating. 

