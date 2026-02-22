# Intro

These are my notes from learning the DevOps engineer profession thanks to Nana Janashia's DevOps Bootcamp.

---

# Operating Systems & Linux Basics (module 2/16)

## What Operating Systems are for?

OS are acting as intermediaries between applications we use (software) and physical components (hardware).

## Virtualization

Virtualization removes the need for physical hardware to install and run an OS.  
You can install any OS on top of any other OS thanks to something called a hypervisor.  

A hypervisor is a technology that allows hosting multiple virtual computers on a physical computer.  
It uses physical resources (CPU, RAM, storage, I/O devices) to create virtual machines (VMs).  

VMs, even if running on the same host system, don't see each other, they're completely isolated.  
And if something breaks inside a VM, it does not affect the host system.  
Plus, it's very easy to delete the faulty VM and spin up a new one; with snapshots we can even create the exact same one.  

### Benefits of using VMs

- you don't need to buy a new computer
- it's ideal to learn and experiment
- you don't endanger your main OS
- you can test your app on a specific OS

### Type 2 Hypervisor

This type of hypervisor is installed on an existing OS that runs on a physical machine.  
One of the most popular Type 2 hypervisors is VirtualBox.  

Hardware > Host OS > Type 2 Hypervisor > VMs (Guest Operating Systems)  

Type 2 hypervisors are typically used on Personal Computers.

### Type 1 Hypervisor

This type of hypervisor is installed directly on a physical machine, it does not require an OS to run on.  
It is called a "**bare metal**" hypervisor.  
Most populare type 1 hypervisors are VMware ESXi and Microsoft Hyper-V.  

Hardware > Type 1 Hypervisor > VMs  

Type 1 hypervisors are typically used on big **servers**.  
Big companies and Cloud providers use this type of hypervisors.  
For example, when we create an EC2 instance on **AWS**, a type 1 hypervisor installed on a big physical server will spin up a VM for us.  

**Note**: both type 1 and type 2 hypervisors need to access hardware resources, but type 2 do it through an OS.  

### Why do cloud providers and large companies use VMs?

- Efficient usage of hardware resources
- users can choose resource combinations that fit their needs
- Abstraction of the OS from the hardware

That last benefit is very important, because before virtualization, the OS was tightly coupled to the hardware it was running on.  
Which means in case of hardware failure, you had to replace the entire server, reinstall applications, reconfigure the whole thing, and potentially 
risk losing critical data in the process depending on your backup policy reliability.  

With virtualization, you have your server as a portable file that you can move around = a Virtual Machine image.  
This VM image contains the OS, all the applications, the required configuration, and all the data you want to store on your server.  

And since it's a file, you can easily make copies of it = snapshots.  
These snapshots can then be used on any computer that has enough resources to run them and a compatible hypervisor.

## Linux File System vs Windows'

Linux File System has a hierarchical tree structure.  
We have one root folder which contains all other folders and files.  

In comparison, the Windows file system does not have one root folder where all the folders stem from.  
It rather has multiple root folders.  
When PCs only had insertable floppy disks, Windows used letters to assign drives for each insertable disk slot.  
Letters A and B were used for removable disks, and Windows used C: when internal hard drives appeared.   

## Linux File System Overview



---

# 3. Version Control with Git (module 3/16)
