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
That's what I'll go with for this exercise.  

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

For a Node application, we must create a new npm hosted repository with a new blob store.  
- first, need to create a new blob store for the future repo: 
  - in Nexus UI > Settings > Repository > Blob Stores > create blob store
  - type: file
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
- username: team_one
- password: team_one
- role: team1
- click "Create local user"

## Exercise 4 - build and publish npm tar

To test what we've configured so far, we'll build and publish a node.js tar package to the npm hosted repo.  
To do that, we'll use the NodeJS app from Module 5 exercises.  

