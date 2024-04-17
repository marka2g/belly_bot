# BellyBot
## [Engineering Assessment](https://github.com/peck/engineering-assessment) - The BellyBot Food Truck App

What's for lunch?

This app answers the question, "what should we eat for lunch today?" by helping you find the types of foods being served by SF food trucks.
- showcases variety
- allows you to discover new places to eat

---
-> MAKE REPO PUBLIC

The [github issues page](https://github.com/marka2g/belly_bot/issues?q=+) for this repo has a story to tell. 

-> reorganize milestones to adhere to a versioned approach, i.e. "pre 1.0"

-> discuss mvp issue -> discuss dependencies/ trade offs with cursor pagination & spent most of the time planning.

-> Milestones link
  -> issues link


- discuss Project management with terrform -> link to Milestones and issues and relate it to time constraints

- make issues that relate to the additions i want to add.
  - [add daily background oban tast](https://github.com/marka2g/belly_bot/issues/19)
  - [implement postgis to add proximity search](https://github.com/marka2g/belly_bot/issues/22)
  - [improve the parsing of `food_items` string](https://github.com/marka2g/belly_bot/issues/20)
  - [improve the parsing of `day_hours` string -> no clear pattern](https://github.com/marka2g/belly_bot/issues/21)

---
Dockerfile -> highlight steps
- building multi arch with QEMU
- seeding data -> `pg_isready` 

Compose -> highlight steps





---




I initially wanted to provide proximity searching with Postgres/PostGIS but ran into a technical issue that was burning down the clock. So, I time-boxed and [wrote an issue to pivot](https://github.com/marka2g/belly_bot/issues/9) to keep moving. 

---



This app answers the question, "what should we eat for lunch today?" by helping you find the types of foods being served by SF food trucks.
- showcases variety
- allows you to discover new places to eat

---

although much of the initial code added to this repo was boilerplate, it's important to highlight the parts in isolation.
...


---


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
>
> -> MAKE REPO PUBLIC
> 
> add Oban to schedule a Req call to data.sfgov.org for a daily refresh of the food truck data
> 
> implement postgis to add proximity search
>> want to get to: `point: %Geo.Point{coordinates: {truck.lng, truck.lat}, srid: 4326},` 
> 
> improve food search
> 
> improve the parsing of `food_items` string
>> add catagories to for food items to improve search
> 
> improve the parsing of `day_hours` string -> no clear pattern

---
To start your Phoenix server:

...docker here