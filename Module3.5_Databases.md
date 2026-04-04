# Bonus module: Databases (DB)

Applications use databases to persist data.  
Let's see how databases are integrated in the software development process.  

## Database for development

Developers need a database for local development. To set this up, we have two options:
- each dev installs and sets up its own DB on their machine, and connects the application to that DB
- the DB is hosted remotely and shared between all devs, you need an endpoint and credentials to connect the application to it

Option 2 is better because you can start coding right away, and already have test data in the DB.  
However, option 1 allows you to play around with the DB without affecting other devs.  

An ideal solution would be to use both options, choosing which one to use depending on the situation.  

## How does your app talk to the DB?

Each programming language has libraries/modules for DB connection.  
And for each type of database, there's a different library/module.  

For example, there's a library that lets Java talk to MySQL, another library lets Java talk to MongoDB, etc.  

Devs import these libraries into their code and implement the DB connection logic.  
They tell the library the name of the DB, where to connect to that DB (endpoint), and what the authentication credentials are.  

So, if you have a local DB and a remote DB for development purposes, you need to tell the library which one your 
app should talk to, that's done by providing the **database endpoint** or **database URL**.  
You also need to provide **credentials** so your app can authenticate with the DB.  

### Configuring instead of hard-coding

The DB endpoint and credentials should not be hard-coded.  
Instead, they should be provided as **environment variables**.  

That way, if you want to switch the DB endpoint or credentials, you don't need to change the code.  
You just set the desired values in the config file that contains your environment variables (env vars).  

Usually, we have 3 DB instances, one for each environment: development DB, staging DB, and production DB.  
Depending on where your app is running, it will connect to a different DB.  

Of course, environment variables and their values shouldn't be accessible in your Git repo.  
The file where you declare them should be kept out of version control > add it to your `.gitignore` file.  

For security reasons, we inject our environment variables at runtime, when the application starts up.  
In the application code, we just specify which config file or properties file to load.  

For instance, in a Java/Sprint application, we define a Spring **properties file** for each environment.  
In a config folder, we would have 3 files: `application-dev.yml`, `application-staging.yml`, and `application-prod.yml`.  
In each properties file, we define the values for the targeted DB enpoint and the DB user credentials.  

### One place for all environment variables

Depending on the programming language, there's a specific folder in our project where we put a properties/config file.  

In this config file, we define all our env vars along with other config values, not only our DB access values.  
For example, we can define the logging level, the port on which our app will listen, etc.  

A complex modern application is made of multiple microservices, which are smallest applications.  
Those microservices need to communicate with each other, through some kind of a service bus, or maybe a messaging application.  
All of these services also have endpoints and credentials, which are also defined in that same config file.  

This is practical to have all of these configuration elements defined in one place, because we know exactly where to look for 
when we need to change some value.  
