# BellyBot
## [Engineering Assessment](https://github.com/peck/engineering-assessment) - The BellyBot Food Truck App

This app answers the question, "what should we eat for lunch today?" by helping you find the types of foods being served by SF food trucks.
- showcases variety
- allows you to discover new places to eat

---

### Guideline Notes
#### **Production Readiness**
> This project utilizes:
>> **Elixir `mix release`s** which packages the code and runtime to provide an executable binary for the application to be deployed. 
> 
>> **Docker Containerization (Dockerfile and Compose)** for environment integrity, scalability, and infrastructure as code to maintain a consistent set of deployable resources
>>> add `ENV ERL_FLAGS="+JPperf true"` to Dockerfile
>
>> **CI/CD with Github Actions**
> 
>> **Bash scripts** to improve environment integrity in a remote environment and amongst a team of developers working together on the project. 
>
>> **Terraform** for infrastructure as code, [project management](https://github.com/marka2g/belly_bot/milestones) and [tracking those issues](https://github.com/marka2g/belly_bot/issues) that make up milestones.
>> Follows the Terraform provisioning cycle
>>```mermaid
>>flowchart TD
>>    A(Edit <br> config file) --> B(Execute <br> $ terraform plan)
>>    B --> C(Execute <br>  $ terraform apply) --> A
>>```

#### **Things you would do or do differently given more time**
> implement postgis to add proximity search
> 

---
## Links and References

### [PostGIS Issue](https://github.com/marka2g/belly_bot/issues/9)
> [the docker postgis image doesn't seem to support arm chips](https://registry.hub.docker.com/r/postgis/postgis/)
> 
> [asdf-postgres issue #5 discussing how to install postgis for an asdf postgres install](https://github.com/smashedtoatoms/asdf-postgres/issues/5#issuecomment-2058271908)


---
To start your Phoenix server:

...docker here