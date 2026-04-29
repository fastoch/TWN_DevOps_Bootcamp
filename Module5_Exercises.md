# Exercises for Module "Cloud & IaaS - DigitalOcean"

Use repository: https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises

You are asked to create a simple NodeJS app that lists all the projects each developer is working on.  
Everyone on your team wants to be able to see the list themselves and share with the project managers, 
so they ask you to make it available online, so everyone can access it.

# Exercise 0 - Clone Git repo

- clone the repo: `git clone git@gitlab.com:twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises.git`
- go to the project folder: `cd cloud-basics-exercises`
- remove the repo ref to make it your own: `rm -rf .git`
- initialize a new git repo: `git init`
- stage all files: `git add .`
- commit the files: `git commit -m "Initial commit"`
- create my own remote repo: `git remote add origin git@gitlab.com:fastoch/TWN-mod5-cloud-exercises.git`
- push to my remote repo: `git push -u origin master`

# Exercise 1 - Package NodeJS App

To have just 1 file, you create an artifact from the Node App.  
To package our Node app into a .tgz file:
- Make sure your app has a valid `package.json`, since `npm pack` builds the tarball from that manifest.
- while being in the project folder, go to the app folder where the package.json lives: `cd app`
- run `npm pack` to build the tarball
- run `ls -l` to see the `bootcamp-node-project-1.0.0.tgz` file that was just created

# Exercise 2 - Create a VM on an IaaS platform

I chose to use AWS instead of DigitalOcean, since Amazon lets you spin up an Ubuntu VM at no cost: 
- I've created an account on AWS
- Once logged in to it, I've selected the closest region
- I've created an EC2 instance (t3.micro) which is free tier eligible:
  - I've selected the Ubuntu 26.04 image
  - I've created a security group to allow SSH traffic from my laptop (after checking its public IP address)
  - I've created a key pair and saved it to my local machine (.pem file)

For Ubuntu EC2 instances, root login is disabled by default.  
For accessing my VM using SSH, we must use `ubuntu` as the username instead of `root`:
- copy the Public IPv4 address of the EC2 instance from the AWS UI
- set correct permissions for my key: `chmod 400 /path/to/your-key.pem`
- run `ssh -i /path/to/my-key.pem ubuntu@<EC2_VM_public_IP>`
- You'll get a "Welcome to Ubuntu" message on successful connection

The `-i` flag is for specifying the identity file (the private key file) to use for authentication.  

>[!note]
>Ubuntu AMI stands for Ubuntu Amazon Machine Image.

# Exercise 3 - Prepare the VM to run a Node App

Now you have a new fresh server with nothing installed on it.  
Since you want to run a NodeJS application, you need to install Node and npm on it:
- ssh into the VM: `ssh -i /path/to/my-key.pem ubuntu@<EC2_VM_public_IP>`
- update the package list: `sudo apt update`
- if some packages are outdated, upgrade them: `sudo apt upgrade`
- install Node and npm: `sudo apt install nodejs npm`

# Exercise 4 - Copy the app artifact from your laptop to the VM

- create the future destination folder for your app: `mkdir app`
- exit the SSH session: `exit`
- cd into the project folder: `cd ~/DevOps/cloud-basics-exercises`
- secure-copy the app folder to the EC2 VM:  
```bash
scp -i /path/to/my-key.pem app/bootcamp-node-project-1.0.0.tgz ubuntu@<EC2_VM_public_IP>:~/app
```
- ssh into the VM: `ssh -i /path/to/my-key.pem ubuntu@<EC2_VM_public_IP>`
- check if the app folder exists and what it contains: `ls -al app/`

# Run Node App

- start the Node app in detached mode

# Exercice solutions

You can find example solutions here:  
https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises/-/blob/feature/solutions/Solutions.md