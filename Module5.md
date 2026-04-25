# 5. Cloud & Infrastructure as a Service (IaaS) Basics with DigitalOcean

## Module Overview

- We will create a virtual server on a cloud provider (DigitalOcean)
- We'll then deploy an app on this server and configure access to it
- We'll learn about common concepts and best practices when working with cloud infrastructure

## Setting up a server on DigitalOcean

On DigitalOcean, servers are called **droplets**.  
- sign up on https://cloud.DigitalOcean.com
- sign in and add a payment method
- go to the **Droplets** menu
- click on "Create Droplet"
- choose your closest region
- we'll use the default Ubuntu image
- choose the Basic plan
- CPU options > Regular
- plan > the cheapest ($4.00/month, $0.006/hour): 1 vCPU, 512 MB RAM, 10 GB SSD
- **Authentication > SSH key**
  - similar to what we did for GitLab, we'll create a key pair on our laptop for DigitalOcean
  - name the key so that you know it's for DigitalOcean
  - run `cat ~/.ssh/id_ed25519_DigitalOcean.pub` on your machine to display the public key 
  - copy the public key
  - on DigitalOcean platform, click on "Add an SSH key"
  - paste the public key
- click on "Create Droplet"

You can go to Settings > Security to see your SSH key.  
SSH keys on DigitalOcean can be added separately from droplet creation.  

To see your newly created droplet, go to the **Droplets** menu.  
By clicking on your droplet instance, you can see its public IP address.  

>[!warning]
>On DigitalOcean, when you create a server, it is publicly accessible on all ports.  
>No firewall protection is implemented by default 😱😱😱

### Firewall configuration

We're going to close all ports and then selectively open the ones we need.  
First, we need to open port 22 to allow access to our server via SSH.  

To do that, from the Networking menu on DigitalOcean: 
- go to the **Firewalls** tab
- click on **Create firewall**
- name it as you wish

By default, there's already an inbound rule for SSH access on port 22 (TCP)
- in the allowed sources, we should remove access for any IPv4/IPv6 address 
- and then add authorized public IP addresses (such as your laptop's)

>[!warning]
>Keep in mind that the public IP address of your laptop might be dynamically assigned.  
>In which case, you'll need to update that list of authorized IP addresses (inbound rules).  
>If your public IP address is always comprised within a specific range, you can provide that range in the list of authorized IP addresses.

Once you're done configuring that firewall, click on "**Create Firewall**".  

After the firewall is created, you can see it in the **Firewalls** menu.  
If you click on that firewall, you can then apply it to your droplet:
- from the firewall view, go to the **Droplets** tab
- click on "**Add Droplet**"
- search for your droplet and add it

Now, from the droplet view, go to the **Networking** menu and scroll down till the Firewalls section.  
You'll see the Inbound and Outbound rules currently applied to your droplet.  

Of course, we don't need to be restrictive regarding the Outbound rules.  
By default, any outgoing traffic is allowed: ICMP, TCP and UDP to all ports of any IPv4/IPv6 address.  

For now, inbound rules should only allow incoming traffic from your laptop for SSH access on port 22.  

### SSH connection from your laptop

- copy the public IP address of your droplet
- from your laptop, open a terminal and run `ssh root@<IPv4_public_address>`
- say "yes" to confirm that you want to connect to the remote host
- you're connected to your droplet as root!
- while being connected to the droplet as root, run `apt update`
- after that, you can install any package you need using `apt install <package_name>`

## Deploy and run an application on your Droplet server

Link to the java-react project used in this chapter is:  
https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/java-react-example  

On your laptop, clone the project:  
`git clone https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/java-react-example.git`
- change directory to the project folder: `cd java-react-example`
- install versions of java and gradle that are compatible with the project
- build the artifact on your laptop: `gradle build`

Inside the project folder, go to `/build/libs` to see the .jar file created by Gradle.  

- secure copy the .jar file from your laptop to the droplet:  
`scp build/libs/java-react-example.jar root@<IPv4_public_address>:/path/to/destination`

To run the Java-React app on your Droplet server:
- `ssh` into the droplet
- run `apt update` to update the package index
- run `apt install <java_package_name>` to install the desired version of Java
- change directory to the folder where you copied the .jar file: `cd /path/to/destination`
- start the app: `java -jar java-react-example.jar`

You should see the port which your app's web server is listening on.  
It's an Apache Tomcat server listening on port 7071.  

### Accessing the app from a web browser 

- on your laptop, open a web browser and go to DigitalOcean
- go to the Networking menu > Firewalls
- click on the firewall you created earlier
- in the inbound rules, add a new rule to allow access to port 7071:
  -  Type: custom
  -  Protocol: TCP
  -  Port range: 7071
  -  Sources: all IPv4/IPv6 addresses
  -  Save
- go to your droplet's view and copy its public IP address
- paste it in your web browser followed by `:7071`
- you should see the app's home page

You've successfully deployed an application on a DigitalOcean droplet.  
And then you were able to access it from a web browser!   

### Running the app in detached mode

While being connected to the droplet via SSH, run `java -jar java-react-example.jar &`.  
This allows you to keep using the same terminal while the app is running in the background.  

This way, you can check which **process** the app is running in: `ps aux | grep java`  

With `netstat`, you can also see which port the app is listening on: 
- install netstat: `apt install net-tools`
- run `netstat -lpnt | grep java` 
In the output of this command, the app can be identified via its **PID** (process ID).

## Create and configure a Linux user on a cloud server

This is not recommended to run services and applications as root.  
We should create a non-root user and run the app as that user.  

