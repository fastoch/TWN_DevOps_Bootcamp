# 4. Build Tools & Package Managers (module 4/16)

## Module Overview

These are technologies that are used in software development process.  
And, as part of the application building process, something that DevOps engineers should understand.  

We will see what role these tools have and how to use them.  
This is going to be a general overview of these technologies, not a deep dive into the details.  

To showcase the comparison between these tools and explain the different concepts, we will see specific 
examples with two popular programming languages: Java and JavaScript.  

For Java, we'll use Gradle and Maven.  
For JS, we will look at npm.  

So we will learn how to **build** and **package** Java and JavaScript applications into **artifacts** using these tools.  
As well as how to add and install application dependencies, and so on...  

Links to the projects used in this module are:
- Java-app: https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-app
- Java-maven-app: https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-maven-app
- React-nodejs-app: https://github.com/techworld-with-nana/react-nodejs-example

## Introduction to Build Tools

When you're done implementing an application, it must be made available somewhere for the end users.  
This is what we call **deployment**.  

The application code that is living in a repository must end up on a production server and run there.  
How do we deploy a software application?  

- We need to package the application into a **single movable file**.  
- And then we can move that file to a server and run it there.  

That single packaged file is called an **application artifact**.  
Packaging an application into an artifact is called **building** it.  

This building/packaging process involves:
- **compiling** the application code
- **compressing** the code from hundreds of files into one file
- make it **smaller** so that it can be easily transferred over the network

After the artifact is built, we don't just directly copy it to the server.  
We keep it in a storage in case we need to deploy it multiple times.  

That storage where we keep the artifact once we built it is called an **artifact repository**.  
Examples of artifact repositories are Nexus, or JFrog Artifactory, etc.  

Every time you release a new version of your application, or you want to make a new version available for testers, 
you create an artifact, you save it in the artifact repository, and deploy it on the server.  

Depending on the programming language you use for your application, the artifact file format will be different.  
For a Java application, the artifact will be a JAR or WAR file (includes whole code + dependencies). 

## Install Build Tools

Before moving on to the demos, we need to install a couple of tools.  

We will use build tools to build a **Java application**. For that, we need to install: 
- Java SDK (Software Development Kit)
- Maven (build tool for Java applications)
- Gradle (alternative to Maven)  

Finally, we'll build a **JavaScript application**, which requires installing:
- Node.js (JavaScript runtime)
- npm (Node Package Manager)

It's also important to have a good **code editor** to work with.  
Most popular being IntelliJ IDEA and Visual Studio Code.  
I'll be using VSCodium, which is the free and open-source version of Visual Studio Code.  

## Installation guide for Linux (Fedora 43)

- install your favorite code editor or IDE (I already have VSCodium)
- install Git: `git version` to check if already installed, `sudo dnf install git` if not

### Clone and open Java Maven project in VSCodium

- From the CLI, `cd` into the folder where you want to clone the project
- run `git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-maven-app.git`
