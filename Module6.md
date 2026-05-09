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

### Creating the cloud server

>[!important]
>DO NOT use a VM with less resources than 4GB RAM / 2 vCPUs, as you will encounter performance issues if you do so.  

To create a droplet on DigitalOcean onto which you'll be able to install and run Nexus:
- select the region which is closest to you
- Ubuntu LTS
- Basic plan
- CPU options > Regular
- 8 GB RAM / 4 vCPUs
- 160 GB SSD Disk

The current cost (May 2026) is 48$/month.  

Once the droplet is created, configure the firewall > inbound rule for allowing SSH access via port 22.  

### Installing Nexus on the cloud server

Let's SSH into our droplet: `ssh root@<IPv4_public_address>`  

>[!note]
>We previously set up a SSH key pair on our local machine, so we don't need to create a new one.  
>DigitalOcean already has the public part of the key, as we've added it to create our first droplet.  
>Refer to Module5.md for more details.  

Nexus is built using **Java**, so it is typically deployed as a Java application.  
Nevertheless, you can run Nexus on a platform that supports the JVM without having to install Java separately.  

Once logged in to the droplet, let's install Java version 17, that's the specific version that Nexus supports.  
- run `java` to see that it's not installed and get suggestions of how to install it
- copy and run the suggested command that installs Java 17
- enter the opt folder: `cd /opt`
- download Nexus package: `wget https://download.sonatype.com/nexus/3/nexus-3.91.1-04-linux-x86_64.tar.gz`
  - the latest version can be found here: https://help.sonatype.com/en/download.html
- extract the package: `tar -xvzf nexus-3.91.1-04-linux-x86_64.tar.gz`
- we now have 2 directories: `nexus-3.91.1-04` and `sonatype-work`
  - the first one contains the runtime and the Nexus application itself
  - the second one contains:
    - subdirectories depending on your Nexus config
    - IP addresses that accessed your Nexus instance
    - logs
    - your uploaded files and metadata
- The `sonatype-work` folder can be used as a backup since it contains all the config and data

### Configuring the server before running Nexus

>[!warning]
>Services should not run with root user permissions.  
>The best practice is to create a dedicated user account and run the service as that user.  

The dedicated user account should only have the necessary permissions to run Nexus and interact with it.  

To create a dedicated user account for running Nexus:
- ssh into the droplet as root
- run `adduser nexus`

Now, if we run `ls -l /opt`, we can see that we need to change the ownership for the `nexus` and `sonatype-work` folders.  
Right now, the owner is root. To change the owner to the new user:   
- run `chown -R nexus:nexus /opt/nexus-3.91.1-04`
- run `chown -R nexus:nexus /opt/sonatype-work`

To make sure that Nexus runs as the user `nexus`:
- run `vim /opt/nexus-3.91.1-04/bin/nexus.rc`
- set the value for `run_as_user` to `"nexus"` and uncomment the line by removing the `#` at the beginning
- write and quit

### Running Nexus on the server

- switch from root to nexus user: `su - nexus`
- run `/opt/nexus-3.91.1-04/bin/nexus start`
- make sure it's running: `ps aux | grep nexus`
- the nexus process is the one that starts with "/usr/lib/jvm" and ends with "NexusMain" 
- identify the process id and run `netstat -lntp`
- you can see the app is accessible for external requests at port 8081

Which means that we can access the Nexus service from a browser at: `http://<IPv4_public_address>:8081`  
On the condition that this port is open on our cloud server...  

To allow incoming traffic on the port that Nexus is listening on, we need to:
- go to DigitalOcean's UI
- go to the droplet we've created for running Nexus
- configure the firewall > new inbound rule > type: custom > protocol: TCP > port: 8081
- save the new rule
- copy the droplet's public IP address
- open a web browser and go to `http://<IPv4_public_address>:8081`
- you should see the Nexus UI

For comparison, to allow SSH connection to the droplet, we configured the firewall as follows:
- Inbound rule > type: SSH > protocol: TCP > port: 22 > sources: our laptop's public IP

## 3. Intro to Nexus

There's a paid version of Nexus, but the free version should be enough in most cases, since it already gives us access 
to a lot of supported repository formats.  

We also have a default user that gets created when we deploy Nexus.  
The username is `admin` and the password can be found by running this command:  
`cat /opt/sonatype-work/nexus3/admin.password`  

We can use that admin account to sign in to the Nexus UI.  
Once logged in as admin, we can create other users and give them different permissions.  

In a big company, we can do an LDAP integration with Nexus.  
**LDAP** only handles **authentication** (verifying user identity via login credentials).  
The **authorization** is handled in Nexus UI (deciding if a user has permission to access a repository).  

Using the admin account, we can also go to the Settings page and configure the server.  

## 4. Repository Types

In lecture 2 of this module, we've installed and configured Nexus on a cloud server (a droplet on DigitalOcean).  
We've seen how to access Nexus UI from a web browser on our laptop.  
We're still in Nexus UI, logged in as admin.  

The central concept in Nexus is managing repositories (repos), after all Nexus is a repo manager.  
We can have multiple repos of different formats like Helm charts, Docker images, Java archives, JS artifacts...  

By default, we'll find the most popular repo formats in Nexus, such as maven2 (Java) or nuget (.NET).  

Repo **formats** must not be confused with repo **types**.  
Nexus includes 3 main repo types: proxy, hosted, and group.  

### Proxy repo 

This is a repository that is **linked to a remote repository**, such as Maven Central or Docker Hub.  

If a component is requested from the remote repo by our application, the request goes to the proxy repo instead of 
directly to the remote repo.  

Then, one of two things happens:
1. The component is already present (cached) in the proxy repo (on Nexus) and will be fetched from there  
2. The component is not present in the proxy, then the request is forwarded to the remote repo and the component will be 
fetched from that remote, and also cached in the proxy repo for further use  

What advantages does this have?  
- it saves network bandwidth and time for retrieving the component once it's been cached in Nexus
- it gives developers a single endpoint for multiple repos; they only need to configure it in their build tool

To configure a proxy repo on Nexus, we need to provide the URL of the remote repo that is being proxied.  

### Hosted repo 

It's a repository that lives on our Nexus server and stores the artifacts and components that we publish there.  
It's a place where we store our artifacts for internal use, such as our own libraries.  
We can also host our own custom artifacts, such as Docker images or Helm charts.

### Group repo

A virtual repository that aggregates several actual repositories and exposes them through one single URL.  
Instead of configuring our build tools (Maven, npm, Docker, etc.) to talk to multiple repos, we:
- Put those repos into a group
- Point our client to only the group URL

Nexus then searches the member repositories in order until it finds the component/image/package.

### Repo Types Summary

| Type   | Where artifacts come from                    | Typical use                                    |
| ------ | -------------------------------------------- | ---------------------------------------------- |
| Hosted | You publish/upload them into Nexus           | Internal/private artifacts, proprietary libs   |
| Proxy  | Nexus downloads from a remote repo on demand | Caching Maven Central, Docker Hub, npmjs, etc. |
| Group  | Virtual view combining hosted + proxy repos  | Single URL for clients (e.g. all Maven deps)   |

### Create new repo on Nexus

In addition to pre-existing ones that come out-of-the-box when we start Nexus, we can create our own repos.  
We can chose from all available formats and types, and combine them to create a custom repo that suits our needs.  

## 5. Publish Artifact to Repository

We'll see how to upload a .jar file from a local Maven (or Gradle) project to a Nexus repo.  
We'll use the Maven hosted repo format that comes by default with Nexus.  

For both Maven and Gradle, there's a special command for pushing to a remote repo.  
But before we execute that command, we need to configure both build tools to connect to Nexus, which requires:
- Nexus repo URL
- Credentials 

### 1. Create a Nexus user

- In Nexus UI, go to Security > Users
- default users are: admin and anonymous
- Click "Create local user"
- Fill in the user details 
  - name it as you like
  - give it nx-anonymous role for now
- Click "Create local user" at the bottom

>[!important]
>The Linux user account we created (in chapter 2) to run the Nexus service as a non-root process is separate from the Nexus Repository users managed in the UI.  

Note that in real-world scenarios, we wouldn't create users manually in the UI.  
Instead, we would use LDAP integration to import already existing users from our LDAP server into Nexus.  

### 2. Create a role for our Nexus user

This user will only need to upload maven artifacts to a Nexus hosted repo.  

- in Nexus UI > Security > Roles
- click "Create role"
- Type: Nexus role
- call it "nx-java"
- privileges selection: nx-repository-view-maven2-maven-snapshots-* (use filter to find the right one)
- scroll to the bottom and click "Save"

Now we want to assign this role to the user we've created:
- go back to Users menu
- select the user we've created to edit it
- remove previous anonymous role and add nx-java role
- click "Save"

### 3. Configure build tools to connect to Nexus

We can now configure Maven and Gradle to connect to Nexus using the new user's credentials.  
This configuration step involves 3 files: `build.gradle`, `settings.gradle`, and `gradle.properties`.  

Links to the projects used in this lecture:
- Java Gradle App: https://gitlab.com/twn-devops-bootcamp/latest/06-nexus/java-app
- Java Maven App: https://gitlab.com/twn-devops-bootcamp/latest/06-nexus/java-maven-app

#### 3.1. Configuring Java Gradle project 

We need to add a plugin to the project so we can publish a .jar file to a Maven-formatted repository:
- In the `build.gradle` file of the Java/Gradle project, add the following lines right after the `java` block:
```
apply plugin: 'maven-publish'

publishing {
  publications {
    create("maven", MavenPublication) {
      artifact("build/libs/my-app-$version" + ".jar") {
        extension 'jar'
      }
    }
  }

  repositories {
    maven {
      name 'nexus'
      url "http://[your_nexus_IP]:[your_nexus_port]/repository/[repo_name]"
      allowInsecureProtocol = true
      credentials {
        username project.nexusUsername
        password project.nexusPassword
      }
    }
  }
}
```  

The `publications` block defines the artifacts that will be published.  
The `$version` variable is set at the beginning of the `build.gradle` file.   
The `repositories` block defines the Nexus repositories where the artifacts will be published.  

In the `maven` block, we define: 
- the name of the repo manager
- the targeted Nexus repo URL (easy to copy from Nexus UI)
- `allowInsecureProtocol = true` is required because we're not accessing our Nexus repo using HTTPS
- and the credentials of the user that we've created in Nexus UI

---

>[!important]
>For security reasons, because that `build.gradle` file is included in version control, we cannot write the username and password directly in the file.  
>We need to create a separate file to store them: the `gradle.properties` file.  

- At the root of the project, create a file named `gradle.properties`.
- Add the following lines to the file:
```
nexusUsername = my_nexus_user
nexusPassword = my_nexus_user_password
```

---

Finally, we need to configure the name of the application, which is defined in the `settings.gradle` file:
```
rootProject.name = 'my-java-gradle-app'
```
This setting will be used to generate the name of the .jar file.  

#### 3.2. Building and pushing the artifact to Nexus

>[!important]
>Since we've modified the Gradle project structure, we need to sync those changes before building.  
>IDEs like IntelliJ IDEA detect changes automatically but may require manual sync (refresh).  

Once the project is synced, we can run `gradle build` to build the artifact.  
This command will generate a .jar file in the `build/libs` directory, as defined in the `build.gradle` file.  

To push the artifact to Nexus, we need to run `gradle publish`.  
This command will upload the .jar file to the Maven hosted repo defined in the `maven` block of the `build.gradle` file.  

>[!note]
>The `gradle build` and `gradle publish` commands need to be run while being inside the project folder.    
>They will be executed by the Jenkins job we'll create in the upcoming modules.  

The `gradle publish` command is not available in Gradle by default.  
We can use it now because we previously added the `maven-publish` plugin to the `build.gradle` file.  

And the `publishing {}` block we've added to the `build.gradle` file is what tells the `gradle publish` command what to publish and where to publish it.  

Once the artifact is pushed to Nexus, we can browse the UI to see it in the repo that we've specified.  

#### 3.3. Configuring Java Maven project

This time, we need to modify the `pom.xml` file instead of the `build.gradle` file.  
The logic remains the same as with the Gradle project: 
- tell Maven what file to push: location, name, version, and extension 
- where to push it: the Nexus repo URL
- provide the credentials to authenticate to Nexus as the user we've created

First, let's configure a plugin in the `pom.xml` file, same way as we did in `build.gradle`.  
This is the plugin that will enable Maven to upload the .jar file.  

Here's the code for that plugin:
```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-deploy-plugin</artifactId>
      <version>3.1.4</version>
    </plugin>
```

After adding the plugin, save the `pom.xml` file and refresh the project so that Maven can download the plugin.  

---

Next, we need to configure the location of our Nexus repo.  
We do that by adding the following to the `pom.xml` file:
```xml
<distributionManagement>
  <snapshotRepository>
    <id>nexus-snapshots</id>
    <url>http://[your_nexus_IP]:[your_nexus_port]/repository/[repo_name]</url>
  </snapshotRepository>
</distributionManagement>
```

--- 

Finally, we need to add the credentials to allow Maven to authenticate to our Nexus instance.  
This is done via the `~/.m2` folder located in your home directory.  

Inside this folder, create a file named `settings.xml`.  
This is a file where Maven global credentials can be defined (accessible to all Maven projects). 
- `cd ~/.m2`
- `vim settings.xml`
- add the following lines to the file:
  ```xml
  <settings>
    <servers>
      <server>
        <id>nexus-snapshots</id>
        <username>my_nexus_user</username>
        <password>my_nexus_user_password</password>
      </server>
    </servers>
  </settings>
  ```
- write and quit

>[!important]
>The id needs to be the same as the id we defined in the `distributionManagement` block of the `pom.xml` file.  

Now, everything is set up to upload the artifact to Nexus.  

#### 3.4. Building and Pushing the artifact to Nexus

- cd into your Java Maven project folder (where the `pom.xml` file is located)
- run `mvn package` to build the artifact
- run `mvn deploy` to push the artifact to Nexus

## 6. Nexus REST API

