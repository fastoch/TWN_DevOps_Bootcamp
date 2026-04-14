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
- Java-Maven-App: https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-maven-app
- Java-Gradle-App: https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-app
- React-NodeJS-App: https://github.com/techworld-with-nana/react-nodejs-example

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
- JDK (Java Development Kit)
- Maven (build tool for Java applications)
- Gradle (alternative to Maven)  

Finally, we'll build a **JavaScript application**, which requires installing:
- Node.js (JavaScript runtime)
- npm (Node Package Manager)

It's also important to have a good **code editor** to work with.  
Most popular being IntelliJ IDEA and Visual Studio Code.  
I'll be using VSCodium, which is the free and open-source version of Visual Studio Code.  

## Installation guide for Linux (Fedora 43)

### Dev tools

- install your favorite code editor or IDE (I already have VSCodium)
- install Git: `git version` to check if already installed, `sudo dnf install git` if not

IDE = Integrated Development Environment

### Clone and open Java Maven project in VSCodium

- From the CLI, `cd` into the folder where you want to clone the project
- run `git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-maven-app.git`
- open the project in VSCodium or run `cd java-maven-app` and then `code .`

### Install JDK

JDK = Java Development Kit

- from the CLI, check OpenJDK version: `java --version`
- if you don't have OpenJDK installed, run `sudo dnf install java`

### Install Maven

Maven is a build automation and project‑management tool, originally created for Java projects but now used for other languages as well.  

In practice it’s the machinery that compiles your code, runs tests, packages the result (like a JAR or WAR), 
and manages dependencies for you.  

Maven requires a JDK to be installed. Once you've installed the JDK, you can install Maven:
- from the CLI, `mvn -version` or `mvn -v` to check if Maven is already installed
- if you don't have Maven installed, run `sudo dnf install maven`

>[!note]  
>No need to add the `--ignore-dependencies` flag when using the `dnf` package manager.  
>It's not recommended on a modern Fedora system; use dnf’s dependency resolver instead.

### Build your Java-Maven application

Once you have JDK and Maven installed, `cd` into the project folder and run `mvn package`.  
This will build the application and package it into a JAR file.  
If all goes well, you should see a "**BUILD SUCCESS**" message.  

### Setting up Gradle project

Now that we've set up a Java Maven project, let's see how to set up a Java Gradle project.  
Since Java (openJDK) is already installed, we just need to install Gradle.  

Fedora's standard repos don't package Gradle due to its complexity as a Java-based build tool with frequent upstream releases, dependency management needs, and potential licensing/maintenance overhead for distro packagers.  
Searches like `dnf search gradle` typically return no matches.  

Recommended alternatives for Fedora are:
- manual binary install
- SDKMAN

Manual binary install:
```bash
# download latest version of Gradle binary
wget https://services.gradle.org/distributions/gradle-9.4.1-bin.zip -P /tmp
# unzip it to /opt
sudo unzip /tmp/gradle-9.4.1-bin.zip -d /opt/
# create a symbolic link (symlink) for future upgrades
sudo ln -s /opt/gradle-9.4.1 /opt/gradle
# make Gradle binary available system‑wide and save that config in a shell script that runs automatically for every user login
echo 'export PATH=/opt/gradle/bin:$PATH' | sudo tee /etc/profile.d/gradle.sh
# source the script for the current session
source /etc/profile.d/gradle.sh
# check Gradle version
gradle -v
```  

SDKMAN:
```bash
# install SDKMAN
curl -s "https://get.sdkman.io" | bash
# source SDKMAN init script
source "$HOME/.sdkman/bin/sdkman-init.sh"
# install Gradle
sdk install gradle
# check Gradle version
gradle -v
```  

Now we can `cd` into the desired project folder and clone the Java Gradle project:  
`git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-app.git`  

>[!note]  
>Depending ou your IDE, you might need to configure it to use your local installation of Gradle.  

To build this Java Gradle application, `cd` into the project folder and run `gradle build`.  
You'll get a "BUILD SUCCESS" message if all goes well.  

### Setting up the React Node.js project

We saw how to set up a Java Maven project and a Java Gradle project.  
Now, let's see how to set up a React Node.js project.  

React is a JavaScript library for building user interfaces (frontend).  
Node.js is a JavaScript runtime environment that executes JavaScript code on the server-side (backend).  

- from the CLI, `cd` into the folder where you want to clone the project
- clone the project: `git clone https://github.com/techworld-with-nana/react-nodejs-example.git`
- install Node.js if not already installed: `sudo dnf install nodejs`
- check Node installation: `node -v`
- install NPM if not already installed: `sudo dnf install npm`
- check NPM installation: `npm -v`

>[!note]  
>Depending on your OS, npm might be automatically installed when you install Node.js.  

- change directory to the project folder: `cd react-nodejs-example`
- `code .` to open the project in VSCodium
- from inside the project folder, run `npm install` to install dependencies

## Build an artifact

Building an artifact = packaging an application into a single file  
Artifacts are just packaged versions of your application code.  

To build an artifact, a movable file that contains all the code and dependencies of a project, we use 
a **build tool** that is specific to the programming language used in the project.  

As we saw in our previous example, a Java project artifact can be built using Maven and Gradle.  
But what do these tools do? And how do they build an artifact?  

These tools install the dependencies, they compile your whole code and compress it to reduce the size of the artifact.  
They can also run other tasks.  

### Maven vs Gradle

- **Language**: Maven uses **XML** while Gradle uses **Groovy** (more convenient for scripting)
- Both have a CLI tool and commands to execute various tasks (installing deps, compiling, building artifacts, etc.)
- `gradle build` will generate a .jar file inside the `build/libs` folder
- `mvn package` will generate a .jar file inside the `target` folder

## Build Tools for Development (managing dependencies)

Build tools are not just for building artifacts.  
Developers need these same build tools on their local machine when developing the application.  

They allow them to run and test their application locally before it's ready to be packaged and deployed on some server.  

Maven and Gradle both have their own **dependencies file**, where the dependencies and their version are defined.  
- Dependencies file for Maven is `pom.xml`
- Dependencies file for Gradle is `build.gradle`

### Where do these dependencies (deps) come from?

Gradle and Maven use the same dependency repositories, like https://mvnrepository.com, to find dependencies.  

Let's say you need a library to connect your Java application to ElasticSearch:
- You find a dependency for that in the remote Maven repository
- You add the dependency to your `pom.xml` file by specifying its name and version
- It gets downloaded and installed in your **local repository**

When we use Maven or Gradle to build an artifact, the dependencies listed in our `pom.xml` or `build.gradle` file 
are automatically downloaded before the build process starts.  

When you add a new dependency to your dependencies file, most code editors detect it and make you synchronize 
your dependencies in order to download the missing dependency from the remote repo to your local repo.  

The **local repository** where all of your dependencies live is usually in your home folder: `~/.m2/repository`

## How to run the Application?

Now let's say we built an artifact, and we stored it in an artifact repository.  
How do we run the application with this artifact?  

The command for executing a .jar file is: `java -jar <artifact_name>.jar`  

If you're on a fresh server where you have Java installed, you can download the artifact from the repository, 
and then start the application with `java -jar <artifact_name>.jar`.

---

## Build JavaScript applications

JavaScript (JS) doesn't have such a special artifact type like Java does.  
A JS application can be packaged into a `.zip` or `.tar` file.  

For JS applications, the tools we use are **npm** and **yarn**.  
npm is much more widely used and popular, but they are very similar tools.  

npm and yarn both use the same `package.json` file to manage dependencies.  
(While Maven uses `pom.xml` and Gradle uses `build.gradle`).  
Each dependency required by our application is listed in that `package.json` file: name and version.  

Note that npm and yarn are **package managers**, NOT build tools like Gradle and Maven.  
Their job is to install dependencies, they're not used to build the application, nor to transpile and then build the artifact.  

For that reason, when we build a JS application artifact, either we do not transpile it and compress it, 
or we use other tools to do that because npm and yarn do not have commands for that.  

To install dependencies via npm or yarn, we use the `npm install` or `yarn install` command.  
This will install all dependencies listed in the `package.json` file.  

Both npm and yarn use the npm repository: https://www.npmjs.com/  
Which is pretty similar to the Maven repository: https://mvnrepository.com/  

Most useful `npm` commands are:
- `npm install` to install dependencies
- `npm start` to run the application
- `npm stop` to stop the application
- `npm test` to run tests
- `npm publish` to publish the artifact

### What does the .zip/.tar file include?

Once we've packaged/built our application into a `.zip` or `.tar` file, that artifact mostly contains the application code.  
It does NOT include the dependencies because those are managed by the package manager.  

>[!note]  
>There are modules for npm and yarn that give them the ability to include dependencies in the artifact.  
>But by default, dependencies are not included.  

Which means that whenever we want to run the artifact on a server, we first have to install dependencies.  
Then we can unpack the .zip/.tar file and run the application.  

We can copy the artifact and the package.json file to the server.  
Or we can include the package.json file in the artifact to have them both in one file.   

### Creating an artifact file from a NodeJS application

We can simply execute `npm pack` to create the artifact file. This will generate a `.tgz` file that contains: 
- the application code, 
- the package.json file, 
- maybe other files such as a Dockerfile, or a README.md

Of course, we can configure what gets packaged into the artifact, what gets excluded, and the package name.  

>[!note]  
>A .tgz file is essentially a TAR archive compressed with Gzip, so .tgz is just a shorthand for .tar.gz  

### Running a JS application locally

Via npm or yarn, we can run the application with `npm start` or `yarn start`.  
Both commands execute the "start" script defined in the package.json file's "scripts" section.  

### JavaScript vs Java

Compared to the Java ecosystem, the JavaScript world is much more flexible.  
It's not as structured and standardized.  

That's why developers working on JS applications decide themselves how they want to create their artifacts, 
which tools they want to use, whether they package the dependencies or the package.json in the artifact, etc.  

### What about Frontend JS?

We saw an example for backend JS code (Node.js is a server-side runtime environment).  

What if we want to create a frontend JS app, developing a React application for example?  

To package a fullstack application, we can choose different approaches:
- package the frontend code and backend code separately, having separate artifacts
- package both together, and have a common artifact 

The same goes for handling dependencies: 
- separate package.json files for frontend and backend
- common package.json file

#### Dependency version

In a package.json file, the version numbers indicate importance as follows: MAJOR.MINOR.PATCH  

The arrow symbol in `^4.0.2` means "the latest minor or patch version but nothing above 4 for the major version".  
This helps keep things updated without risking any breaking changes caused by major version updates.  
This way, we always get the latest bug fixes and new features for version 4 of the dependency.  

#### Frontend requirements

Frontend/React code needs to be transpiled, because otherwise web browsers won't understand it.  
Browsers don't support latest JS versions of other fancy code decorations like JSX (React).  

It also needs to be compressed/minified, so it's not too large for the browser to download.  
In order to load the app faster in the browser, we need to shrink the size of CSS and JS files.  

There are separate tools (from npm/yarn) for transpiling and compressing.  
We call them Build Tools or Bundlers, most popular being **Webpack**, **Vite**, or Parcel.  

With tools like Webpack, you can build both backend and frontend, and you can do all sorts of things.  

And in case our fullstack application has a React frontend and a Java backend, same concepts apply.  
You can build the frontend application using Webpack and manage its dependencies using npm or yarn.  
However, you would package the whole application in a .war file.  

## Common concepts 

These concepts of dependency management, building the application artifact, etc. apply to all programming languages.  

These tools we've described follow common patterns:
- package managers for dependency management
- repository for hosting and downloading dependencies
- commands to install dependencies, run the application, and build the artifact

## How to publish an artifact into artifactory?

**Artifactory** = Artifact repository  
Popular examples: Nexus, JFrog 

Build tools like Maven, Gradle, npm and yarn have commands for publishing/pushing artifacts.  
And when you need the artifact fetched on your server, you can use commands such as `curl` or `wget`.  

## Build Tools & Docker

Building and moving different artifact types was made much easier with Docker.  
Thanks to Docker, we now work with only one type of artifact for all our applications, no matter the programming language.  
And this **universal artifact** type is the **Docker image**.  

Building a Docker image = "Dockerizing" or "containerizing" the application.  
Docker images are self-contained, they contain everything needed to run the application.  

We no longer need for a repository for each artifact type.  
We just need a repo that supports Docker images.  

No need to install dependencies on the target server, we copy the `package.json` file and run `npm install` inside 
the Docker image, as part of the container creation process.  

No need to install npm or Java on the target server, we can start the application directly from the Docker image.  

We can even pass the environment variables that we need by defining them in the **Dockerfile**, which is the file format 
used to build Docker images.  

>[!important]  
>Using Docker doesn't prevent us from having to build the application (package it).  
>Once we've built our artifact, we can create a Docker image out of it.  

The artifact that results from the build process needs to get packaged into the Docker image.  
So it's a double packaging process so to say.  

### Example Dockerfile for a Node.js application

```dockerfile
FROM node:25-alpine

RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY package*.json ./
RUN npm install --only=production

COPY app/* ./

CMD ["node", "server.js"]
```

Explanation:
- We specify the base image: `node:25-alpine` = lightweight Linux distro with Node.js 25 preinstalled
- We create a directory called `/usr/app`
- We set the working directory to `/usr/app`
- We copy the `package.json` and `package-lock.json` files to the working directory
- We install the dependencies (`--only=production` is for not installing dev dependencies)
- We copy the source code of the application to the working directory
- We specify the command to start the application: `CMD ["node", "server.js"]`

>[!important]  
>In this simple example, we don't build the app before copying files into the Docker image.  
>Later on, we'll see how to make a **multi-stage build** to significantly reduce the size of the Docker image.  
>We'll also talk about "**layer caching**" to reduce the time it takes to build the Docker image.

### Dockerfile for a Java application

Instead of copying the Java files to the image, we've built the app first outside of the Docker image.  
And once we have the .jar file, we copy it to the future Docker container file system.  
```dockerfile
FROM amazoncorretto:17-alpine-jdk

EXPOSE 8080

WORKDIR /usr/app
COPY ./build/libs/java-app-1.0-SNAPSHOT.jar ./

ENTRYPOINT ["java", "-jar", "java-app-1.0-SNAPSHOT.jar"]
```

## Build Tools for DevOps

