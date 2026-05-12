# Exercises for Module "Artifact Repository Manager with Nexus"

## Exercise 1 - install Nexus on a server

- create a droplet on DigitalOcean that has the following specs:
  - region: closest to you
  - Ubuntu LTS
  - Basic plan
  - CPU options > Regular
  - 8 GB RAM / 4 vCPUs
  - 160 GB SSD Disk

---

>[!important]
>Nexus will be used in Docker and Jenkins modules as well, which are modules 7 and 8.  
>This means we need to keep the droplet on Digital Ocean that runs Nexus until then, which will incur costs.  
>To reduce costs, we cannot simply stop the VM like we would do with an EC2 instance on AWS.   
>We must snapshot the Droplet, then delete it.  
>When we need it again, we can recreate a new Droplet from that snapshot.   

---

