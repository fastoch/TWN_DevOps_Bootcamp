# Exercises for Module "Artifact Repository Manager with Nexus"

## Exercise 1 - install Nexus on a server

### Create a cloud server

- I can create a droplet on DigitalOcean that has the following specs:
  - region: closest to you
  - Ubuntu LTS
  - Basic plan
  - CPU options > Regular
  - 8 GB RAM / 4 vCPUs

On AWS, an Ubuntu m7i-flex.large (EC2 instance) could be enough to run Nexus.  
That's what I'll go with for this exercise, with a 20 GB SSD.  

>[!important]
>Nexus will be used in Docker and Jenkins modules as well, which are modules 7 and 8.  
>This means we need to keep the droplet that runs Nexus until then, which will incur costs.  
>To reduce costs, we cannot simply stop the VM like we would do with an EC2 instance on AWS.   
>We must snapshot the Droplet, then delete it.  
>When we need it again, we can recreate a new Droplet from that snapshot.   

### Log in to the server

- once I've create a cloud server, I must allow SSH access by adding a rule to its firewall:
  - Inbound rule > type: SSH > protocol: TCP > port: 22 > sources: my laptop's public IP
- I've previously created a key pair on AWS and saved it to my local machine
- I can SSH into the EC2 instance: `ssh -i /path/to/my-key.pem ubuntu@<EC2_instance_public_IP>`

>[!warning]
>Every time you stop an EC2 instance, its public IP address will change.  
>That means you'll need to update the SSH command to use the new IP address.

### Install Nexus

>[!note]
>The latest version of Sonatype Nexus Repository (3.87.0 and later) bundles its own Java 21 runtime in official installers and Docker images, so you typically don't need to install or configure a separate Java version on your system.  

- then enter the opt folder: `cd /opt`
- and download Nexus package from official source:  
  `sudo wget https://download.sonatype.com/nexus/3/nexus-3.91.1-04-linux-x86_64.tar.gz`
- extract the package: `sudo tar -xvzf nexus-3.91.1-04-linux-x86_64.tar.gz`
- we now have 2 directories: `nexus-3.91.1-04` and `sonatype-work`
- remove the tar file: `sudo rm nexus-3.91.1-04-linux-x86_64.tar.gz`

### Create a service account for running Nexus

- `sudo adduser nexus`
- run `ls -l /opt` to see that the owner of the `nexus-3.91.1-04` and `sonatype-work` folders is root
- make service account the owner via `sudo chown -R nexus:nexus /opt/nexus-3.91.1-04 /opt/sonatype-work`
- to make sure that Nexus runs as the user `nexus`, create and edit the Nexus config file:
  - `sudo vim /opt/nexus-3.91.1-04/bin/nexus.rc` 
  - add the following: `run_as_user="nexus"`
  - write and quit

### Run Nexus

- switch to nexus user: `su - nexus` (password required)
- run `/opt/nexus-3.91.1-04/bin/nexus start`
- make sure it's running: `ps aux | grep nexus`
- identify the id of the process which nexus is running in (PID)
- run `ss -lntp` to see the port that Nexus is listening on (thanks to Nexus PID)
- port should be 8081

### Access Nexus from a browser

- in the EC2 instance firewall settings (since I'm using AWS), add an inbound rule for port 8081
  - menu EC2 > security groups > inbound rules
- I can access the app from my browser at: `http://<Nexus_instance_IPv4_public_address>:8081`

### Logging in to my Nexus instance

- default username is admin
- use the generated admin password located at: `/opt/sonatype-work/nexus3/admin.password`
- once logged in, a wizard prompts you to define a new password for the admin account

## Exercise 2 - create npm hosted repository

For a Node application on which team 1 is working, we must create a new npm hosted repository:  
- first, need to create a new blob store for the future repo: 
  - in Nexus UI > Settings > Repository > Blob Stores > create blob store
  - type: file
  - name: my-store
- now we can create a npm hosted repo that uses that blob store:
  - Settings > Repository > Repositories > create repository
  - select recipe > npm (hosted)
  - name: repo1
  - select the blob store we've just created
  - click "Create repository"

## Exercise 3 - create user for team 1

You need to create a Nexus user for the project 1 team to have access to the npm repository.  

First, create a role for this user:
- Settings > Security > Roles > create role
- type: Nexus role
- name: team1
- privileges: `nx-repository-admin-npm-repo1-*` and `nx-repository-view-npm-*-*`
- save

Then, create the user and assign the new role to it:
- Settings > Security > Users > create local user
- username: user_one
- password: user_one
- role: team1
- click "Create local user"

## Exercise 4 - build and publish npm tar

To test what we've configured so far, we'll build and publish a node.js tar package to the npm hosted repo.  
To do that, we'll use the NodeJS app from Module 5 (Cloud Basics).   

We had already cloned the repo for this NodeJS app, the project folder is cloud-basics-exercises.  
We had also already packaged the app into a tar file via the `npm pack` command.  
In my case, the resulting tar file is in ~/DevOps/cloud-basics-exercises/app/ and it's `bootcamp-node-project-1.0.0.tgz`.  

To publish this tar file to our npm hosted repo in Nexus:
- from my laptop: `npm login --registry=http://<Nexus_IPv4_public_address>:8081/repository/repo1`
- change directory to the app folder: `cd ~/DevOps/cloud-basics-exercises/app/`
- then: `npm publish --registry=http://<Nexus_IPv4_public_address>:8081/repository/repo1 bootcamp-node-project-1.0.0.tgz`

The generic syntax is:
- `npm login --registry=http://{nexus-instance-ip}:8081/repository/{repo-name}/`
- enter the username and password for the Nexus user we've just created
- `npm publish --registry=http://{nexus-instance-ip}:8081/repository/{repo-name}/ {package-name}.tgz`  

The repo URL can be easily be found in Nexus UI > Settings > Repository > Repositories > [repo_name]  

I got a `npm error Unable to authenticate, need: BASIC realm="Sonatype Nexus Repository Manager"` when trying to publish.  
To fix this:
- Go to Nexus UI (as admin)
- Navigate to Security > Realms.
- Move 'npm bearer Token Realm' to the active realms
- save

Once the tar file got published to the npm hosted repo, you can see it in Nexus UI > Browse > repo1

## Exercise 5 - Create maven hosted repository

For a Java application on which team 2 is working, we need to create a new maven hosted repository:
- in Nexus UI > Settings > Repository > Repositories > create repository
- select recipe > maven2 (hosted)
- name: repo2
- select the same blob store as the npm hosted repo
- click "Create repository"

## Exercise 6 - create user for team 2

Now, we need to create a Nexus user for the other team to have access to this maven repository:
- create a role named team2
- privileges: `nx-repository-admin-maven2-maven-central-*` and `nx-repository-view-maven2-*-*`
- save
- create a user named user_two
- role: team2
- pwd: user_two

## Exercise 7 - build and publish jar file

We will build and publish the jar file to the new maven repository using the team 2 user.  
For that, we'll use the java-app application from the "Build Tools" module (module 4):  
- change directory to the desired folder: `cd ~/DevOps/` in my case
- clone the repo: `git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/java-app`

### Configure build.gradle file

- in the `build.gradle` file, change the app version from SNAPSHOT to `version '1.0.0'`
- in that same file, change java version from 17 to 25 (can't install Java 17 on my laptop):
```
java {
  toolchain {
    languageVersion = JavaLanguageVersion.of(25)
  }
}
```
- then add maven plugin in the `build.gradle` file, right after the `java` block:
```
apply plugin: 'maven-publish'
```
This plugin will allow us to publish the jar file to the maven hosted repo.  
- Finally, add the following `publishing` block in the `build.gradle` file:
```
publishing {
  publications {
    mavenJava(MavenPublication) {
      artifact("build/libs/java-app-$version" + ".jar"){
        extension 'jar'
      }
    }
  }
  repositories {
    maven {
      name = "nexus"
      url = "http://35.181.45.149:8081/repository/repo2/"
      allowInsecureProtocol = true
      credentials {
        username project.repoUser
        password project.repoPassword
      }
    }
  }
}
```  
Of course, we need toreplace {nexus-ip} with the IP address of our Nexus server and {repo-name} with the name of the maven hosted repo we've created.  

### Configure gradle.properties file

For security reasons, because that `build.gradle` file is included in version control, we cannot write the username and password directly in the file.  

We need to create a separate file to store them: the `gradle.properties` file.  
- create a file named `gradle.properties` at the root of the project (java-app folder)
- add the following lines to the file:
```
repoUser=user_two
repoPassword=user_two
```

### Configure settings.gradle file

Finally, we need to check the name of the application, which is defined in the `settings.gradle` file:
```
rootProject.name = 'java-app'
```
This setting will be used to generate the name of the .jar file. 

### Build and publish

Now, we can build the jar file and publish it to the maven hosted repo.  
First, make sure to be inside the java-app folder: `cd ~/DevOps/java-app`

Since I've used Vim to edit build.gradle, gradle.properties and settings.gradle, I need to run a clean build:
- build the artifact: `gradle clean build --refresh-dependencies`

>[!note]
>The build process can take a minute or more, depending on the size and complexity of the project.  

Once the build is done, we can:
- publish the jar file to the maven hosted repo: `gradle publish`
- access Nexus UI to check that the jar file got published to the maven hosted repo: Browse > Repositories > repo2

## Exercise 8 - Download from Nexus and start application

- Create a new user in Nexus UI, and grant it both of the roles previously created
In my case, the new user is `user_three` and has both roles `team1` and `team2`

### Using Nexus API

From my laptop, or from any other machine that is authorized to access Nexus instance (firewall settings > inbound rules), I can use Nexus Rest API to fetch the download URL for the latest NodeJS app artifact:
`curl -u user_three:user_three -X GET 'http://[my_nexus_IP]:8081/service/rest/v1/components?repository=repo1&sort=version'`
- create a folder for the NodeJS app: `mkdir nodejs-app`
- cd into the folder: `cd nodejs-app`
- install nodejs and npm if not already installed
- copy the `downloadUrl` value from the response to fetch the latest artifact itself: 
`curl [downloadUrl_value] --output bootcamp-node-project-1.0.0.tgz`

### Running NodeJS app

- unpack the downloaded artifact: `tar -xvzf bootcamp-node-project-1.0.0.tgz`
- cd into the unpacked directory: `cd package`
- install dependencies: `npm install`
- run the app (in detached mode) on my EC2 instance: `node server.js &`

When starting the Node app, I see that it's listening on port 3000.  
I can type `localhost:3000` in my web browser to see the app's home page!  

## Exercise 9 - Automate

We decide to automate the fetching from Nexus and starting the application.  
For that, we need to write a script that:
  - fetches the latest version from npm repository
  - untar it and run the app on the machine where the artifact got downloaded
- Execute the script to fetch the artifact and run the application

- remove any pre-existing files in the target folder: `rm -rf ~/DevOps/nodejs-app/*`
- create a file named `fetch_and_run.sh` in the target folder
- change the file permissions: `chmod +x fetch_and_run.sh`

Here's the script that I wrote in `fetch_and_run.sh`:
```bash
#!/bin/bash

# Get the download URL for the latest version of the NodeJS app artifact
download_url=$(curl -u user_three:user_three -X GET 'http://[my_nexus_IP]:8081/service/rest/v1/components?repository=repo1&sort=version' | )

# Fetch the latest version of the artifact from npm repository
curl $download_url > '
```  

- run it: `./fetch_and_run.sh`
- open a web browser and go to `localhost:3000` or `<IPv4_public_address>:3000` to see the app's home page
- in case you're using a cloud server, make sure that port 3000 is open (firewall > inbound rules)