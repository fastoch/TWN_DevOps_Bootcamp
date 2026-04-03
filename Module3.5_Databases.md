# Bonus module: Databases (DB)

Applications use databases to persist data.  
Let's see how databases are integrated in the software development process.  

## Database for development

Developers need a database for local development. To set this up, we have two options:
- each dev installs and sets up its own DB on their machine, and connects the application to that local DB
- the DB is hosted remotely and shared between all devs, you just need an endpoint and credentials to connect the application to it

Option 2 is better because you can start coding right away, and already have test data in the DB.  
However, option 1 allows you to play around with the DB without affecting other devs.  

An ideal solution would be to use both options, choosing which one to use depending on the situation.  

## How does your app talk to the DB?

In your application code, 