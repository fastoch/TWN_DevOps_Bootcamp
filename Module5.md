# 5. Cloud & Infrastructure as a Service (IaaS) Basics with DigitalOcean

## Module Overview

- We will create a virtual server on a cloud provider (DigitalOcean)
- We'll then deploy an app on this server and configure access to it
- We'll learn about common concepts and best practices when working with cloud infrastructure

## Setting up a server on DigitalOcean

On DigitalOcean, servers are called **droplets**.  
- create an account on DigitalOcean
- go to the **Droplets** menu
- click on "Create Droplet"
- choose your closest region
- we'll use the default Ubuntu image
- choose the Basic plan
- CPU options > Regular
- plan > the cheapest ($4.00/month, $0.006/hour): 1 vCPU, 512 MB RAM, 10 GB SSD
- Authentication > SSH key
  - similar to what we did with GitLab, we'll create a key pair on our laptop for DigitalOcean
  - name the key so that you know it's for DigitalOcean
  - `cat ~/.ssh/id_ed25519_DigitalOcean.pub` to display the public key 
  - copy the public key
  - on DigitalOcean platform, click on "Add an SSH key"
  - paste the public key
- click on "Add Payment Method and Create Droplet"
