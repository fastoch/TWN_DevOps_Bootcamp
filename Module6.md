# 6. Artifact Repository Management with Nexus

## 0. Module Overview

In this module, we'll learn about artifact repositories and artifact repository managers.  

We'll set up one of the most popular artifact repo managers, Nexus, on a cloud server on DigitalOcean.  
We will then go through the most important features of Nexus:
- how to manage users and their permissions
- how to create different repositories for different artifact types
- the difference between components and assets

After setting up Nexus, we will publish a .jar file (Java app artifact) to a Maven repo on Nexus.  
First using Maven, and then using Gradle as a build tool.  

We'll also learn how to configure cleanup policies for our repositories, as well as how to talk to Nexus REST API.  

## 1. Intro to Artifact Repository Management

### Artifact Repository 

**Artifacts** are applications built into a single shareable and easily movable file.  
They can have different formats based on the language and the tools we use: .jar, .war, .zip, .tar, etc.  

An **artifact repository** = storage of those artifacts  
There are several types of artifact repositories, one for each artifact type.  

If your company builds different applications, one in Python and another one in Java, they'll need separate artifact repositories, because the artifact type will be different.  

### Artifact Repository Manager

Fortunately, we don't have to use multiple artifact repository managers depending on the artifact type.  
We can use a single artifact repository manager for all our artifact types.  

>[!important]
>An artifact repository is often abbreviated as **artifactory**.  

One of the most popular artifact repository managers is **Nexus**.  
Nexus acts as a central hub for storing and fetching all yourartifacts.  

**Nexus** is an artifactory manager that you would use internally in a company, it's for **private** use.  

There are also **public** artifactory managers, such as :
- Docker Hub, 
- Maven Central, 
- npm registry, 
- PyPI, 
- etc.  

### Private repo hosting AND Public repo proxy

On Nexus, you can host your own private repositories. It can be a Maven repo, a Dockerfile repo, an npm repo, etc.  
This way, you can share the application artifacts that are built within your company.  

But you can also set up a **proxy** on Nexus, and then fetch artifacts from **public** repositories through that proxy.  

To make it clear:
- When you deploy a private artifact, Nexus stores it in its internal storage
- When you fetch an artifact, Nexus either:
  - serves it from one of your private repositories, 
  - or routes/proxies the request to some upstream public repository, and then **caches** the response

This versatility makes Nexus very convenient because it allows us to manage all our artifacts in one spot.  

Nexus is available in two forms: open-source and commercial.  

Here's a sample of supported formats on Nexus:  
![Nexus supported formats](./assets/Nexus_formats.png)  

### Features of Artifactory Managers like Nexus

- **integrate with LDAP**: simplifies configuration of access management for big teams 
- **flexible and powerful REST API** for integration with other tools
- **backup and restore**: managing storage and data recovery
- **metadata tagging**: labelling and tagging artifacts
- **Cleanup policies**: automatically deleting old artifacts or those matching specific criteria
- **Search functionality**: searching for artifacts by name, type, and other criteria
- **user token support**: for system user authentication (non-human users)

### About the REST API

Nexus is not designed for manual management.  
It's going to be part of the whole **build automation** process and **CI/CD pipeline**.  
![CI_CD_pipeline](./assets/CI_CD.png)  

For example, when **Jenkins** builds the artifact, it needs to push it to **Nexus**.  
So we need integration between Jenkins and Nexus.  

And for automated delivery/deployment, we need to fetch artifacts from Nexus to the deployment server.  
We do that by using some script or some automated tool, which also requires integration with Nexus.  

Having a **REST endpoint** for managing artifacts is crucial because it literally sits in the **middle** of our whole 
**CI/CD pipeline**.  

>[!important]
>a REST endpoint is the URL + HTTP method combination that defines how you read, create, update, or delete data in a REST API  

### About the backup and restore feature

Nexus has its own storage mechanism configured by default.  
But it's also important to configure easy backup and restore, especially when you have a large number of artifacts.  

---

## 2. Install and run Nexus on a cloud server

>[!important]
>DO NOT use a VM with less resources than 4GB RAM / 2 CPUs, as you will encounter performance issues if you do so.  



