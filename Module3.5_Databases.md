# Bonus module: Databases (DB)

Applications use databases to persist data.  
Let's see how databases are integrated in the software development process.  

## Database in development process

Developers need a database for local development. To set this up, we have two options:
- each dev installs and sets up its own DB on their machine, and connects the application to that DB
- the DB is hosted remotely and shared between all devs, you need an endpoint and credentials to connect the application to it

Option 2 is better because you can start coding right away, and already have test data in the DB.  
However, option 1 allows you to play around with the DB without affecting other devs.  

An ideal solution would be to use both options, choosing which one to use depending on the situation.  

### How does your app talk to the DB?

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

### Databases in production

Before deploying an application, we need to install and configure the DB for the production environment.  
That DB can run on the same server where the app will run, or on a separately managed server.  

Developers themselves do not usually manage the databases.  
The DB is usually managed by a DBA (DB administrator) or a DevOps engineer.  

As a DevOps engineer, you need to know how to install and configure a DB.  
You also need to know how to manage them:
- replicating the DB to another server (failover)
- doing regular backups
- restore the DB from a backup

Of course, you also need to know how to connect an application to a DB.  

---

## Database Types

### Key-Value Databases

Popular ones are **Redis**, **Memcached**, and **etcd** from Kubernetes.  
- Each key-value pair is like a JavaScript object
- every key is unique and points to a specific value
- you can write data using key-value pair
- you can read the data using the key

In key-value DBs, the data model is very simple, there are no joins, no relationships.  

These databases are **very fast**, they store their data in memory (RAM), unlike most traditional DBs which persist data 
on disk‑based storage, such as hard‑disk drives (HDDs) or solid‑state drives (SSDs).  

But they offer limited storage capacity, and are not suited for long-term data persistence.  

They are used for: 
- in-memory caching, to make your application faster
- as a message queue, for some message broker applications

Key-value DBs are mostly used as cache DBs on top of a primary long-term storage DB, such as MongoDB or MySQL.

### Wide-Column Databases

Key-Value DBs are pretty limited in their schema.  
If you need to store more complex data, Column DBs are a good alternative to key-value DBs.  
Popular implementations of Column DBs are **Cassandra**, and **Apache HBASE**.  

They also use keys, but each key is divided into multiple columns.  
Unlike relational databases, they don't have a predefined schema = **schema-less**.  

You can have any number of colums of any data type.  
Which means they can handle unstructured data with a dynamic number of columns per key.  

- It's also very scalable and can be easily distributed across mutliple servers.  
- Its query language is similar to SQL but much simpler.  
- There are no joins or some similar complex concepts from relational databases.

In short, they handle more complex data types than key-value DBs, but are limited when compared to relational DBs.  

The main use case for Wide-Column DBs is handling large amounts of unstructured data.  
They're mostly used for **time-series** data, like records from IoT devices (smart cards and sensors).  
Just like key-value DBs, they should be used on top of a primary DB.  

### Document-oriented Databases

They are more versatile, much more general purpose than the two previous types of DBs.  
Popular implementations are **MongoDB**, **CouchDB**, and **DynamoDB**.  

- What we call **Documents** are "containers" for key-value pairs.  
- You can have multiple key-value pairs in a document.  
- You can also have multiple documents in a **collection**.  
- Collections can be organized into a relational hierarchy

This type of DB is also used to store **unstructured data**, they are **schema-less**.  
This mimics a little bit the relational DB model, but still you have no joins here.  

Compared to relational DB, it's slower in updates because the data can be nested within the hierarchy of documents.  

But faster to read the data because that data is already structured as a collection of all related information into one document.  
No need to put pieces of data together by reading multiple tables like we would do in a relational DB.  

Some of the uses cases for Document DB can be using it for mobile applications, for games, for Content Management Systems (CMS), 
and many more.  

Unlike key-value and wide-column DBs, Document DBs **can be used as a primary DB** for your application data.  

### Relational Databases

For use cases where pieces of data are interconnected and related, you need a relational DB.  
Popular implementations are **MySQL** and **PostgreSQL**.  

Relations DBs are the most widely used and most popular.  
They're used to store **structured data**, which means they have a **predefined schema**.  
You cannot start adding data before you define the schema and the data type.  

And because it's used for structured data, its query format is **SQL** = Structured Query Language.  

In a relational DB, the data is stored in **tables** which have **rows** and **columns**.  
Each entry (row) in a table has a unique ID called a **primary key**.  
It can also have a **foreign key**, which points to the primary key of another table.  

By using foreign keys, you can define relationships between tables.  
And we also avoid repeating data in multiple tables.  

---

### Relational DBs are ACID-compliant

Relational SQL databases are **ACID**-compliant:
- Atomicity
- Consistency
- Isolation
- Durability

That means that whenever there's a transaction in a relational DB, data consistency and validity is guaranteed.  
No matter what technical issues happen during that transaction.  

For example, if a transaction is updating values in 10 different tables, and a disruption happens after 5 tables are updated, 
no changes will be made at all. And that is achieved by a DB mechanism that prepares all the changes, and commits all of them 
at once if everything is okay, or rollbacks if something goes wrong.  

Either all changes get applied or none. There cannot be partial changes.  

---

### Relational DBs and Scalability

The counterpart of being ACID-compliant is that SQL databases are very difficult to **scale**.  
Which means that running SQL relational DBs in a **distributed environment** like a K8s cluster can be **challenging**.  

However, there are modern SQL DBs such as **CockroachDB** that are specifically designed to solve that **scalability** issue 
and run easily on modern cloud-hosted infrastructures (which are distributed environments).  
https://www.cockroachlabs.com/docs/stable/  

---

### SQL vs NoSQL Databases

Because SQL has been so popular till now, the alternative solutions to SQL are categorized as "NoSQL".  
Among the NoSQL DBs, you'll find key-value DBs, wide-column DBs, document-oriented DBs, and Graph DBs.  

The main difference between SQL and NoSQL DBs is that SQL DBs are **relational** while NoSQL ones are **non-relational**.  

### Graph Databases

For too complex many-to-many relations, which in SQL requires multiple joins or an intermediary table to connect such 
many-to-many relations, there is an alternative which is Graph DBs.  


