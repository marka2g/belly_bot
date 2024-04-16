# BellyBot
## [Engineering Assessment](https://github.com/peck/engineering-assessment) - The BellyBot Food Truck App

This app answers the question, "what should we eat for lunch today?" by helping you find the types of foods being served by SF food trucks.
- showcases variety
- allows you to discover new places to eat

---

### Guideline Notes
#### **Production Readiness**
> terraform for project management - tracking issues that make up  milestones
> 
> utilizes containerization to provide environment integrity, scalability, and infrastructure as code to maintain a consistent set of deployable resources
> 
> bash scripts to improve environment integrity amongst a team of developers 
>
#### **Things you would do or do differently given more time**
> implement postgis to add proximity search
> 

---
## Links and References

### [PostGIS Issue](https://github.com/marka2g/belly_bot/issues/9)
> [the docker postgis image doesn't seem to support arm chips](https://registry.hub.docker.com/r/postgis/postgis/)
> 
> [asdf-postgres issue #5 discussing how to install postgis for an asdf postgres install](https://github.com/smashedtoatoms/asdf-postgres/issues/5#issuecomment-2058271908)