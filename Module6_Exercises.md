# Exercises for Module "Artifact Repository Manager with Nexus"

## Exercise 1 - install Nexus on a server

- create a droplet on DigitalOcean that has the following specs:
  - region: closest to you
  - Ubuntu LTS
  - Basic plan
  - CPU options > Regular
  - 8 GB RAM / 4 vCPUs
  - 160 GB SSD Disk

On AWS, an Ubuntu m7i-flex.large VM (EC2 instance) could be enough to run Nexus.  
That's what I'll go with for this exercise.  

---

>[!important]
>Nexus will be used in Docker and Jenkins modules as well, which are modules 7 and 8.  
>This means we need to keep the droplet that runs Nexus until then, which will incur costs.  
>To reduce costs, we cannot simply stop the VM like we would do with an EC2 instance on AWS.   
>We must snapshot the Droplet, then delete it.  
>When we need it again, we can recreate a new Droplet from that snapshot.   

---

- once you have a cloud server, allow SSH access by adding a rule to its firewall:
  - Inbound rule > type: SSH > protocol: TCP > port: 22 > sources: my laptop's public IP
- I've previously created a key pair on AWS and saved it to my local machine
- SSH into the EC2 instance: `ssh root@<EC2_instance_public_IP_address>`

>[!note]
>The latest version of Sonatype Nexus Repository (3.87.0 and later) bundles its own Java 21 runtime in official installers and Docker images, so you typically don't need to install or configure a separate Java version on your system.  

- enter the opt folder: `cd /opt`
- download Nexus package: `wget https://download.sonatype.com/nexus/3/nexus-3.91.1-04-linux-x86_64.tar.gz`